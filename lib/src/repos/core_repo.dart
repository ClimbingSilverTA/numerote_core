import 'package:numerote_core/src/adapters/notes_data_adapter.dart';
import 'package:numerote_core/src/models/label.dart';
import 'package:numerote_core/src/models/note.dart';

class CoreRepo<R> {
  CoreRepo({required NotesDataAdapter adapter}) : _adapter = adapter;
  final NotesDataAdapter _adapter;

  Future<R?> save(R item) async {
    if (item is Note) {
      return await _adapter.saveNote(item) as R?;
    } else if (item is Label) {
      return await _adapter.createLabel(item) as R?;
    }

    return null;
  }

  Future<void> delete(R item) async {
    if (item is Note) {
      return _adapter.deleteNote(item);
    } else if (item is Label) {
      return _adapter.deleteLabel(item);
    }
  }

  Future<List<R>> find({
    String lastId = "",
    int limit = 10,
    Label? label,
  }) async {
    if (this is CoreRepo<Note>) {
      return await _adapter.getNotes(
        lastId: lastId,
        limit: limit,
        label: label,
      ) as List<R>;
    } else if (this is CoreRepo<Label>) {
      return await _adapter.getLabels() as List<R>;
    }
    return [];
  }
}