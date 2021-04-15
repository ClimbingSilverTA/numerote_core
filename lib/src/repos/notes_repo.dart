import 'package:numerote_core/src/adapters/notes_data_adapter.dart';
import 'package:numerote_core/src/models/label.dart';
import 'package:numerote_core/src/models/note.dart';

class NotesRepo {
  NotesRepo({required NotesDataAdapter adapter}) : _adapter = adapter;
  final NotesDataAdapter _adapter;

  Future<List<Note>> getNotes({
    String lastId = "",
    int limit = 10,
    Label? label,
  }) async =>
      _adapter.getNotes(
        lastId: lastId,
        limit: limit,
        label: label,
      );

  Future<Note> saveNote(Note note) async => _adapter.saveNote(note);
  Future<void> deleteNote(Note note) async => _adapter.deleteNote(note);

  Future<List<Label>> getLabels() async => _adapter.getLabels();
  Future<Label?> createLabel(Label label) async => _adapter.createLabel(label);
  Future<void> deleteLabel(Label label) async => _adapter.deleteLabel(label);
}
