import 'package:numerote_core/src/adapters/notes_data_adapter.dart';
import 'package:numerote_core/src/models/note.dart';
import 'package:numerote_core/src/models/label.dart';

class NotesMemoryAdapter extends NotesDataAdapter {
  final List<Note> _notes = [];
  final List<Label> _labels = [];

  @override
  Future<Note?> saveNote(Note note) async {
    final index = _notes.indexWhere(
      (element) => element.documentId == note.documentId,
    );

    if (index > -1) {
      _notes[index] = note;
    } else {
      _notes.add(note);
    }

    _notes.sortByUpdated();
    return note;
  }

  @override
  Future<void> deleteNote(Note note) async {
    _notes.removeWhere((element) => element.documentId == note.documentId);
    _notes.sortByUpdated();
  }

  @override
  Future<List<Note>> getNotes({
    String lastId = "",
    int limit = 10,
    Label? label,
  }) async {
    _notes.sortByUpdated();
    final existingIndex = _notes.indexWhere(
      (element) => element.documentId == lastId,
    );
    final index = existingIndex == -1 ? 0 : existingIndex + 1;
    return _notes
        .where((element) {
          if (label == null) return true;
          return element.labels.contains(label);
        })
        .skip(index)
        .take(limit)
        .toList();
  }

  @override
  Future<void> deleteLabel(Label label) async {
    if (_labels.contains(label)) _labels.remove(label);

    for (final note in _notes) {
      note.labels.remove(label);
    }

    _labels.sortByUpdated();
  }

  @override
  Future<List<Label>> getLabels({
    String lastId = "",
    int limit = 10,
  }) async {
    _labels.sortByUpdated();

    final existingIndex = _labels.indexWhere(
      (element) => element.documentId == lastId,
    );

    final index = existingIndex == -1 ? 0 : existingIndex + 1;
    return _labels.skip(index).take(limit).toList();
  }

  @override
  Future<Label?> createLabel(Label label) async {
    if (!_labels.contains(label)) {
      _labels.add(label);
      _labels.sortByUpdated();
      return label;
    }

    return null;
  }

  @override
  Future<void> nuke() async {
    _labels.clear();
    _notes.clear();
  }
}

extension _SortNotes on List<Note> {
  void sortByUpdated() {
    sort((b, a) => a.updatedAt.compareTo(b.updatedAt));
  }
}

extension _SortLabels on List<Label> {
  void sortByUpdated() {
    sort((b, a) => a.updatedAt.compareTo(b.updatedAt));
  }
}
