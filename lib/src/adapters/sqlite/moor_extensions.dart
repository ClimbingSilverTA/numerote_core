import 'package:moor/moor.dart';
import 'package:numerote_core/src/adapters/sqlite/moor_models.dart';
import 'package:numerote_core/src/models/label.dart' as core;
import 'package:numerote_core/src/models/note.dart' as core;
import 'package:numerote_core/src/adapters/sqlite/moor_database.dart';

extension MoorLabelExt on Label {
  core.Label toCoreLabel() {
    return core.Label(
      documentId: documentId,
      name: name,
      createdAtMillis: createdAtMillis,
    );
  }
}

extension LabelExt on core.Label {
  LabelsCompanion toCompanion() {
    return LabelsCompanion.insert(
      documentId: documentId,
      name: name,
      createdAtMillis: createdAt.millisecondsSinceEpoch,
    );
  }
}

extension NoteText on core.Note {
  NotesCompanion toCompanion() {
    return NotesCompanion.insert(
      documentId: documentId,
      contents: contents,
      createdAtMillis: createdAt.millisecondsSinceEpoch,
      updatedAtMillis: updatedAt.millisecondsSinceEpoch,
    );
  }
}

extension MoorNoteLabelsExtension on NoteWithLabels {
  core.Note toCoreNote() {
    return core.Note(
      documentId: note.documentId,
      contents: note.contents,
      labels: labels.map((e) => e.toCoreLabel()).toList(),
      createdAtMillis: note.createdAtMillis,
      updatedAtMillis: note.updatedAtMillis,
    );
  }
}

extension MoorDatabaseExt on MoorDatabase {
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
