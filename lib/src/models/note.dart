import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:numerote_core/src/models/label.dart';
import 'package:uuid/uuid.dart';

part 'note.freezed.dart';

@freezed
class Note with _$Note {
  factory Note({
    required String documentId,
    required String contents,
    required List<Label> labels,
    required int createdAtMillis,
    required int updatedAtMillis,
  }) = _Note;

  const Note._();

  DateTime get createdAt =>
      DateTime.fromMillisecondsSinceEpoch(createdAtMillis);
  DateTime get updatedAt =>
      DateTime.fromMillisecondsSinceEpoch(updatedAtMillis);

  factory Note.create({String? contents}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return Note(
      documentId: const Uuid().v4(),
      contents: contents ?? "",
      labels: [],
      createdAtMillis: timestamp,
      updatedAtMillis: timestamp,
    );
  }
}
