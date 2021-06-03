// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'label.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LabelTearOff {
  const _$LabelTearOff();

  _Label call(
      {required String documentId,
      required String name,
      required int createdAtMillis,
      required int updatedAtMillis}) {
    return _Label(
      documentId: documentId,
      name: name,
      createdAtMillis: createdAtMillis,
      updatedAtMillis: updatedAtMillis,
    );
  }
}

/// @nodoc
const $Label = _$LabelTearOff();

/// @nodoc
mixin _$Label {
  String get documentId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get createdAtMillis => throw _privateConstructorUsedError;
  int get updatedAtMillis => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LabelCopyWith<Label> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LabelCopyWith<$Res> {
  factory $LabelCopyWith(Label value, $Res Function(Label) then) =
      _$LabelCopyWithImpl<$Res>;
  $Res call(
      {String documentId,
      String name,
      int createdAtMillis,
      int updatedAtMillis});
}

/// @nodoc
class _$LabelCopyWithImpl<$Res> implements $LabelCopyWith<$Res> {
  _$LabelCopyWithImpl(this._value, this._then);

  final Label _value;
  // ignore: unused_field
  final $Res Function(Label) _then;

  @override
  $Res call({
    Object? documentId = freezed,
    Object? name = freezed,
    Object? createdAtMillis = freezed,
    Object? updatedAtMillis = freezed,
  }) {
    return _then(_value.copyWith(
      documentId: documentId == freezed
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$LabelCopyWith<$Res> implements $LabelCopyWith<$Res> {
  factory _$LabelCopyWith(_Label value, $Res Function(_Label) then) =
      __$LabelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String documentId,
      String name,
      int createdAtMillis,
      int updatedAtMillis});
}

/// @nodoc
class __$LabelCopyWithImpl<$Res> extends _$LabelCopyWithImpl<$Res>
    implements _$LabelCopyWith<$Res> {
  __$LabelCopyWithImpl(_Label _value, $Res Function(_Label) _then)
      : super(_value, (v) => _then(v as _Label));

  @override
  _Label get _value => super._value as _Label;

  @override
  $Res call({
    Object? documentId = freezed,
    Object? name = freezed,
    Object? createdAtMillis = freezed,
    Object? updatedAtMillis = freezed,
  }) {
    return _then(_Label(
      documentId: documentId == freezed
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
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

class _$_Label extends _Label {
  _$_Label(
      {required this.documentId,
      required this.name,
      required this.createdAtMillis,
      required this.updatedAtMillis})
      : super._();

  @override
  final String documentId;
  @override
  final String name;
  @override
  final int createdAtMillis;
  @override
  final int updatedAtMillis;

  @override
  String toString() {
    return 'Label(documentId: $documentId, name: $name, createdAtMillis: $createdAtMillis, updatedAtMillis: $updatedAtMillis)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Label &&
            (identical(other.documentId, documentId) ||
                const DeepCollectionEquality()
                    .equals(other.documentId, documentId)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
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
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(createdAtMillis) ^
      const DeepCollectionEquality().hash(updatedAtMillis);

  @JsonKey(ignore: true)
  @override
  _$LabelCopyWith<_Label> get copyWith =>
      __$LabelCopyWithImpl<_Label>(this, _$identity);
}

abstract class _Label extends Label {
  factory _Label(
      {required String documentId,
      required String name,
      required int createdAtMillis,
      required int updatedAtMillis}) = _$_Label;
  _Label._() : super._();

  @override
  String get documentId => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  int get createdAtMillis => throw _privateConstructorUsedError;
  @override
  int get updatedAtMillis => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LabelCopyWith<_Label> get copyWith => throw _privateConstructorUsedError;
}
