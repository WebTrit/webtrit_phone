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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SettingsRefreshed {}

/// @nodoc

class _$SettingsRefreshedImpl implements _SettingsRefreshed {
  const _$SettingsRefreshedImpl();

  @override
  String toString() {
    return 'SettingsRefreshed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SettingsRefreshedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _SettingsRefreshed implements SettingsRefreshed {
  const factory _SettingsRefreshed() = _$SettingsRefreshedImpl;
}

/// @nodoc
mixin _$SettingsLogouted {}

/// @nodoc

class _$SettingsLogoutedImpl implements _SettingsLogouted {
  const _$SettingsLogoutedImpl();

  @override
  String toString() {
    return 'SettingsLogouted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SettingsLogoutedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _SettingsLogouted implements SettingsLogouted {
  const factory _SettingsLogouted() = _$SettingsLogoutedImpl;
}

/// @nodoc
mixin _$SettingsRegisterStatusChanged {
  bool get value => throw _privateConstructorUsedError;
}

/// @nodoc

class _$SettingsRegisterStatusChangedImpl
    implements _SettingsRegisterStatusChanged {
  const _$SettingsRegisterStatusChangedImpl(this.value);

  @override
  final bool value;

  @override
  String toString() {
    return 'SettingsRegisterStatusChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsRegisterStatusChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

abstract class _SettingsRegisterStatusChanged
    implements SettingsRegisterStatusChanged {
  const factory _SettingsRegisterStatusChanged(final bool value) =
      _$SettingsRegisterStatusChangedImpl;

  @override
  bool get value;
}

/// @nodoc
mixin _$SettingsAccountDeleted {}

/// @nodoc

class _$SettingsAccountDeletedImpl implements _SettingsAccountDeleted {
  const _$SettingsAccountDeletedImpl();

  @override
  String toString() {
    return 'SettingsAccountDeleted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsAccountDeletedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _SettingsAccountDeleted implements SettingsAccountDeleted {
  const factory _SettingsAccountDeleted() = _$SettingsAccountDeletedImpl;
}

/// @nodoc
mixin _$SettingsState {
  bool get progress => throw _privateConstructorUsedError;
  bool get registerStatus => throw _privateConstructorUsedError;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettingsStateCopyWith<SettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
          SettingsState value, $Res Function(SettingsState) then) =
      _$SettingsStateCopyWithImpl<$Res, SettingsState>;
  @useResult
  $Res call({bool progress, bool registerStatus});
}

/// @nodoc
class _$SettingsStateCopyWithImpl<$Res, $Val extends SettingsState>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
    Object? registerStatus = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingsStateImplCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$$SettingsStateImplCopyWith(
          _$SettingsStateImpl value, $Res Function(_$SettingsStateImpl) then) =
      __$$SettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool progress, bool registerStatus});
}

/// @nodoc
class __$$SettingsStateImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$SettingsStateImpl>
    implements _$$SettingsStateImplCopyWith<$Res> {
  __$$SettingsStateImplCopyWithImpl(
      _$SettingsStateImpl _value, $Res Function(_$SettingsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
    Object? registerStatus = null,
  }) {
    return _then(_$SettingsStateImpl(
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as bool,
      registerStatus: null == registerStatus
          ? _value.registerStatus
          : registerStatus // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SettingsStateImpl implements _SettingsState {
  const _$SettingsStateImpl(
      {this.progress = false, required this.registerStatus});

  @override
  @JsonKey()
  final bool progress;
  @override
  final bool registerStatus;

  @override
  String toString() {
    return 'SettingsState(progress: $progress, registerStatus: $registerStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsStateImpl &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.registerStatus, registerStatus) ||
                other.registerStatus == registerStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, progress, registerStatus);

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsStateImplCopyWith<_$SettingsStateImpl> get copyWith =>
      __$$SettingsStateImplCopyWithImpl<_$SettingsStateImpl>(this, _$identity);
}

abstract class _SettingsState implements SettingsState {
  const factory _SettingsState(
      {final bool progress,
      required final bool registerStatus}) = _$SettingsStateImpl;

  @override
  bool get progress;
  @override
  bool get registerStatus;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingsStateImplCopyWith<_$SettingsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
