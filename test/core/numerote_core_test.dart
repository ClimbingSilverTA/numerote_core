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
          expect(value.length, 3);
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

      test('Ensure that Notes can be filtered via a Label', () async {
        final label = await core.labels.save(Label.create(name: "Label1"));
        await core.notes.save(Note.create(contents: "This has no label"));
        await core.notes.save(
          Note.create(contents: "This has a label attached").copyWith(
            labels: [label!],
          ),
        );
        expect(await core.notes.find(), hasLength(2));
        expect(await core.notes.find(label: label), hasLength(1));
        expect(
          (await core.notes.find(label: label)).first.contents,
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
        var note1 = await core.notes.save(Note.create(contents: "Note A"));
        var note2 = await core.notes.save(Note.create(contents: "Note B"));
        final note3 = await core.notes.save(Note.create(contents: "Note C"));

        note1 = await core.notes.save(
          note1!.copyWith(
            updatedAtMillis: DateTime.now()
                .add(const Duration(hours: 1))
                .millisecondsSinceEpoch,
          ),
        );

        note2 = await core.notes.save(
          note2!.copyWith(
            updatedAtMillis: DateTime.now()
                .add(const Duration(minutes: 30))
                .millisecondsSinceEpoch,
          ),
        );

        expect(note1, isNotNull);
        expect(note2, isNotNull);

        var notes = await core.notes.find();
        expect(notes, hasLength(3));
        expect(notes.first, note1);
        expect(notes.last, note3);

        notes = await core.notes.find(lastId: note2!.documentId);
        expect(notes, hasLength(1));
        expect(notes.first, note3);
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

        notes = await core.notes.find(limit: 3, label: fruitLabel);
        expect(notes, hasLength(1));

        notes = await core.notes.find(limit: 3, label: mathLabel);
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
    });
  });
}
