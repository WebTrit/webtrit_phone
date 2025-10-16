// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_service_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallServiceState {
  SignalingClientStatus get signalingClientStatus;
  Registration get registration;
  NetworkStatus? get networkStatus;
  Object? get lastSignalingClientConnectError;
  Object? get lastSignalingClientDisconnectError;
  int? get lastSignalingDisconnectCode;

  /// Create a copy of CallServiceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CallServiceStateCopyWith<CallServiceState> get copyWith =>
      _$CallServiceStateCopyWithImpl<CallServiceState>(
          this as CallServiceState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CallServiceState &&
            (identical(other.signalingClientStatus, signalingClientStatus) ||
                other.signalingClientStatus == signalingClientStatus) &&
            (identical(other.registration, registration) ||
                other.registration == registration) &&
            (identical(other.networkStatus, networkStatus) ||
                other.networkStatus == networkStatus) &&
            const DeepCollectionEquality().equals(
                other.lastSignalingClientConnectError,
                lastSignalingClientConnectError) &&
            const DeepCollectionEquality().equals(
                other.lastSignalingClientDisconnectError,
                lastSignalingClientDisconnectError) &&
            (identical(other.lastSignalingDisconnectCode,
                    lastSignalingDisconnectCode) ||
                other.lastSignalingDisconnectCode ==
                    lastSignalingDisconnectCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      signalingClientStatus,
      registration,
      networkStatus,
      const DeepCollectionEquality().hash(lastSignalingClientConnectError),
      const DeepCollectionEquality().hash(lastSignalingClientDisconnectError),
      lastSignalingDisconnectCode);

  @override
  String toString() {
    return 'CallServiceState(signalingClientStatus: $signalingClientStatus, registration: $registration, networkStatus: $networkStatus, lastSignalingClientConnectError: $lastSignalingClientConnectError, lastSignalingClientDisconnectError: $lastSignalingClientDisconnectError, lastSignalingDisconnectCode: $lastSignalingDisconnectCode)';
  }
}

/// @nodoc
abstract mixin class $CallServiceStateCopyWith<$Res> {
  factory $CallServiceStateCopyWith(
          CallServiceState value, $Res Function(CallServiceState) _then) =
      _$CallServiceStateCopyWithImpl;
  @useResult
  $Res call(
      {SignalingClientStatus signalingClientStatus,
      Registration registration,
      NetworkStatus? networkStatus,
      Object? lastSignalingClientConnectError,
      Object? lastSignalingClientDisconnectError,
      int? lastSignalingDisconnectCode});
}

/// @nodoc
class _$CallServiceStateCopyWithImpl<$Res>
    implements $CallServiceStateCopyWith<$Res> {
  _$CallServiceStateCopyWithImpl(this._self, this._then);

  final CallServiceState _self;
  final $Res Function(CallServiceState) _then;

  /// Create a copy of CallServiceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signalingClientStatus = null,
    Object? registration = null,
    Object? networkStatus = freezed,
    Object? lastSignalingClientConnectError = freezed,
    Object? lastSignalingClientDisconnectError = freezed,
    Object? lastSignalingDisconnectCode = freezed,
  }) {
    return _then(_self.copyWith(
      signalingClientStatus: null == signalingClientStatus
          ? _self.signalingClientStatus
          : signalingClientStatus // ignore: cast_nullable_to_non_nullable
              as SignalingClientStatus,
      registration: null == registration
          ? _self.registration
          : registration // ignore: cast_nullable_to_non_nullable
              as Registration,
      networkStatus: freezed == networkStatus
          ? _self.networkStatus
          : networkStatus // ignore: cast_nullable_to_non_nullable
              as NetworkStatus?,
      lastSignalingClientConnectError:
          freezed == lastSignalingClientConnectError
              ? _self.lastSignalingClientConnectError
              : lastSignalingClientConnectError,
      lastSignalingClientDisconnectError:
          freezed == lastSignalingClientDisconnectError
              ? _self.lastSignalingClientDisconnectError
              : lastSignalingClientDisconnectError,
      lastSignalingDisconnectCode: freezed == lastSignalingDisconnectCode
          ? _self.lastSignalingDisconnectCode
          : lastSignalingDisconnectCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CallServiceState].
extension CallServiceStatePatterns on CallServiceState {
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
    TResult Function(_CallServiceState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallServiceState() when $default != null:
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
    TResult Function(_CallServiceState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallServiceState():
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
    TResult? Function(_CallServiceState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallServiceState() when $default != null:
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
            SignalingClientStatus signalingClientStatus,
            Registration registration,
            NetworkStatus? networkStatus,
            Object? lastSignalingClientConnectError,
            Object? lastSignalingClientDisconnectError,
            int? lastSignalingDisconnectCode)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CallServiceState() when $default != null:
        return $default(
            _that.signalingClientStatus,
            _that.registration,
            _that.networkStatus,
            _that.lastSignalingClientConnectError,
            _that.lastSignalingClientDisconnectError,
            _that.lastSignalingDisconnectCode);
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
            SignalingClientStatus signalingClientStatus,
            Registration registration,
            NetworkStatus? networkStatus,
            Object? lastSignalingClientConnectError,
            Object? lastSignalingClientDisconnectError,
            int? lastSignalingDisconnectCode)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallServiceState():
        return $default(
            _that.signalingClientStatus,
            _that.registration,
            _that.networkStatus,
            _that.lastSignalingClientConnectError,
            _that.lastSignalingClientDisconnectError,
            _that.lastSignalingDisconnectCode);
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
            SignalingClientStatus signalingClientStatus,
            Registration registration,
            NetworkStatus? networkStatus,
            Object? lastSignalingClientConnectError,
            Object? lastSignalingClientDisconnectError,
            int? lastSignalingDisconnectCode)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CallServiceState() when $default != null:
        return $default(
            _that.signalingClientStatus,
            _that.registration,
            _that.networkStatus,
            _that.lastSignalingClientConnectError,
            _that.lastSignalingClientDisconnectError,
            _that.lastSignalingDisconnectCode);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CallServiceState extends CallServiceState {
  const _CallServiceState(
      {this.signalingClientStatus = SignalingClientStatus.connecting,
      this.registration =
          const Registration(status: RegistrationStatus.registering),
      this.networkStatus = null,
      this.lastSignalingClientConnectError,
      this.lastSignalingClientDisconnectError,
      this.lastSignalingDisconnectCode})
      : super._();

  @override
  @JsonKey()
  final SignalingClientStatus signalingClientStatus;
  @override
  @JsonKey()
  final Registration registration;
  @override
  @JsonKey()
  final NetworkStatus? networkStatus;
  @override
  final Object? lastSignalingClientConnectError;
  @override
  final Object? lastSignalingClientDisconnectError;
  @override
  final int? lastSignalingDisconnectCode;

  /// Create a copy of CallServiceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CallServiceStateCopyWith<_CallServiceState> get copyWith =>
      __$CallServiceStateCopyWithImpl<_CallServiceState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CallServiceState &&
            (identical(other.signalingClientStatus, signalingClientStatus) ||
                other.signalingClientStatus == signalingClientStatus) &&
            (identical(other.registration, registration) ||
                other.registration == registration) &&
            (identical(other.networkStatus, networkStatus) ||
                other.networkStatus == networkStatus) &&
            const DeepCollectionEquality().equals(
                other.lastSignalingClientConnectError,
                lastSignalingClientConnectError) &&
            const DeepCollectionEquality().equals(
                other.lastSignalingClientDisconnectError,
                lastSignalingClientDisconnectError) &&
            (identical(other.lastSignalingDisconnectCode,
                    lastSignalingDisconnectCode) ||
                other.lastSignalingDisconnectCode ==
                    lastSignalingDisconnectCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      signalingClientStatus,
      registration,
      networkStatus,
      const DeepCollectionEquality().hash(lastSignalingClientConnectError),
      const DeepCollectionEquality().hash(lastSignalingClientDisconnectError),
      lastSignalingDisconnectCode);

  @override
  String toString() {
    return 'CallServiceState(signalingClientStatus: $signalingClientStatus, registration: $registration, networkStatus: $networkStatus, lastSignalingClientConnectError: $lastSignalingClientConnectError, lastSignalingClientDisconnectError: $lastSignalingClientDisconnectError, lastSignalingDisconnectCode: $lastSignalingDisconnectCode)';
  }
}

/// @nodoc
abstract mixin class _$CallServiceStateCopyWith<$Res>
    implements $CallServiceStateCopyWith<$Res> {
  factory _$CallServiceStateCopyWith(
          _CallServiceState value, $Res Function(_CallServiceState) _then) =
      __$CallServiceStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {SignalingClientStatus signalingClientStatus,
      Registration registration,
      NetworkStatus? networkStatus,
      Object? lastSignalingClientConnectError,
      Object? lastSignalingClientDisconnectError,
      int? lastSignalingDisconnectCode});
}

/// @nodoc
class __$CallServiceStateCopyWithImpl<$Res>
    implements _$CallServiceStateCopyWith<$Res> {
  __$CallServiceStateCopyWithImpl(this._self, this._then);

  final _CallServiceState _self;
  final $Res Function(_CallServiceState) _then;

  /// Create a copy of CallServiceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? signalingClientStatus = null,
    Object? registration = null,
    Object? networkStatus = freezed,
    Object? lastSignalingClientConnectError = freezed,
    Object? lastSignalingClientDisconnectError = freezed,
    Object? lastSignalingDisconnectCode = freezed,
  }) {
    return _then(_CallServiceState(
      signalingClientStatus: null == signalingClientStatus
          ? _self.signalingClientStatus
          : signalingClientStatus // ignore: cast_nullable_to_non_nullable
              as SignalingClientStatus,
      registration: null == registration
          ? _self.registration
          : registration // ignore: cast_nullable_to_non_nullable
              as Registration,
      networkStatus: freezed == networkStatus
          ? _self.networkStatus
          : networkStatus // ignore: cast_nullable_to_non_nullable
              as NetworkStatus?,
      lastSignalingClientConnectError:
          freezed == lastSignalingClientConnectError
              ? _self.lastSignalingClientConnectError
              : lastSignalingClientConnectError,
      lastSignalingClientDisconnectError:
          freezed == lastSignalingClientDisconnectError
              ? _self.lastSignalingClientDisconnectError
              : lastSignalingClientDisconnectError,
      lastSignalingDisconnectCode: freezed == lastSignalingDisconnectCode
          ? _self.lastSignalingDisconnectCode
          : lastSignalingDisconnectCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
