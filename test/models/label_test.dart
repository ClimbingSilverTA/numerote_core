import 'package:flutter_test/flutter_test.dart';
import 'package:numerote_core/src/models/label.dart';

void main() {
  group('Basic model tests', () {
    test('Check that create factory works correctly', () {
      const name = "Sports";
      final firstLabel = Label.create(name: name);
      expect(firstLabel.name, name);
    });

    test('Check == is working correctly', () {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final firstLabel = Label(
        documentId: 'label_one',
        name: "Test Label",
        createdAtMillis: timestamp,
        updatedAtMillis: timestamp,
      );
      final secondLabel = Label(
        documentId: 'label_one',
        name: "Test Label",
        createdAtMillis: timestamp,
        updatedAtMillis: timestamp,
      );
      expect(firstLabel, secondLabel);

      final thirdLabel = Label(
        documentId: "label_three",
        name: "Test Label",
        createdAtMillis: DateTime.now().millisecondsSinceEpoch,
        updatedAtMillis: timestamp,
      );
      expect(firstLabel, isNot(thirdLabel));
      expect(secondLabel, isNot(thirdLabel));
    });

    test('Check that copyWith method is working correctly', () {
      final original = Label.create(name: "TestLabel");
      expect(original.copyWith(name: "ABC").name, "ABC");
      expect(
        original
            .copyWith(
                createdAtMillis: DateTime.now()
                    .add(const Duration(minutes: 1))
                    .millisecondsSinceEpoch)
            .createdAt,
        isNot(original.createdAt),
      );

      final copy = original.copyWith(documentId: "a-new-id");
      expect(copy.documentId, isNot(original.documentId));
      expect(copy.name, original.name);
      expect(copy.createdAt, original.createdAt);
    });
  });
}
