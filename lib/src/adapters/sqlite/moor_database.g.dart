// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Label extends DataClass implements Insertable<Label> {
  final int id;
  final String documentId;
  final String name;
  final int createdAtMillis;
  final int updatedAtMillis;
  Label(
      {required this.id,
      required this.documentId,
      required this.name,
      required this.createdAtMillis,
      required this.updatedAtMillis});
  factory Label.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Label(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      documentId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}document_id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      createdAtMillis: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}created_at_millis'])!,
      updatedAtMillis: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}updated_at_millis'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['document_id'] = Variable<String>(documentId);
    map['name'] = Variable<String>(name);
    map['created_at_millis'] = Variable<int>(createdAtMillis);
    map['updated_at_millis'] = Variable<int>(updatedAtMillis);
    return map;
  }

  LabelsCompanion toCompanion(bool nullToAbsent) {
    return LabelsCompanion(
      id: Value(id),
      documentId: Value(documentId),
      name: Value(name),
      createdAtMillis: Value(createdAtMillis),
      updatedAtMillis: Value(updatedAtMillis),
    );
  }

  factory Label.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Label(
      id: serializer.fromJson<int>(json['id']),
      documentId: serializer.fromJson<String>(json['documentId']),
      name: serializer.fromJson<String>(json['name']),
      createdAtMillis: serializer.fromJson<int>(json['createdAtMillis']),
      updatedAtMillis: serializer.fromJson<int>(json['updatedAtMillis']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'documentId': serializer.toJson<String>(documentId),
      'name': serializer.toJson<String>(name),
      'createdAtMillis': serializer.toJson<int>(createdAtMillis),
      'updatedAtMillis': serializer.toJson<int>(updatedAtMillis),
    };
  }

  Label copyWith(
          {int? id,
          String? documentId,
          String? name,
          int? createdAtMillis,
          int? updatedAtMillis}) =>
      Label(
        id: id ?? this.id,
        documentId: documentId ?? this.documentId,
        name: name ?? this.name,
        createdAtMillis: createdAtMillis ?? this.createdAtMillis,
        updatedAtMillis: updatedAtMillis ?? this.updatedAtMillis,
      );
  @override
  String toString() {
    return (StringBuffer('Label(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('name: $name, ')
          ..write('createdAtMillis: $createdAtMillis, ')
          ..write('updatedAtMillis: $updatedAtMillis')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          documentId.hashCode,
          $mrjc(name.hashCode,
              $mrjc(createdAtMillis.hashCode, updatedAtMillis.hashCode)))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Label &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.name == this.name &&
          other.createdAtMillis == this.createdAtMillis &&
          other.updatedAtMillis == this.updatedAtMillis);
}

class LabelsCompanion extends UpdateCompanion<Label> {
  final Value<int> id;
  final Value<String> documentId;
  final Value<String> name;
  final Value<int> createdAtMillis;
  final Value<int> updatedAtMillis;
  const LabelsCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAtMillis = const Value.absent(),
    this.updatedAtMillis = const Value.absent(),
  });
  LabelsCompanion.insert({
    this.id = const Value.absent(),
    required String documentId,
    required String name,
    required int createdAtMillis,
    required int updatedAtMillis,
  })  : documentId = Value(documentId),
        name = Value(name),
        createdAtMillis = Value(createdAtMillis),
        updatedAtMillis = Value(updatedAtMillis);
  static Insertable<Label> custom({
    Expression<int>? id,
    Expression<String>? documentId,
    Expression<String>? name,
    Expression<int>? createdAtMillis,
    Expression<int>? updatedAtMillis,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (name != null) 'name': name,
      if (createdAtMillis != null) 'created_at_millis': createdAtMillis,
      if (updatedAtMillis != null) 'updated_at_millis': updatedAtMillis,
    });
  }

  LabelsCompanion copyWith(
      {Value<int>? id,
      Value<String>? documentId,
      Value<String>? name,
      Value<int>? createdAtMillis,
      Value<int>? updatedAtMillis}) {
    return LabelsCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      name: name ?? this.name,
      createdAtMillis: createdAtMillis ?? this.createdAtMillis,
      updatedAtMillis: updatedAtMillis ?? this.updatedAtMillis,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAtMillis.present) {
      map['created_at_millis'] = Variable<int>(createdAtMillis.value);
    }
    if (updatedAtMillis.present) {
      map['updated_at_millis'] = Variable<int>(updatedAtMillis.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LabelsCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('name: $name, ')
          ..write('createdAtMillis: $createdAtMillis, ')
          ..write('updatedAtMillis: $updatedAtMillis')
          ..write(')'))
        .toString();
  }
}

class $LabelsTable extends Labels with TableInfo<$LabelsTable, Label> {
  final GeneratedDatabase _db;
  final String? _alias;
  $LabelsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _documentIdMeta = const VerificationMeta('documentId');
  late final GeneratedColumn<String?> documentId = GeneratedColumn<String?>(
      'document_id', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _createdAtMillisMeta =
      const VerificationMeta('createdAtMillis');
  late final GeneratedColumn<int?> createdAtMillis = GeneratedColumn<int?>(
      'created_at_millis', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _updatedAtMillisMeta =
      const VerificationMeta('updatedAtMillis');
  late final GeneratedColumn<int?> updatedAtMillis = GeneratedColumn<int?>(
      'updated_at_millis', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, documentId, name, createdAtMillis, updatedAtMillis];
  @override
  String get aliasedName => _alias ?? 'labels';
  @override
  String get actualTableName => 'labels';
  @override
  VerificationContext validateIntegrity(Insertable<Label> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('document_id')) {
      context.handle(
          _documentIdMeta,
          documentId.isAcceptableOrUnknown(
              data['document_id']!, _documentIdMeta));
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at_millis')) {
      context.handle(
          _createdAtMillisMeta,
          createdAtMillis.isAcceptableOrUnknown(
              data['created_at_millis']!, _createdAtMillisMeta));
    } else if (isInserting) {
      context.missing(_createdAtMillisMeta);
    }
    if (data.containsKey('updated_at_millis')) {
      context.handle(
          _updatedAtMillisMeta,
          updatedAtMillis.isAcceptableOrUnknown(
              data['updated_at_millis']!, _updatedAtMillisMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMillisMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Label map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Label.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LabelsTable createAlias(String alias) {
    return $LabelsTable(_db, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  final int id;
  final String documentId;
  final String contents;
  final int createdAtMillis;
  final int updatedAtMillis;
  Note(
      {required this.id,
      required this.documentId,
      required this.contents,
      required this.createdAtMillis,
      required this.updatedAtMillis});
  factory Note.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Note(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      documentId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}document_id'])!,
      contents: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}contents'])!,
      createdAtMillis: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}created_at_millis'])!,
      updatedAtMillis: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}updated_at_millis'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['document_id'] = Variable<String>(documentId);
    map['contents'] = Variable<String>(contents);
    map['created_at_millis'] = Variable<int>(createdAtMillis);
    map['updated_at_millis'] = Variable<int>(updatedAtMillis);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      documentId: Value(documentId),
      contents: Value(contents),
      createdAtMillis: Value(createdAtMillis),
      updatedAtMillis: Value(updatedAtMillis),
    );
  }

  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<int>(json['id']),
      documentId: serializer.fromJson<String>(json['documentId']),
      contents: serializer.fromJson<String>(json['contents']),
      createdAtMillis: serializer.fromJson<int>(json['createdAtMillis']),
      updatedAtMillis: serializer.fromJson<int>(json['updatedAtMillis']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'documentId': serializer.toJson<String>(documentId),
      'contents': serializer.toJson<String>(contents),
      'createdAtMillis': serializer.toJson<int>(createdAtMillis),
      'updatedAtMillis': serializer.toJson<int>(updatedAtMillis),
    };
  }

  Note copyWith(
          {int? id,
          String? documentId,
          String? contents,
          int? createdAtMillis,
          int? updatedAtMillis}) =>
      Note(
        id: id ?? this.id,
        documentId: documentId ?? this.documentId,
        contents: contents ?? this.contents,
        createdAtMillis: createdAtMillis ?? this.createdAtMillis,
        updatedAtMillis: updatedAtMillis ?? this.updatedAtMillis,
      );
  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('contents: $contents, ')
          ..write('createdAtMillis: $createdAtMillis, ')
          ..write('updatedAtMillis: $updatedAtMillis')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          documentId.hashCode,
          $mrjc(contents.hashCode,
              $mrjc(createdAtMillis.hashCode, updatedAtMillis.hashCode)))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.contents == this.contents &&
          other.createdAtMillis == this.createdAtMillis &&
          other.updatedAtMillis == this.updatedAtMillis);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<String> documentId;
  final Value<String> contents;
  final Value<int> createdAtMillis;
  final Value<int> updatedAtMillis;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.contents = const Value.absent(),
    this.createdAtMillis = const Value.absent(),
    this.updatedAtMillis = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    required String documentId,
    required String contents,
    required int createdAtMillis,
    required int updatedAtMillis,
  })  : documentId = Value(documentId),
        contents = Value(contents),
        createdAtMillis = Value(createdAtMillis),
        updatedAtMillis = Value(updatedAtMillis);
  static Insertable<Note> custom({
    Expression<int>? id,
    Expression<String>? documentId,
    Expression<String>? contents,
    Expression<int>? createdAtMillis,
    Expression<int>? updatedAtMillis,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (contents != null) 'contents': contents,
      if (createdAtMillis != null) 'created_at_millis': createdAtMillis,
      if (updatedAtMillis != null) 'updated_at_millis': updatedAtMillis,
    });
  }

  NotesCompanion copyWith(
      {Value<int>? id,
      Value<String>? documentId,
      Value<String>? contents,
      Value<int>? createdAtMillis,
      Value<int>? updatedAtMillis}) {
    return NotesCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      contents: contents ?? this.contents,
      createdAtMillis: createdAtMillis ?? this.createdAtMillis,
      updatedAtMillis: updatedAtMillis ?? this.updatedAtMillis,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (contents.present) {
      map['contents'] = Variable<String>(contents.value);
    }
    if (createdAtMillis.present) {
      map['created_at_millis'] = Variable<int>(createdAtMillis.value);
    }
    if (updatedAtMillis.present) {
      map['updated_at_millis'] = Variable<int>(updatedAtMillis.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('contents: $contents, ')
          ..write('createdAtMillis: $createdAtMillis, ')
          ..write('updatedAtMillis: $updatedAtMillis')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NotesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _documentIdMeta = const VerificationMeta('documentId');
  late final GeneratedColumn<String?> documentId = GeneratedColumn<String?>(
      'document_id', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE');
  final VerificationMeta _contentsMeta = const VerificationMeta('contents');
  late final GeneratedColumn<String?> contents = GeneratedColumn<String?>(
      'contents', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _createdAtMillisMeta =
      const VerificationMeta('createdAtMillis');
  late final GeneratedColumn<int?> createdAtMillis = GeneratedColumn<int?>(
      'created_at_millis', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _updatedAtMillisMeta =
      const VerificationMeta('updatedAtMillis');
  late final GeneratedColumn<int?> updatedAtMillis = GeneratedColumn<int?>(
      'updated_at_millis', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, documentId, contents, createdAtMillis, updatedAtMillis];
  @override
  String get aliasedName => _alias ?? 'notes';
  @override
  String get actualTableName => 'notes';
  @override
  VerificationContext validateIntegrity(Insertable<Note> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('document_id')) {
      context.handle(
          _documentIdMeta,
          documentId.isAcceptableOrUnknown(
              data['document_id']!, _documentIdMeta));
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('contents')) {
      context.handle(_contentsMeta,
          contents.isAcceptableOrUnknown(data['contents']!, _contentsMeta));
    } else if (isInserting) {
      context.missing(_contentsMeta);
    }
    if (data.containsKey('created_at_millis')) {
      context.handle(
          _createdAtMillisMeta,
          createdAtMillis.isAcceptableOrUnknown(
              data['created_at_millis']!, _createdAtMillisMeta));
    } else if (isInserting) {
      context.missing(_createdAtMillisMeta);
    }
    if (data.containsKey('updated_at_millis')) {
      context.handle(
          _updatedAtMillisMeta,
          updatedAtMillis.isAcceptableOrUnknown(
              data['updated_at_millis']!, _updatedAtMillisMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMillisMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Note.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(_db, alias);
  }
}

class NoteEntry extends DataClass implements Insertable<NoteEntry> {
  final String note;
  final String label;
  NoteEntry({required this.note, required this.label});
  factory NoteEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NoteEntry(
      note: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}note'])!,
      label: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}label'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['note'] = Variable<String>(note);
    map['label'] = Variable<String>(label);
    return map;
  }

  NoteEntriesCompanion toCompanion(bool nullToAbsent) {
    return NoteEntriesCompanion(
      note: Value(note),
      label: Value(label),
    );
  }

  factory NoteEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NoteEntry(
      note: serializer.fromJson<String>(json['note']),
      label: serializer.fromJson<String>(json['label']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'note': serializer.toJson<String>(note),
      'label': serializer.toJson<String>(label),
    };
  }

  NoteEntry copyWith({String? note, String? label}) => NoteEntry(
        note: note ?? this.note,
        label: label ?? this.label,
      );
  @override
  String toString() {
    return (StringBuffer('NoteEntry(')
          ..write('note: $note, ')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(note.hashCode, label.hashCode));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteEntry &&
          other.note == this.note &&
          other.label == this.label);
}

class NoteEntriesCompanion extends UpdateCompanion<NoteEntry> {
  final Value<String> note;
  final Value<String> label;
  const NoteEntriesCompanion({
    this.note = const Value.absent(),
    this.label = const Value.absent(),
  });
  NoteEntriesCompanion.insert({
    required String note,
    required String label,
  })  : note = Value(note),
        label = Value(label);
  static Insertable<NoteEntry> custom({
    Expression<String>? note,
    Expression<String>? label,
  }) {
    return RawValuesInsertable({
      if (note != null) 'note': note,
      if (label != null) 'label': label,
    });
  }

  NoteEntriesCompanion copyWith({Value<String>? note, Value<String>? label}) {
    return NoteEntriesCompanion(
      note: note ?? this.note,
      label: label ?? this.label,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NoteEntriesCompanion(')
          ..write('note: $note, ')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }
}

class $NoteEntriesTable extends NoteEntries
    with TableInfo<$NoteEntriesTable, NoteEntry> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NoteEntriesTable(this._db, [this._alias]);
  final VerificationMeta _noteMeta = const VerificationMeta('note');
  late final GeneratedColumn<String?> note = GeneratedColumn<String?>(
      'note', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _labelMeta = const VerificationMeta('label');
  late final GeneratedColumn<String?> label = GeneratedColumn<String?>(
      'label', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [note, label];
  @override
  String get aliasedName => _alias ?? 'note_entries';
  @override
  String get actualTableName => 'note_entries';
  @override
  VerificationContext validateIntegrity(Insertable<NoteEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  NoteEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NoteEntry.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NoteEntriesTable createAlias(String alias) {
    return $NoteEntriesTable(_db, alias);
  }
}

abstract class _$MoorDatabase extends GeneratedDatabase {
  _$MoorDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $LabelsTable labels = $LabelsTable(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $NoteEntriesTable noteEntries = $NoteEntriesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [labels, notes, noteEntries];
}
