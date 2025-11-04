// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagnostic_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DiagnosticState {
  List<PermissionWithStatus> get permissions =>
      throw _privateConstructorUsedError;
  PushTokenStatus get pushTokenStatus => throw _privateConstructorUsedError;
  CallkeepAndroidBatteryMode get batteryMode =>
      throw _privateConstructorUsedError;

  /// Create a copy of DiagnosticState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiagnosticStateCopyWith<DiagnosticState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiagnosticStateCopyWith<$Res> {
  factory $DiagnosticStateCopyWith(
    DiagnosticState value,
    $Res Function(DiagnosticState) then,
  ) = _$DiagnosticStateCopyWithImpl<$Res, DiagnosticState>;
  @useResult
  $Res call({
    List<PermissionWithStatus> permissions,
    PushTokenStatus pushTokenStatus,
    CallkeepAndroidBatteryMode batteryMode,
  });
}

/// @nodoc
class _$DiagnosticStateCopyWithImpl<$Res, $Val extends DiagnosticState>
    implements $DiagnosticStateCopyWith<$Res> {
  _$DiagnosticStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiagnosticState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? permissions = null,
    Object? pushTokenStatus = null,
    Object? batteryMode = null,
  }) {
    return _then(
      _value.copyWith(
            permissions: null == permissions
                ? _value.permissions
                : permissions // ignore: cast_nullable_to_non_nullable
                      as List<PermissionWithStatus>,
            pushTokenStatus: null == pushTokenStatus
                ? _value.pushTokenStatus
                : pushTokenStatus // ignore: cast_nullable_to_non_nullable
                      as PushTokenStatus,
            batteryMode: null == batteryMode
                ? _value.batteryMode
                : batteryMode // ignore: cast_nullable_to_non_nullable
                      as CallkeepAndroidBatteryMode,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $DiagnosticStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<PermissionWithStatus> permissions,
    PushTokenStatus pushTokenStatus,
    CallkeepAndroidBatteryMode batteryMode,
  });
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$DiagnosticStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiagnosticState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? permissions = null,
    Object? pushTokenStatus = null,
    Object? batteryMode = null,
  }) {
    return _then(
      _$InitialImpl(
        permissions: null == permissions
            ? _value._permissions
            : permissions // ignore: cast_nullable_to_non_nullable
                  as List<PermissionWithStatus>,
        pushTokenStatus: null == pushTokenStatus
            ? _value.pushTokenStatus
            : pushTokenStatus // ignore: cast_nullable_to_non_nullable
                  as PushTokenStatus,
        batteryMode: null == batteryMode
            ? _value.batteryMode
            : batteryMode // ignore: cast_nullable_to_non_nullable
                  as CallkeepAndroidBatteryMode,
      ),
    );
  }
}

/// @nodoc

class _$InitialImpl extends _Initial {
  const _$InitialImpl({
    final List<PermissionWithStatus> permissions = const [],
    this.pushTokenStatus = const PushTokenStatus(),
    this.batteryMode = CallkeepAndroidBatteryMode.unknown,
  }) : _permissions = permissions,
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

  @override
  String toString() {
    return 'DiagnosticState(permissions: $permissions, pushTokenStatus: $pushTokenStatus, batteryMode: $batteryMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            const DeepCollectionEquality().equals(
              other._permissions,
              _permissions,
            ) &&
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
    batteryMode,
  );

  /// Create a copy of DiagnosticState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);
}

abstract class _Initial extends DiagnosticState {
  const factory _Initial({
    final List<PermissionWithStatus> permissions,
    final PushTokenStatus pushTokenStatus,
    final CallkeepAndroidBatteryMode batteryMode,
  }) = _$InitialImpl;
  const _Initial._() : super._();

  @override
  List<PermissionWithStatus> get permissions;
  @override
  PushTokenStatus get pushTokenStatus;
  @override
  CallkeepAndroidBatteryMode get batteryMode;

  /// Create a copy of DiagnosticState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
