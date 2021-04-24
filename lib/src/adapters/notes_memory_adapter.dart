import 'package:numerote_core/src/adapters/notes_data_adapter.dart';
import 'package:numerote_core/src/models/note.dart';
import 'package:numerote_core/src/models/label.dart';

class NotesMemoryAdapter extends NotesDataAdapter {
  final List<Note> _notes = [];
  final List<Label> _labels = [];

  @override
  Future<Note> saveNote(Note note) async {
    if (_notes.contains(note)) {
      final index = _notes.indexWhere(
        (element) => element.documentId == note.documentId,
      );
      if (index > -1) {
        _notes[index] = note.copyWith(
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
      }
    } else {
      _notes.add(note.copyWith(updatedAt: DateTime.now()));
    }

    _notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return note;
  }

  @override
  Future<void> deleteNote(Note note) async {
    _notes.removeWhere((element) => element.documentId == note.documentId);
    _notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  @override
  Future<List<Note>> getNotes({
    String lastId = "",
    int limit = 10,
    Label? label,
  }) async {
    _notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    final existingIndex = _notes.indexWhere(
      (element) => element.documentId == lastId,
    );
    final index = existingIndex == -1 ? 0 : existingIndex;
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
  }

  @override
  Future<List<Label>> getLabels() async => _labels;

  @override
  Future<Label?> createLabel(Label label) async {
    if (!_labels.contains(label)) {
      _labels.add(label);
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
