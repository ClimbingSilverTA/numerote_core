import 'package:numerote_core/src/adapters/notes_data_adapter.dart';
import 'package:numerote_core/src/adapters/memory/notes_memory_adapter.dart';
import 'package:numerote_core/src/adapters/sqlite/notes_sql_adapter.dart';
import 'package:numerote_core/src/models/label.dart';
import 'package:numerote_core/src/models/note.dart';
import 'package:numerote_core/src/repos/core_repo.dart';
export 'package:numerote_core/src/models/label.dart';
export 'package:numerote_core/src/models/note.dart';

class NumeroteCore {
  final CoreRepo<Note> notes;
  final CoreRepo<Label> labels;
  final NotesDataAdapter _adapter;

  NumeroteCore._internal({
    required NotesDataAdapter adapter,
  })   : _adapter = adapter,
        notes = CoreRepo<Note>(adapter: adapter),
        labels = CoreRepo<Label>(adapter: adapter);

  factory NumeroteCore.inMemory() =>
      NumeroteCore._internal(adapter: NotesMemoryAdapter());

  factory NumeroteCore.sql({bool testing = false}) {
    return NumeroteCore._internal(
      adapter: NotesSQLAdapter(testing: testing),
    );
  }

  Future<void> nuke() => _adapter.nuke();
}
