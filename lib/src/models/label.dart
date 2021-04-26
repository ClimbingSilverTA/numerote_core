import 'package:uuid/uuid.dart';

class Label {
  Label({
    String? documentId,
    required this.name,
    DateTime? createdAt,
  })  : documentId = documentId ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  final String documentId;
  final String name;
  final DateTime createdAt;

  factory Label.create({required String name}) => Label(name: name);

  @override
  bool operator ==(Object other) =>
      other is Label && other.documentId == documentId;

  @override
  int get hashCode => documentId.hashCode;

  Label copyWith({
    String? documentId,
    String? name,
    DateTime? createdAt,
  }) {
    return Label(
      documentId: documentId ?? this.documentId,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
