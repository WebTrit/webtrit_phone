// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagnostic_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiagnosticState {
  List<PermissionWithStatus> get permissions;
  PushTokenStatus get pushTokenStatus;
  CallkeepAndroidBatteryMode get batteryMode;

  /// Create a copy of DiagnosticState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DiagnosticStateCopyWith<DiagnosticState> get copyWith =>
      _$DiagnosticStateCopyWithImpl<DiagnosticState>(
          this as DiagnosticState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DiagnosticState &&
            const DeepCollectionEquality()
                .equals(other.permissions, permissions) &&
            (identical(other.pushTokenStatus, pushTokenStatus) ||
                other.pushTokenStatus == pushTokenStatus) &&
            (identical(other.batteryMode, batteryMode) ||
                other.batteryMode == batteryMode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(permissions),
      pushTokenStatus,
      batteryMode);

  @override
  String toString() {
    return 'DiagnosticState(permissions: $permissions, pushTokenStatus: $pushTokenStatus, batteryMode: $batteryMode)';
  }
}

/// @nodoc
abstract mixin class $DiagnosticStateCopyWith<$Res> {
  factory $DiagnosticStateCopyWith(
          DiagnosticState value, $Res Function(DiagnosticState) _then) =
      _$DiagnosticStateCopyWithImpl;
  @useResult
  $Res call(
      {List<PermissionWithStatus> permissions,
      PushTokenStatus pushTokenStatus,
      CallkeepAndroidBatteryMode batteryMode});
}

/// @nodoc
class _$DiagnosticStateCopyWithImpl<$Res>
    implements $DiagnosticStateCopyWith<$Res> {
  _$DiagnosticStateCopyWithImpl(this._self, this._then);

  final DiagnosticState _self;
  final $Res Function(DiagnosticState) _then;

  /// Create a copy of DiagnosticState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? permissions = null,
    Object? pushTokenStatus = null,
    Object? batteryMode = null,
  }) {
    return _then(_self.copyWith(
      permissions: null == permissions
          ? _self.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<PermissionWithStatus>,
      pushTokenStatus: null == pushTokenStatus
          ? _self.pushTokenStatus
          : pushTokenStatus // ignore: cast_nullable_to_non_nullable
              as PushTokenStatus,
      batteryMode: null == batteryMode
          ? _self.batteryMode
          : batteryMode // ignore: cast_nullable_to_non_nullable
              as CallkeepAndroidBatteryMode,
    ));
  }
}

/// Adds pattern-matching-related methods to [DiagnosticState].
extension DiagnosticStatePatterns on DiagnosticState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Initial value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Initial value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Initial value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Initial() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            List<PermissionWithStatus> permissions,
            PushTokenStatus pushTokenStatus,
            CallkeepAndroidBatteryMode batteryMode)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when $default != null:
        return $default(
            _that.permissions, _that.pushTokenStatus, _that.batteryMode);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            List<PermissionWithStatus> permissions,
            PushTokenStatus pushTokenStatus,
            CallkeepAndroidBatteryMode batteryMode)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return $default(
            _that.permissions, _that.pushTokenStatus, _that.batteryMode);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            List<PermissionWithStatus> permissions,
            PushTokenStatus pushTokenStatus,
            CallkeepAndroidBatteryMode batteryMode)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Initial() when $default != null:
        return $default(
            _that.permissions, _that.pushTokenStatus, _that.batteryMode);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Initial extends DiagnosticState {
  const _Initial(
      {final List<PermissionWithStatus> permissions = const [],
      this.pushTokenStatus = const PushTokenStatus(),
      this.batteryMode = CallkeepAndroidBatteryMode.unknown})
      : _permissions = permissions,
        super._();

  final List<PermissionWithStatus> _permissions;
  @override
  @JsonKey()
  List<PermissionWithStatus> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  @override
  @JsonKey()
  final PushTokenStatus pushTokenStatus;
  @override
  @JsonKey()
  final CallkeepAndroidBatteryMode batteryMode;

  /// Create a copy of DiagnosticState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            (identical(other.pushTokenStatus, pushTokenStatus) ||
                other.pushTokenStatus == pushTokenStatus) &&
            (identical(other.batteryMode, batteryMode) ||
                other.batteryMode == batteryMode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_permissions),
      pushTokenStatus,
      batteryMode);

  @override
  String toString() {
    return 'DiagnosticState(permissions: $permissions, pushTokenStatus: $pushTokenStatus, batteryMode: $batteryMode)';
  }
}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res>
    implements $DiagnosticStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) =
      __$InitialCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<PermissionWithStatus> permissions,
      PushTokenStatus pushTokenStatus,
      CallkeepAndroidBatteryMode batteryMode});
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

  /// Create a copy of DiagnosticState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? permissions = null,
    Object? pushTokenStatus = null,
    Object? batteryMode = null,
  }) {
    return _then(_Initial(
      permissions: null == permissions
          ? _self._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<PermissionWithStatus>,
      pushTokenStatus: null == pushTokenStatus
          ? _self.pushTokenStatus
          : pushTokenStatus // ignore: cast_nullable_to_non_nullable
              as PushTokenStatus,
      batteryMode: null == batteryMode
          ? _self.batteryMode
          : batteryMode // ignore: cast_nullable_to_non_nullable
              as CallkeepAndroidBatteryMode,
    ));
  }
}

// dart format on
