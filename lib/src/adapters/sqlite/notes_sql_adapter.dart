import 'package:moor/ffi.dart';
import 'package:numerote_core/src/adapters/notes_data_adapter.dart';
import 'package:numerote_core/src/models/note.dart';
import 'package:numerote_core/src/models/label.dart';
import 'package:numerote_core/src/adapters/sqlite/moor_models.dart' as moor;

class NotesSQLAdapter extends NotesDataAdapter {
  NotesSQLAdapter({bool testing = false})
      : _database = !testing
            ? moor.MoorDatabase()
            : moor.MoorDatabase(executor: VmDatabase.memory());

  final moor.MoorDatabase _database;

  @override
  Future<Label?> createLabel(Label label) async {
    final result = await _database.saveLabel(label);
    return result > -1 ? label : null;
  }

  @override
  Future<void> deleteLabel(Label label) async =>
      _database.deleteLabel(documentId: label.documentId);

  @override
  Future<void> deleteNote(Note note) =>
      _database.deleteNote(documentId: note.documentId);

  @override
  Future<List<Label>> getLabels() async => _database.getLabels();

  @override
  Future<List<Note>> getNotes({
    String lastId = "",
    int limit = 10,
    Label? label,
  }) async {
    return _database.getNotes(
      lastId: lastId,
      limit: limit,
      label: label,
    );
  }

  @override
  Future<Note?> saveNote(Note note) async {
    final result = await _database.saveNote(note);
    return result > -1 ? note : null;
  }

  @override
  Future<void> nuke() async => _database.deleteAll();
}
