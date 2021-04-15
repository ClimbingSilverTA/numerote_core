import 'package:numerote_core/src/adapters/notes_data_adapter.dart';
import 'package:numerote_core/src/adapters/notes_memory_adapter.dart';
import 'package:numerote_core/src/models/label.dart';
import 'package:numerote_core/src/models/note.dart';
import 'package:numerote_core/src/repos/core_repo.dart';

class NumeroteCore {
  final CoreRepo<Note> notes;
  final CoreRepo<Label> labels;

  NumeroteCore._internal({
    required NotesDataAdapter adapter,
  })   : notes = CoreRepo<Note>(adapter: adapter),
        labels = CoreRepo<Label>(adapter: adapter);

  factory NumeroteCore.inMemory() =>
      NumeroteCore._internal(adapter: NotesMemoryAdapter());
}
