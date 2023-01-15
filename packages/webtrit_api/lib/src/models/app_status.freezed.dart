// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppStatus _$AppStatusFromJson(Map<String, dynamic> json) {
  return _AppStatus.fromJson(json);
}

/// @nodoc
mixin _$AppStatus {
  bool get register => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppStatusCopyWith<AppStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStatusCopyWith<$Res> {
  factory $AppStatusCopyWith(AppStatus value, $Res Function(AppStatus) then) =
      _$AppStatusCopyWithImpl<$Res, AppStatus>;
  @useResult
  $Res call({bool register});
}

/// @nodoc
class _$AppStatusCopyWithImpl<$Res, $Val extends AppStatus>
    implements $AppStatusCopyWith<$Res> {
  _$AppStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? register = null,
  }) {
    return _then(_value.copyWith(
      register: null == register
          ? _value.register
          : register // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppStatusCopyWith<$Res> implements $AppStatusCopyWith<$Res> {
  factory _$$_AppStatusCopyWith(
          _$_AppStatus value, $Res Function(_$_AppStatus) then) =
      __$$_AppStatusCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool register});
}

/// @nodoc
class __$$_AppStatusCopyWithImpl<$Res>
    extends _$AppStatusCopyWithImpl<$Res, _$_AppStatus>
    implements _$$_AppStatusCopyWith<$Res> {
  __$$_AppStatusCopyWithImpl(
      _$_AppStatus _value, $Res Function(_$_AppStatus) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? register = null,
  }) {
    return _then(_$_AppStatus(
      register: null == register
          ? _value.register
          : register // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_AppStatus implements _AppStatus {
  const _$_AppStatus({required this.register});

  factory _$_AppStatus.fromJson(Map<String, dynamic> json) =>
      _$$_AppStatusFromJson(json);

  @override
  final bool register;

  @override
  String toString() {
    return 'AppStatus(register: $register)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppStatus &&
            (identical(other.register, register) ||
                other.register == register));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, register);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppStatusCopyWith<_$_AppStatus> get copyWith =>
      __$$_AppStatusCopyWithImpl<_$_AppStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppStatusToJson(
      this,
    );
  }
}

abstract class _AppStatus implements AppStatus {
  const factory _AppStatus({required final bool register}) = _$_AppStatus;

  factory _AppStatus.fromJson(Map<String, dynamic> json) =
      _$_AppStatus.fromJson;

  @override
  bool get register;
  @override
  @JsonKey(ignore: true)
  _$$_AppStatusCopyWith<_$_AppStatus> get copyWith =>
      throw _privateConstructorUsedError;
}
