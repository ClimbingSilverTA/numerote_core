import 'package:flutter_test/flutter_test.dart';
import 'package:numerote_core/numerote_core.dart';
import 'package:numerote_core/src/models/label.dart';
import 'package:numerote_core/src/models/note.dart';

void main() {
  group('Test different adapters', () {
    final cores = [
      NumeroteCore.inMemory(),
      NumeroteCore.sql(testing: true),
    ];

    setUp(() async {
      for (final core in cores) {
        await core.nuke();
      }
    });

    // ignore: avoid_function_literals_in_foreach_calls
    cores.forEach((core) {
      test('Check that a Note can be created/edited/deleted', () async {
        expect(await core.notes.find(), isEmpty);

        final note = Note.create(
          contents: "A new note about something important",
        );
        await core.notes.save(note);

        var savedNotes = await core.notes.find();
        expect(savedNotes, isNotEmpty);
        expect(savedNotes.first, note);
        expect(savedNotes.first.contents, note.contents);

        const contents = "Something different to write about";
        await core.notes.save(savedNotes.first.copyWith(contents: contents));

        savedNotes = await core.notes.find();
        expect(savedNotes, isNotEmpty);
        expect(savedNotes.first.documentId, note.documentId);
        expect(savedNotes.first.contents, contents);

        await core.notes.delete(note);
        expect(await core.notes.find(), isEmpty);
      });

      test('Check that multiple notes can be saved simultaneously', () async {
        expect(await core.notes.find(), isEmpty);

        final notes = [
          Note.create(contents: "Note 1"),
          Note.create(contents: "Note 2"),
          Note.create(contents: "Note 3")
        ];

        await core.notes.saveAll(notes);
        expect(await core.notes.find(), isNotEmpty);

        await core.notes.find().then((value) async {
          expect(value, hasLength(3));
          expect(value, containsAll(notes));
        });
      });

      test('Check that a Label can be edited/created/deleted', () async {
        expect(await core.notes.find(), isEmpty);

        final label = Label.create(name: "つぶやき");
        await core.labels.save(label);

        await core.labels.find().then((value) {
          expect(value, hasLength(1));
          expect(value.first, label);
          expect(value.first.name, label.name);
          expect(value.first.updatedAtMillis, label.updatedAtMillis);
        });

        final timestamp = DateTime.now().millisecondsSinceEpoch;
        await core.labels.find().then((value) async {
          await core.labels.save(
            value.first.copyWith(
              updatedAtMillis: timestamp,
            ),
          );
        });

        await core.labels.find().then((value) async {
          expect(value, hasLength(1));
          expect(value.first.name, label.name);
          expect(value.first.updatedAt, isNot(label.updatedAt));
          expect(value.first.updatedAtMillis, timestamp);
          await core.labels.delete(value.first);
        });

        expect(await core.labels.find(), isEmpty);
      });

      test('Check that multiple labels can be saved simultaneously', () async {
        expect(await core.labels.find(), isEmpty);

        final labels = [
          Label.create(name: "Label 1"),
          Label.create(name: "Label 2"),
          Label.create(name: "Label 3"),
        ];

        await core.labels.saveAll(labels);
        expect(await core.labels.find(), isNotEmpty);

        await core.labels.find().then((value) async {
          expect(value, hasLength(3));
          expect(value, containsAll(labels));
        });
      });

      test('Ensure that Notes can be filtered via a Label', () async {
        final label = await core.labels.save(Label.create(name: "Label1"));
        await core.notes.save(Note.create(contents: "This has no label"));
        await core.notes.save(
          Note.create(contents: "This has a label attached").copyWith(
            labels: [label!],
          ),
        );
        expect(await core.notes.find(), hasLength(2));
        expect(await core.notes.find(labelId: label.documentId), hasLength(1));
        expect(
          (await core.notes.find(labelId: label.documentId)).first.contents,
          "This has a label attached",
        );
      });

      test('Ensure that deleting a Label also removes it from Notes', () async {
        final label = await core.labels.save(Label.create(name: "Salmon"));
        final note = Note.create(contents: "A new note");
        note.labels.add(label!);
        await core.notes.save(note);

        var savedNote = (await core.notes.find()).first;
        expect(savedNote.labels, contains(label));

        await core.labels.delete(label);
        savedNote = (await core.notes.find()).first;
        expect(savedNote.labels, isNot(contains(label)));
        expect(await core.labels.find(), isEmpty);
      });

      test('Ensure that notes are being ordered by updatedAt, can be skipped',
          () async {
        final notes = [
          Note.create(contents: "Note A").copyWith(
            updatedAtMillis: DateTime.now()
                .add(const Duration(hours: 1))
                .millisecondsSinceEpoch,
          ),
          Note.create(contents: "Note B").copyWith(
            updatedAtMillis: DateTime.now()
                .add(const Duration(minutes: 30))
                .millisecondsSinceEpoch,
          ),
          Note.create(contents: "Note C"),
        ];

        await core.notes.saveAll(notes);

        await core.notes.find().then((value) {
          expect(value, hasLength(3));
          expect(value.first, notes.first);
          expect(value.last, notes.last);
        });

        await core.notes.find(lastId: notes[1].documentId).then((value) {
          expect(value, hasLength(1));
          expect(value.first, notes.last);
        });
      });

      test(
          'Ensure that notes are being ordered by updatedAt, can be skipped(with same timestamp values)',
          () async {
        final updatedTimestamp = DateTime.now().millisecondsSinceEpoch;

        final notes = [
          for (var i = 0; i < 10; i++)
            Note.create(contents: "Note $i").copyWith(
              updatedAtMillis: updatedTimestamp,
            )
        ];

        await core.notes.saveAll(notes);

        await core.notes.find().then((v1) async {
          expect(v1, hasLength(10));
          await core.notes.find(lastId: v1[8].documentId).then((v2) {
            expect(v2, hasLength(1));
            expect(v2.first, v1.last);
          });
        });
      });

      test('Ensure that limit/label for Note is being enforced', () async {
        final fruitLabel = await core.labels.save(Label.create(name: "Fruit"));
        final mathLabel = await core.labels.save(Label.create(name: "Math"));

        for (var i = 0; i < 20; i++) {
          await core.notes.save(Note.create(contents: "Note $i"));
        }

        var notes = await core.notes.find(limit: 3);
        expect(notes, hasLength(3));

        core.notes.save(notes[0].copyWith(
          labels: [fruitLabel!],
        ));

        notes = await core.notes.find(limit: 3, labelId: fruitLabel.documentId);
        expect(notes, hasLength(1));

        notes = await core.notes.find(limit: 3, labelId: mathLabel?.documentId);
        expect(notes, isEmpty);
      });

      test('Ensure that order/limit/skipping for Label is being enforced',
          () async {
        final mathLabel = await core.labels.save(
          Label.create(name: "수학").copyWith(
            updatedAtMillis: DateTime.now()
                .add(const Duration(minutes: 10))
                .millisecondsSinceEpoch,
          ),
        );
        final englishLabel = await core.labels.save(
          Label.create(name: "영어").copyWith(
            updatedAtMillis: DateTime.now()
                .add(const Duration(minutes: 6))
                .millisecondsSinceEpoch,
          ),
        );
        final readingLabel = await core.labels.save(Label.create(name: "독서"));
        var labels = await core.labels.find();
        expect(labels, hasLength(3));
        expect(labels.first, mathLabel);
        expect(labels.last, readingLabel);

        labels = await core.labels.find(lastId: englishLabel!.documentId);
        expect(labels, hasLength(1));
        expect(labels.first, readingLabel);

        labels = await core.labels.find(limit: 2);
        expect(labels, hasLength(2));
      });

      test(
          'Ensure skipping/pagination is enforced properly for Labels(when values are the same)',
          () async {
        final updateTimestamp = DateTime.now().millisecondsSinceEpoch;
        final labels = [
          Label.create(name: 'Mock1').copyWith(
            updatedAtMillis: updateTimestamp,
          ),
          Label.create(name: 'Mock2').copyWith(
            updatedAtMillis: updateTimestamp,
          ),
          Label.create(name: 'Mock3').copyWith(
            updatedAtMillis: updateTimestamp,
          ),
          Label.create(name: 'Mock4').copyWith(
            updatedAtMillis: updateTimestamp,
          ),
        ];

        await core.labels.saveAll(labels);
        await core.labels.find().then((v1) async {
          expect(v1, containsAll(labels));
          expect(v1, hasLength(4));

          await core.labels.find(lastId: v1[1].documentId).then((v2) {
            expect(v2, hasLength(2));
            expect(v2, containsAll([v1[2], v1[3]]));
          });
        });
      });
    });
  });
}
