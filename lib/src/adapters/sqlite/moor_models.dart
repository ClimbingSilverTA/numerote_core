import 'package:moor/moor.dart';
import 'package:numerote_core/src/adapters/sqlite/moor_database.dart';

class Labels extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get documentId => text().customConstraint('UNIQUE')();
  TextColumn get name => text().withLength(max: 20)();
  IntColumn get createdAtMillis => integer()();
  IntColumn get updatedAtMillis => integer()();
}

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get documentId => text().customConstraint('UNIQUE')();
  TextColumn get contents => text()();
  IntColumn get createdAtMillis => integer()();
  IntColumn get updatedAtMillis => integer()();
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
