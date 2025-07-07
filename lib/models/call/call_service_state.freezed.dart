// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_service_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CallServiceState {
  SignalingClientStatus get signalingClientStatus =>
      throw _privateConstructorUsedError;
  Registration get registration => throw _privateConstructorUsedError;
  NetworkStatus? get networkStatus => throw _privateConstructorUsedError;
  Object? get lastSignalingClientConnectError =>
      throw _privateConstructorUsedError;
  Object? get lastSignalingClientDisconnectError =>
      throw _privateConstructorUsedError;
  int? get lastSignalingDisconnectCode => throw _privateConstructorUsedError;

  /// Create a copy of CallServiceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallServiceStateCopyWith<CallServiceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallServiceStateCopyWith<$Res> {
  factory $CallServiceStateCopyWith(
          CallServiceState value, $Res Function(CallServiceState) then) =
      _$CallServiceStateCopyWithImpl<$Res, CallServiceState>;
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
class _$CallServiceStateCopyWithImpl<$Res, $Val extends CallServiceState>
    implements $CallServiceStateCopyWith<$Res> {
  _$CallServiceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      signalingClientStatus: null == signalingClientStatus
          ? _value.signalingClientStatus
          : signalingClientStatus // ignore: cast_nullable_to_non_nullable
              as SignalingClientStatus,
      registration: null == registration
          ? _value.registration
          : registration // ignore: cast_nullable_to_non_nullable
              as Registration,
      networkStatus: freezed == networkStatus
          ? _value.networkStatus
          : networkStatus // ignore: cast_nullable_to_non_nullable
              as NetworkStatus?,
      lastSignalingClientConnectError:
          freezed == lastSignalingClientConnectError
              ? _value.lastSignalingClientConnectError
              : lastSignalingClientConnectError,
      lastSignalingClientDisconnectError:
          freezed == lastSignalingClientDisconnectError
              ? _value.lastSignalingClientDisconnectError
              : lastSignalingClientDisconnectError,
      lastSignalingDisconnectCode: freezed == lastSignalingDisconnectCode
          ? _value.lastSignalingDisconnectCode
          : lastSignalingDisconnectCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CallServiceStateImplCopyWith<$Res>
    implements $CallServiceStateCopyWith<$Res> {
  factory _$$CallServiceStateImplCopyWith(_$CallServiceStateImpl value,
          $Res Function(_$CallServiceStateImpl) then) =
      __$$CallServiceStateImplCopyWithImpl<$Res>;
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
class __$$CallServiceStateImplCopyWithImpl<$Res>
    extends _$CallServiceStateCopyWithImpl<$Res, _$CallServiceStateImpl>
    implements _$$CallServiceStateImplCopyWith<$Res> {
  __$$CallServiceStateImplCopyWithImpl(_$CallServiceStateImpl _value,
      $Res Function(_$CallServiceStateImpl) _then)
      : super(_value, _then);

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
    return _then(_$CallServiceStateImpl(
      signalingClientStatus: null == signalingClientStatus
          ? _value.signalingClientStatus
          : signalingClientStatus // ignore: cast_nullable_to_non_nullable
              as SignalingClientStatus,
      registration: null == registration
          ? _value.registration
          : registration // ignore: cast_nullable_to_non_nullable
              as Registration,
      networkStatus: freezed == networkStatus
          ? _value.networkStatus
          : networkStatus // ignore: cast_nullable_to_non_nullable
              as NetworkStatus?,
      lastSignalingClientConnectError:
          freezed == lastSignalingClientConnectError
              ? _value.lastSignalingClientConnectError
              : lastSignalingClientConnectError,
      lastSignalingClientDisconnectError:
          freezed == lastSignalingClientDisconnectError
              ? _value.lastSignalingClientDisconnectError
              : lastSignalingClientDisconnectError,
      lastSignalingDisconnectCode: freezed == lastSignalingDisconnectCode
          ? _value.lastSignalingDisconnectCode
          : lastSignalingDisconnectCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$CallServiceStateImpl extends _CallServiceState {
  const _$CallServiceStateImpl(
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

  @override
  String toString() {
    return 'CallServiceState(signalingClientStatus: $signalingClientStatus, registration: $registration, networkStatus: $networkStatus, lastSignalingClientConnectError: $lastSignalingClientConnectError, lastSignalingClientDisconnectError: $lastSignalingClientDisconnectError, lastSignalingDisconnectCode: $lastSignalingDisconnectCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallServiceStateImpl &&
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

  /// Create a copy of CallServiceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallServiceStateImplCopyWith<_$CallServiceStateImpl> get copyWith =>
      __$$CallServiceStateImplCopyWithImpl<_$CallServiceStateImpl>(
          this, _$identity);
}

abstract class _CallServiceState extends CallServiceState {
  const factory _CallServiceState(
      {final SignalingClientStatus signalingClientStatus,
      final Registration registration,
      final NetworkStatus? networkStatus,
      final Object? lastSignalingClientConnectError,
      final Object? lastSignalingClientDisconnectError,
      final int? lastSignalingDisconnectCode}) = _$CallServiceStateImpl;
  const _CallServiceState._() : super._();

  @override
  SignalingClientStatus get signalingClientStatus;
  @override
  Registration get registration;
  @override
  NetworkStatus? get networkStatus;
  @override
  Object? get lastSignalingClientConnectError;
  @override
  Object? get lastSignalingClientDisconnectError;
  @override
  int? get lastSignalingDisconnectCode;

  /// Create a copy of CallServiceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallServiceStateImplCopyWith<_$CallServiceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
