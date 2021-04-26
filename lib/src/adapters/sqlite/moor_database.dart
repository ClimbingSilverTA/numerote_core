import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:numerote_core/src/adapters/sqlite/moor_models.dart';
import 'package:numerote_core/src/models/label.dart' as core;
import 'package:numerote_core/src/models/note.dart' as core;
import 'package:numerote_core/src/adapters/sqlite/moor_extensions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'moor_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    // TODO: Decide on naming for DB
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Labels, Notes, NoteEntries])
class MoorDatabase extends _$MoorDatabase {
  MoorDatabase({
    QueryExecutor? executor,
  }) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  Future<Note?> _findNote({required String documentId}) async =>
      (select(notes)..where((n) => n.documentId.equals(documentId)))
          .getSingleOrNull();

  Future<Label?> _findLabel({required String documentId}) async =>
      (select(labels)..where((l) => l.documentId.equals(documentId)))
          .getSingleOrNull();

  Future<int> saveLabel(core.Label label) async =>
      into(labels).insert(label.toCompanion(), mode: InsertMode.replace);

  Future<void> deleteLabel({required String documentId}) async {
    await (delete(labels)..where((l) => l.documentId.equals(documentId))).go();
  }

  Future<List<core.Label>> getLabels({
    String lastId = "",
    int limit = 10,
  }) async {
    var query = select(labels)
      ..orderBy([
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)
      ]);

    if (lastId.isNotEmpty) {
      final existingLabel = await _findLabel(documentId: lastId);
      if (existingLabel != null) {
        query = query
          ..where(
            (l) => l.createdAt.isSmallerThanValue(existingLabel.createdAt),
          );
      }
    }

    final results = await (query..limit(limit)).get();
    return results.map((l) => l.toCoreLabel()).toList();
  }

  Future<List<core.Note>> getNotes({
    String lastId = "",
    int limit = 10,
    core.Label? label,
  }) async {
    var query = select(notes)
      ..orderBy([
        (t) => OrderingTerm(expression: t.updatedAt, mode: OrderingMode.desc)
      ]);

    if (lastId.isNotEmpty) {
      final existingNote = await _findNote(documentId: lastId);
      if (existingNote != null) {
        query = query
          ..where(
            (n) => n.updatedAt.isSmallerThanValue(existingNote.updatedAt),
          );
      }
    }

    if (label != null) {
      final searchIds = await (selectOnly(noteEntries)
            ..addColumns([noteEntries.note])
            ..where(noteEntries.label.equals(label.documentId)))
          .get()
          .then(
            (value) => value.map((row) => row.read(noteEntries.note)).toList(),
          );
      query = query..where((n) => n.documentId.isIn(searchIds));
    }

    final existingNotes = await (query..limit(limit)).get();
    final populatedNotes = await populateLabels(existingNotes);
    return populatedNotes.map((n) => n.toCoreNote()).toList();
  }

  Future<int> saveNote(core.Note coreNote) async {
    final note = coreNote.toCompanion();
    final labels = coreNote.labels.map((l) => l.toCompanion()).toList();

    await transaction(() async {
      await into(notes).insert(note, mode: InsertMode.replace);
      await (delete(noteEntries)
            ..where((it) => it.note.equals(note.documentId.value)))
          .go();

      for (final item in labels) {
        await into(noteEntries).insert(
          NoteEntry(
            note: note.documentId.value,
            label: item.documentId.value,
          ),
        );
      }
    });

    final newRecord = await _findNote(documentId: coreNote.documentId);
    return newRecord?.id ?? -1;
  }

  Future<void> deleteNote({required String documentId}) async {
    return transaction(() async {
      await (delete(noteEntries)..where((it) => it.note.equals(documentId)))
          .go();
      await (delete(notes)..where((it) => it.documentId.equals(documentId)))
          .go();
    });
  }

  Future<void> deleteAll() async {
    return transaction(() async {
      await (delete(noteEntries)).go();
      await (delete(labels)).go();
      await (delete(notes)).go();
    });
  }
}
