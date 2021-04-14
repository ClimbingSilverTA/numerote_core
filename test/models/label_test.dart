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
      final firstLabel = Label(documentId: 'label_one', name: "Test Label");
      final secondLabel = Label(documentId: 'label_one', name: "Test Label");
      expect(firstLabel, secondLabel);

      final thirdLabel = Label(documentId: "label_three", name: "Test Label");
      expect(firstLabel, isNot(thirdLabel));
      expect(secondLabel, isNot(thirdLabel));
    });

    test('Check hash code for coverage', () {
      final label = Label.create(name: "読書");
      expect(label.hashCode, label.documentId.hashCode);
    });
  });
}
