import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:numerote_core/src/models/label.dart' as core;
import 'package:numerote_core/src/models/note.dart' as core;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'moor_models.g.dart';

class Labels extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get documentId => text().customConstraint('UNIQUE')();
  TextColumn get name => text().withLength(max: 20)();
  DateTimeColumn get createdAt => dateTime()();
}

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get documentId => text().customConstraint('UNIQUE')();
  TextColumn get contents => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

@DataClassName('NoteEntry')
class NoteEntries extends Table {
  TextColumn get note => text()();
  TextColumn get label => text()();
}

class NoteWithLabels {
  final Note note;
  final List<Label> labels;

  NoteWithLabels({
    required this.note,
    required this.labels,
  });
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
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

  Future<int> saveLabel(core.Label label) async =>
      into(labels).insert(label.toCompanion(), mode: InsertMode.replace);

  Future<void> deleteLabel({required String documentId}) async {
    await (delete(labels)..where((l) => l.documentId.equals(documentId))).go();
  }

  Future<List<core.Label>> getLabels() async {
    final existingLabels = await select(labels).get();
    return existingLabels.map((l) => l.toCoreLabel()).toList();
  }

  Future<List<core.Note>> getNotes({
    String lastId = "",
    int limit = 10,
    core.Label? label,
  }) async {
    var query = select(notes);

    if (lastId.isNotEmpty) {
      final existingNote = await _findNote(documentId: lastId);
      if (existingNote != null) {
        query = query..where((n) => n.id.isBiggerThanValue(existingNote.id));
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

extension MoorLabelExt on Label {
  core.Label toCoreLabel() {
    return core.Label(
      documentId: documentId,
      name: name,
      createdAt: createdAt,
    );
  }
}

extension _LabelExt on core.Label {
  LabelsCompanion toCompanion() {
    return LabelsCompanion.insert(
      documentId: documentId,
      name: name,
      createdAt: createdAt,
    );
  }
}

extension _NoteText on core.Note {
  NotesCompanion toCompanion() {
    return NotesCompanion.insert(
      documentId: documentId,
      contents: contents,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension MoorDatabaseExt on _$MoorDatabase {
  Future<List<NoteWithLabels>> populateLabels(List<Note> notes) async {
    final notesMap = {for (final note in notes) note.documentId: note};
    final rows = await (select(noteEntries).join(
      [
        innerJoin(
          labels,
          labels.documentId.equalsExp(noteEntries.label),
        ),
      ],
    )..where((noteEntries.note.isIn(notesMap.keys))))
        .get();

    final labelListMap = <String, List<Label>>{};
    for (final row in rows) {
      final label = row.readTable(labels);
      final documentId = row.readTable(noteEntries).note;
      labelListMap.putIfAbsent(documentId, () => []).add(label);
    }

    return notesMap.keys
        .where((id) => notesMap[id] != null)
        .map((id) => NoteWithLabels(
              note: notesMap[id]!,
              labels: labelListMap[id] ?? [],
            ))
        .toList();
  }
}

extension MoorNoteLabelsExtension on NoteWithLabels {
  core.Note toCoreNote() {
    return core.Note(
      documentId: note.documentId,
      contents: note.contents,
      labels: labels.map((e) => e.toCoreLabel()).toList(),
      createdAt: note.createdAt,
      updatedAt: note.updatedAt,
    );
  }
}
