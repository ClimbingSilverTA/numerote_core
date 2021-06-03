import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'label.freezed.dart';

@freezed
class Label with _$Label {
  factory Label({
    required String documentId,
    required String name,
    required int createdAtMillis,
    required int updatedAtMillis,
  }) = _Label;

  const Label._();

  DateTime get createdAt =>
      DateTime.fromMillisecondsSinceEpoch(createdAtMillis);

  DateTime get updatedAt =>
      DateTime.fromMillisecondsSinceEpoch(updatedAtMillis);

  factory Label.create({required String name}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return Label(
      name: name,
      documentId: const Uuid().v4(),
      createdAtMillis: timestamp,
      updatedAtMillis: timestamp,
    );
  }
}
