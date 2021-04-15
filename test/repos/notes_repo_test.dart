import 'package:flutter_test/flutter_test.dart';
import 'package:numerote_core/src/adapters/notes_memory_adapter.dart';
import 'package:numerote_core/src/models/label.dart';
import 'package:numerote_core/src/models/note.dart';
import 'package:numerote_core/src/repos/notes_repo.dart';

void main() {
  group('Tests with in-memory adapter', () {
    late NotesRepo repo;

    setUp(() => repo = NotesRepo(adapter: NotesMemoryAdapter()));

    test('Check that a Note can be created/edited/deleted', () async {
      expect(await repo.getNotes(), isEmpty);

      final note = Note.create(
        contents: "A new note about something important",
      );
      await repo.saveNote(note);

      var savedNotes = await repo.getNotes();
      expect(savedNotes, isNotEmpty);
      expect(savedNotes.first, note);
      expect(savedNotes.first.contents, note.contents);

      const contents = "Something different to write about";
      await repo.saveNote(savedNotes.first.copyWith(contents: contents));

      savedNotes = await repo.getNotes();
      expect(savedNotes, isNotEmpty);
      expect(savedNotes.first, note);
      expect(savedNotes.first.contents, contents);

      await repo.deleteNote(note);
      expect(await repo.getNotes(), isEmpty);
    });

    test('Check that a Label can be created/deleted', () async {
      expect(await repo.getNotes(), isEmpty);

      final label = Label.create(name: "つぶやき");
      await repo.createLabel(label);

      final savedLabels = await repo.getLabels();
      expect(savedLabels, isNotEmpty);
      expect(savedLabels.first, label);
      expect(savedLabels.first.name, label.name);

      await repo.deleteLabel(label);
      expect(await repo.getLabels(), isEmpty);
    });

    test('Ensure that Notes can be filtered via a Label', () async {
      final label = await repo.createLabel(Label.create(name: "Label1"));
      await repo.saveNote(Note.create(contents: "This has no label"));
      await repo.saveNote(
        Note.create(contents: "This has a label attached").copyWith(
          labels: [label!],
        ),
      );
      expect(await repo.getNotes(), hasLength(2));
      expect(await repo.getNotes(label: label), hasLength(1));
      expect(
        (await repo.getNotes(label: label)).first.contents,
        "This has a label attached",
      );
    });

    test('Ensure that deleting a Label also removes it from Notes', () async {
      final label = await repo.createLabel(Label.create(name: "Salmon"));
      final note = Note.create(contents: "A new note");
      note.labels.add(label!);
      await repo.saveNote(note);

      var savedNote = (await repo.getNotes()).first;
      expect(savedNote.labels, contains(label));

      await repo.deleteLabel(label);
      savedNote = (await repo.getNotes()).first;
      expect(savedNote.labels, isNot(contains(label)));
      expect(await repo.getLabels(), isEmpty);
    });
  });
}
