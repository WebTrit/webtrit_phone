// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'numbers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Numbers _$NumbersFromJson(Map<String, dynamic> json) {
  return _Numbers.fromJson(json);
}

/// @nodoc
mixin _$Numbers {
  List<String>? get additional => throw _privateConstructorUsedError;
  String? get ext => throw _privateConstructorUsedError;
  String? get main => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NumbersCopyWith<Numbers> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NumbersCopyWith<$Res> {
  factory $NumbersCopyWith(Numbers value, $Res Function(Numbers) then) =
      _$NumbersCopyWithImpl<$Res, Numbers>;
  @useResult
  $Res call({List<String>? additional, String? ext, String? main});
}

/// @nodoc
class _$NumbersCopyWithImpl<$Res, $Val extends Numbers>
    implements $NumbersCopyWith<$Res> {
  _$NumbersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? additional = freezed,
    Object? ext = freezed,
    Object? main = freezed,
  }) {
    return _then(_value.copyWith(
      additional: freezed == additional
          ? _value.additional
          : additional // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      ext: freezed == ext
          ? _value.ext
          : ext // ignore: cast_nullable_to_non_nullable
              as String?,
      main: freezed == main
          ? _value.main
          : main // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NumbersCopyWith<$Res> implements $NumbersCopyWith<$Res> {
  factory _$$_NumbersCopyWith(
          _$_Numbers value, $Res Function(_$_Numbers) then) =
      __$$_NumbersCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String>? additional, String? ext, String? main});
}

/// @nodoc
class __$$_NumbersCopyWithImpl<$Res>
    extends _$NumbersCopyWithImpl<$Res, _$_Numbers>
    implements _$$_NumbersCopyWith<$Res> {
  __$$_NumbersCopyWithImpl(_$_Numbers _value, $Res Function(_$_Numbers) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? additional = freezed,
    Object? ext = freezed,
    Object? main = freezed,
  }) {
    return _then(_$_Numbers(
      additional: freezed == additional
          ? _value._additional
          : additional // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      ext: freezed == ext
          ? _value.ext
          : ext // ignore: cast_nullable_to_non_nullable
              as String?,
      main: freezed == main
          ? _value.main
          : main // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Numbers implements _Numbers {
  const _$_Numbers({final List<String>? additional, this.ext, this.main})
      : _additional = additional;

  factory _$_Numbers.fromJson(Map<String, dynamic> json) =>
      _$$_NumbersFromJson(json);

  final List<String>? _additional;
  @override
  List<String>? get additional {
    final value = _additional;
    if (value == null) return null;
    if (_additional is EqualUnmodifiableListView) return _additional;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? ext;
  @override
  final String? main;

  @override
  String toString() {
    return 'Numbers(additional: $additional, ext: $ext, main: $main)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Numbers &&
            const DeepCollectionEquality()
                .equals(other._additional, _additional) &&
            (identical(other.ext, ext) || other.ext == ext) &&
            (identical(other.main, main) || other.main == main));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_additional), ext, main);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NumbersCopyWith<_$_Numbers> get copyWith =>
      __$$_NumbersCopyWithImpl<_$_Numbers>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NumbersToJson(
      this,
    );
  }
}

abstract class _Numbers implements Numbers {
  const factory _Numbers(
      {final List<String>? additional,
      final String? ext,
      final String? main}) = _$_Numbers;

  factory _Numbers.fromJson(Map<String, dynamic> json) = _$_Numbers.fromJson;

  @override
  List<String>? get additional;
  @override
  String? get ext;
  @override
  String? get main;
  @override
  @JsonKey(ignore: true)
  _$$_NumbersCopyWith<_$_Numbers> get copyWith =>
      throw _privateConstructorUsedError;
}
