import 'package:flutter_test/flutter_test.dart';
import 'package:numerote_core/src/models/note.dart';

void main() {
  group('Basic model tests', () {
    test('Check that create factory works correctly', () {
      var note = Note.create();
      expect(note.contents, isEmpty);

      note = Note.create(contents: "testing");
      expect(note.contents, "testing");
    });

    test('Check that == is working correctly', () {
      final firstNote = Note.create();
      final secondNote = firstNote.copyWith(contents: "Some new text");
      expect(firstNote, secondNote);

      final thirdNote = secondNote.copyWith(documentId: "another_id");
      expect(thirdNote, isNot(firstNote));
      expect(thirdNote, isNot(secondNote));
    });

    test('Check copyWith method more thoroughly', () {
      final firstNote = Note.create();
      final secondNote = firstNote.copyWith(
        updatedAt: DateTime.now().add(
          const Duration(seconds: 3),
        ),
      );

      expect(firstNote.documentId, secondNote.documentId);
      expect(firstNote.contents, secondNote.contents);
      expect(firstNote.labels.length, secondNote.labels.length);
      expect(firstNote.createdAt, secondNote.createdAt);
      expect(firstNote.updatedAt, isNot(secondNote.updatedAt));
    });

    test('Check hashCode for coverage', () {
      final firstNote = Note.create();
      expect(firstNote.documentId, isNotEmpty);
      expect(firstNote.hashCode, firstNote.documentId.hashCode);
    });
  });
}
