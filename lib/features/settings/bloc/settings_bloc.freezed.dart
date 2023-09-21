// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SettingsRefreshed {}

/// @nodoc

class _$_SettingsRefreshed implements _SettingsRefreshed {
  const _$_SettingsRefreshed();

  @override
  String toString() {
    return 'SettingsRefreshed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_SettingsRefreshed);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _SettingsRefreshed implements SettingsRefreshed {
  const factory _SettingsRefreshed() = _$_SettingsRefreshed;
}

/// @nodoc
mixin _$SettingsLogouted {
  bool get force => throw _privateConstructorUsedError;
}

/// @nodoc

class _$_SettingsLogouted implements _SettingsLogouted {
  const _$_SettingsLogouted({this.force = false});

  @override
  @JsonKey()
  final bool force;

  @override
  String toString() {
    return 'SettingsLogouted(force: $force)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SettingsLogouted &&
            (identical(other.force, force) || other.force == force));
  }

  @override
  int get hashCode => Object.hash(runtimeType, force);
}

abstract class _SettingsLogouted implements SettingsLogouted {
  const factory _SettingsLogouted({final bool force}) = _$_SettingsLogouted;

  @override
  bool get force;
}

/// @nodoc
mixin _$SettingsRegisterStatusChanged {
  bool get value => throw _privateConstructorUsedError;
}

/// @nodoc

class _$_SettingsRegisterStatusChanged
    implements _SettingsRegisterStatusChanged {
  const _$_SettingsRegisterStatusChanged(this.value);

  @override
  final bool value;

  @override
  String toString() {
    return 'SettingsRegisterStatusChanged(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SettingsRegisterStatusChanged &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

abstract class _SettingsRegisterStatusChanged
    implements SettingsRegisterStatusChanged {
  const factory _SettingsRegisterStatusChanged(final bool value) =
      _$_SettingsRegisterStatusChanged;

  @override
  bool get value;
}

/// @nodoc
mixin _$SettingsAccountDeleted {}

/// @nodoc

class _$_SettingsAccountDeleted implements _SettingsAccountDeleted {
  const _$_SettingsAccountDeleted();

  @override
  String toString() {
    return 'SettingsAccountDeleted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SettingsAccountDeleted);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _SettingsAccountDeleted implements SettingsAccountDeleted {
  const factory _SettingsAccountDeleted() = _$_SettingsAccountDeleted;
}

/// @nodoc
mixin _$SettingsState {
  bool get progress => throw _privateConstructorUsedError;
  bool get registerStatus => throw _privateConstructorUsedError;
  UserInfo? get info => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingsStateCopyWith<SettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
          SettingsState value, $Res Function(SettingsState) then) =
      _$SettingsStateCopyWithImpl<$Res, SettingsState>;
  @useResult
  $Res call({bool progress, bool registerStatus, UserInfo? info});
}

/// @nodoc
class _$SettingsStateCopyWithImpl<$Res, $Val extends SettingsState>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
    Object? registerStatus = null,
    Object? info = freezed,
  }) {
    return _then(_value.copyWith(
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as bool,
      registerStatus: null == registerStatus
          ? _value.registerStatus
          : registerStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      info: freezed == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as UserInfo?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SettingsStateCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$$_SettingsStateCopyWith(
          _$_SettingsState value, $Res Function(_$_SettingsState) then) =
      __$$_SettingsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool progress, bool registerStatus, UserInfo? info});
}

/// @nodoc
class __$$_SettingsStateCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$_SettingsState>
    implements _$$_SettingsStateCopyWith<$Res> {
  __$$_SettingsStateCopyWithImpl(
      _$_SettingsState _value, $Res Function(_$_SettingsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
    Object? registerStatus = null,
    Object? info = freezed,
  }) {
    return _then(_$_SettingsState(
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as bool,
      registerStatus: null == registerStatus
          ? _value.registerStatus
          : registerStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      info: freezed == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as UserInfo?,
    ));
  }
}

/// @nodoc

class _$_SettingsState implements _SettingsState {
  const _$_SettingsState(
      {this.progress = false, required this.registerStatus, this.info});

  @override
  @JsonKey()
  final bool progress;
  @override
  final bool registerStatus;
  @override
  final UserInfo? info;

  @override
  String toString() {
    return 'SettingsState(progress: $progress, registerStatus: $registerStatus, info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SettingsState &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.registerStatus, registerStatus) ||
                other.registerStatus == registerStatus) &&
            const DeepCollectionEquality().equals(other.info, info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, progress, registerStatus,
      const DeepCollectionEquality().hash(info));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SettingsStateCopyWith<_$_SettingsState> get copyWith =>
      __$$_SettingsStateCopyWithImpl<_$_SettingsState>(this, _$identity);
}

abstract class _SettingsState implements SettingsState {
  const factory _SettingsState(
      {final bool progress,
      required final bool registerStatus,
      final UserInfo? info}) = _$_SettingsState;

  @override
  bool get progress;
  @override
  bool get registerStatus;
  @override
  UserInfo? get info;
  @override
  @JsonKey(ignore: true)
  _$$_SettingsStateCopyWith<_$_SettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}
