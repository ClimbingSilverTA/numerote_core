import 'package:flutter_test/flutter_test.dart';
import 'package:numerote_core/numerote_core.dart';
import 'package:numerote_core/src/models/label.dart';
import 'package:numerote_core/src/models/note.dart';

void main() {
  group('Tests with in-memory adapter', () {
    late NumeroteCore core;

    setUp(() => core = NumeroteCore.inMemory());

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
      expect(savedNotes.first, note);
      expect(savedNotes.first.contents, contents);

      await core.notes.delete(note);
      expect(await core.notes.find(), isEmpty);
    });

    test('Check that a Label can be created/deleted', () async {
      expect(await core.notes.find(), isEmpty);

      final label = Label.create(name: "つぶやき");
      await core.labels.save(label);

      final savedLabels = await core.labels.find();
      expect(savedLabels, isNotEmpty);
      expect(savedLabels.first, label);
      expect(savedLabels.first.name, label.name);

      await core.labels.delete(label);
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
  });
}