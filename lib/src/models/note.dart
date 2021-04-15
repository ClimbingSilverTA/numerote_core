import 'package:numerote_core/src/models/label.dart';
import 'package:uuid/uuid.dart';

class Note {
  Note({
    String? documentId,
    required this.contents,
    List<Label>? labels,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : documentId = documentId ?? const Uuid().v4(),
        labels = labels ?? [],
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  final String documentId;
  final String contents;
  final List<Label> labels;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Note.create({String? contents}) => Note(contents: contents ?? "");

  @override
  bool operator ==(Object other) =>
      other is Note && other.documentId == documentId;

  @override
  int get hashCode => documentId.hashCode;

  Note copyWith({
    String? documentId,
    String? contents,
    List<Label>? labels,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      documentId: documentId ?? this.documentId,
      contents: contents ?? this.contents,
      labels: labels ?? this.labels,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
