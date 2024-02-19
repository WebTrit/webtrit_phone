// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_push_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppPushToken _$AppPushTokenFromJson(Map<String, dynamic> json) {
  return _AppPushToken.fromJson(json);
}

/// @nodoc
mixin _$AppPushToken {
  AppPushTokenType get type => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppPushTokenCopyWith<AppPushToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppPushTokenCopyWith<$Res> {
  factory $AppPushTokenCopyWith(
          AppPushToken value, $Res Function(AppPushToken) then) =
      _$AppPushTokenCopyWithImpl<$Res, AppPushToken>;
  @useResult
  $Res call({AppPushTokenType type, String value});
}

/// @nodoc
class _$AppPushTokenCopyWithImpl<$Res, $Val extends AppPushToken>
    implements $AppPushTokenCopyWith<$Res> {
  _$AppPushTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AppPushTokenType,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppPushTokenImplCopyWith<$Res>
    implements $AppPushTokenCopyWith<$Res> {
  factory _$$AppPushTokenImplCopyWith(
          _$AppPushTokenImpl value, $Res Function(_$AppPushTokenImpl) then) =
      __$$AppPushTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppPushTokenType type, String value});
}

/// @nodoc
class __$$AppPushTokenImplCopyWithImpl<$Res>
    extends _$AppPushTokenCopyWithImpl<$Res, _$AppPushTokenImpl>
    implements _$$AppPushTokenImplCopyWith<$Res> {
  __$$AppPushTokenImplCopyWithImpl(
      _$AppPushTokenImpl _value, $Res Function(_$AppPushTokenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? value = null,
  }) {
    return _then(_$AppPushTokenImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AppPushTokenType,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$AppPushTokenImpl implements _AppPushToken {
  const _$AppPushTokenImpl({required this.type, required this.value});

  factory _$AppPushTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppPushTokenImplFromJson(json);

  @override
  final AppPushTokenType type;
  @override
  final String value;

  @override
  String toString() {
    return 'AppPushToken(type: $type, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppPushTokenImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppPushTokenImplCopyWith<_$AppPushTokenImpl> get copyWith =>
      __$$AppPushTokenImplCopyWithImpl<_$AppPushTokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppPushTokenImplToJson(
      this,
    );
  }
}

abstract class _AppPushToken implements AppPushToken {
  const factory _AppPushToken(
      {required final AppPushTokenType type,
      required final String value}) = _$AppPushTokenImpl;

  factory _AppPushToken.fromJson(Map<String, dynamic> json) =
      _$AppPushTokenImpl.fromJson;

  @override
  AppPushTokenType get type;
  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$AppPushTokenImplCopyWith<_$AppPushTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
