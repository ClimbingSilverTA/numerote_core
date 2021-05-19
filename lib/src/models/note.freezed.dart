// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NoteTearOff {
  const _$NoteTearOff();

  _Note call(
      {required String documentId,
      required String contents,
      required List<Label> labels,
      required int createdAtMillis,
      required int updatedAtMillis}) {
    return _Note(
      documentId: documentId,
      contents: contents,
      labels: labels,
      createdAtMillis: createdAtMillis,
      updatedAtMillis: updatedAtMillis,
    );
  }
}

/// @nodoc
const $Note = _$NoteTearOff();

/// @nodoc
mixin _$Note {
  String get documentId => throw _privateConstructorUsedError;
  String get contents => throw _privateConstructorUsedError;
  List<Label> get labels => throw _privateConstructorUsedError;
  int get createdAtMillis => throw _privateConstructorUsedError;
  int get updatedAtMillis => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NoteCopyWith<Note> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteCopyWith<$Res> {
  factory $NoteCopyWith(Note value, $Res Function(Note) then) =
      _$NoteCopyWithImpl<$Res>;
  $Res call(
      {String documentId,
      String contents,
      List<Label> labels,
      int createdAtMillis,
      int updatedAtMillis});
}

/// @nodoc
class _$NoteCopyWithImpl<$Res> implements $NoteCopyWith<$Res> {
  _$NoteCopyWithImpl(this._value, this._then);

  final Note _value;
  // ignore: unused_field
  final $Res Function(Note) _then;

  @override
  $Res call({
    Object? documentId = freezed,
    Object? contents = freezed,
    Object? labels = freezed,
    Object? createdAtMillis = freezed,
    Object? updatedAtMillis = freezed,
  }) {
    return _then(_value.copyWith(
      documentId: documentId == freezed
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      contents: contents == freezed
          ? _value.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as String,
      labels: labels == freezed
          ? _value.labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<Label>,
      createdAtMillis: createdAtMillis == freezed
          ? _value.createdAtMillis
          : createdAtMillis // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAtMillis: updatedAtMillis == freezed
          ? _value.updatedAtMillis
          : updatedAtMillis // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$NoteCopyWith<$Res> implements $NoteCopyWith<$Res> {
  factory _$NoteCopyWith(_Note value, $Res Function(_Note) then) =
      __$NoteCopyWithImpl<$Res>;
  @override
  $Res call(
      {String documentId,
      String contents,
      List<Label> labels,
      int createdAtMillis,
      int updatedAtMillis});
}

/// @nodoc
class __$NoteCopyWithImpl<$Res> extends _$NoteCopyWithImpl<$Res>
    implements _$NoteCopyWith<$Res> {
  __$NoteCopyWithImpl(_Note _value, $Res Function(_Note) _then)
      : super(_value, (v) => _then(v as _Note));

  @override
  _Note get _value => super._value as _Note;

  @override
  $Res call({
    Object? documentId = freezed,
    Object? contents = freezed,
    Object? labels = freezed,
    Object? createdAtMillis = freezed,
    Object? updatedAtMillis = freezed,
  }) {
    return _then(_Note(
      documentId: documentId == freezed
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      contents: contents == freezed
          ? _value.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as String,
      labels: labels == freezed
          ? _value.labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<Label>,
      createdAtMillis: createdAtMillis == freezed
          ? _value.createdAtMillis
          : createdAtMillis // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAtMillis: updatedAtMillis == freezed
          ? _value.updatedAtMillis
          : updatedAtMillis // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Note extends _Note {
  _$_Note(
      {required this.documentId,
      required this.contents,
      required this.labels,
      required this.createdAtMillis,
      required this.updatedAtMillis})
      : super._();

  @override
  final String documentId;
  @override
  final String contents;
  @override
  final List<Label> labels;
  @override
  final int createdAtMillis;
  @override
  final int updatedAtMillis;

  @override
  String toString() {
    return 'Note(documentId: $documentId, contents: $contents, labels: $labels, createdAtMillis: $createdAtMillis, updatedAtMillis: $updatedAtMillis)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Note &&
            (identical(other.documentId, documentId) ||
                const DeepCollectionEquality()
                    .equals(other.documentId, documentId)) &&
            (identical(other.contents, contents) ||
                const DeepCollectionEquality()
                    .equals(other.contents, contents)) &&
            (identical(other.labels, labels) ||
                const DeepCollectionEquality().equals(other.labels, labels)) &&
            (identical(other.createdAtMillis, createdAtMillis) ||
                const DeepCollectionEquality()
                    .equals(other.createdAtMillis, createdAtMillis)) &&
            (identical(other.updatedAtMillis, updatedAtMillis) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAtMillis, updatedAtMillis)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(documentId) ^
      const DeepCollectionEquality().hash(contents) ^
      const DeepCollectionEquality().hash(labels) ^
      const DeepCollectionEquality().hash(createdAtMillis) ^
      const DeepCollectionEquality().hash(updatedAtMillis);

  @JsonKey(ignore: true)
  @override
  _$NoteCopyWith<_Note> get copyWith =>
      __$NoteCopyWithImpl<_Note>(this, _$identity);
}

abstract class _Note extends Note {
  factory _Note(
      {required String documentId,
      required String contents,
      required List<Label> labels,
      required int createdAtMillis,
      required int updatedAtMillis}) = _$_Note;
  _Note._() : super._();

  @override
  String get documentId => throw _privateConstructorUsedError;
  @override
  String get contents => throw _privateConstructorUsedError;
  @override
  List<Label> get labels => throw _privateConstructorUsedError;
  @override
  int get createdAtMillis => throw _privateConstructorUsedError;
  @override
  int get updatedAtMillis => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NoteCopyWith<_Note> get copyWith => throw _privateConstructorUsedError;
}
