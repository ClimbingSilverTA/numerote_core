import 'package:numerote_core/src/models/label.dart';
import 'package:numerote_core/src/models/note.dart';

abstract class NotesDataAdapter {
  Future<List<Note>> getNotes({
    String lastId = "",
    int limit = 10,
    String? labelId,
    String? queryString,
  });
  Future<Note?> saveNote(Note note);
  Future<void> saveNotes(List<Note> notes);
  Future<void> deleteNote(Note note);

  Future<List<Label>> getLabels({
    String lastId = "",
    int limit = 10,
  });
  Future<Label?> saveLabel(Label label);
  Future<void> saveLabels(List<Label> labels);
  Future<void> deleteLabel(Label label);

  Future<void> nuke();
}
