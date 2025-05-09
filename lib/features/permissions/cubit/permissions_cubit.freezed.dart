// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permissions_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PermissionsState {
  PermissionsStatus get status => throw _privateConstructorUsedError;
  List<CallkeepSpecialPermissions> get requiredSpecialPermissions =>
      throw _privateConstructorUsedError;
  ManufacturerTip? get manufacturerTip => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;

  /// Create a copy of PermissionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PermissionsStateCopyWith<PermissionsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionsStateCopyWith<$Res> {
  factory $PermissionsStateCopyWith(
          PermissionsState value, $Res Function(PermissionsState) then) =
      _$PermissionsStateCopyWithImpl<$Res, PermissionsState>;
  @useResult
  $Res call(
      {PermissionsStatus status,
      List<CallkeepSpecialPermissions> requiredSpecialPermissions,
      ManufacturerTip? manufacturerTip,
      Object? error});

  $ManufacturerTipCopyWith<$Res>? get manufacturerTip;
}

/// @nodoc
class _$PermissionsStateCopyWithImpl<$Res, $Val extends PermissionsState>
    implements $PermissionsStateCopyWith<$Res> {
  _$PermissionsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PermissionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? requiredSpecialPermissions = null,
    Object? manufacturerTip = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PermissionsStatus,
      requiredSpecialPermissions: null == requiredSpecialPermissions
          ? _value.requiredSpecialPermissions
          : requiredSpecialPermissions // ignore: cast_nullable_to_non_nullable
              as List<CallkeepSpecialPermissions>,
      manufacturerTip: freezed == manufacturerTip
          ? _value.manufacturerTip
          : manufacturerTip // ignore: cast_nullable_to_non_nullable
              as ManufacturerTip?,
      error: freezed == error ? _value.error : error,
    ) as $Val);
  }

  /// Create a copy of PermissionsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ManufacturerTipCopyWith<$Res>? get manufacturerTip {
    if (_value.manufacturerTip == null) {
      return null;
    }

    return $ManufacturerTipCopyWith<$Res>(_value.manufacturerTip!, (value) {
      return _then(_value.copyWith(manufacturerTip: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PermissionsStateImplCopyWith<$Res>
    implements $PermissionsStateCopyWith<$Res> {
  factory _$$PermissionsStateImplCopyWith(_$PermissionsStateImpl value,
          $Res Function(_$PermissionsStateImpl) then) =
      __$$PermissionsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PermissionsStatus status,
      List<CallkeepSpecialPermissions> requiredSpecialPermissions,
      ManufacturerTip? manufacturerTip,
      Object? error});

  @override
  $ManufacturerTipCopyWith<$Res>? get manufacturerTip;
}

/// @nodoc
class __$$PermissionsStateImplCopyWithImpl<$Res>
    extends _$PermissionsStateCopyWithImpl<$Res, _$PermissionsStateImpl>
    implements _$$PermissionsStateImplCopyWith<$Res> {
  __$$PermissionsStateImplCopyWithImpl(_$PermissionsStateImpl _value,
      $Res Function(_$PermissionsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PermissionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? requiredSpecialPermissions = null,
    Object? manufacturerTip = freezed,
    Object? error = freezed,
  }) {
    return _then(_$PermissionsStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PermissionsStatus,
      requiredSpecialPermissions: null == requiredSpecialPermissions
          ? _value._requiredSpecialPermissions
          : requiredSpecialPermissions // ignore: cast_nullable_to_non_nullable
              as List<CallkeepSpecialPermissions>,
      manufacturerTip: freezed == manufacturerTip
          ? _value.manufacturerTip
          : manufacturerTip // ignore: cast_nullable_to_non_nullable
              as ManufacturerTip?,
      error: freezed == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$PermissionsStateImpl extends _PermissionsState {
  const _$PermissionsStateImpl(
      {this.status = PermissionsStatus.initial,
      final List<CallkeepSpecialPermissions> requiredSpecialPermissions =
          const [],
      this.manufacturerTip,
      this.error})
      : _requiredSpecialPermissions = requiredSpecialPermissions,
        super._();

  @override
  @JsonKey()
  final PermissionsStatus status;
  final List<CallkeepSpecialPermissions> _requiredSpecialPermissions;
  @override
  @JsonKey()
  List<CallkeepSpecialPermissions> get requiredSpecialPermissions {
    if (_requiredSpecialPermissions is EqualUnmodifiableListView)
      return _requiredSpecialPermissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredSpecialPermissions);
  }

  @override
  final ManufacturerTip? manufacturerTip;
  @override
  final Object? error;

  @override
  String toString() {
    return 'PermissionsState(status: $status, requiredSpecialPermissions: $requiredSpecialPermissions, manufacturerTip: $manufacturerTip, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionsStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(
                other._requiredSpecialPermissions,
                _requiredSpecialPermissions) &&
            (identical(other.manufacturerTip, manufacturerTip) ||
                other.manufacturerTip == manufacturerTip) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_requiredSpecialPermissions),
      manufacturerTip,
      const DeepCollectionEquality().hash(error));

  /// Create a copy of PermissionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionsStateImplCopyWith<_$PermissionsStateImpl> get copyWith =>
      __$$PermissionsStateImplCopyWithImpl<_$PermissionsStateImpl>(
          this, _$identity);
}

abstract class _PermissionsState extends PermissionsState {
  const factory _PermissionsState(
      {final PermissionsStatus status,
      final List<CallkeepSpecialPermissions> requiredSpecialPermissions,
      final ManufacturerTip? manufacturerTip,
      final Object? error}) = _$PermissionsStateImpl;
  const _PermissionsState._() : super._();

  @override
  PermissionsStatus get status;
  @override
  List<CallkeepSpecialPermissions> get requiredSpecialPermissions;
  @override
  ManufacturerTip? get manufacturerTip;
  @override
  Object? get error;

  /// Create a copy of PermissionsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PermissionsStateImplCopyWith<_$PermissionsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ManufacturerTip {
  Manufacturer get manufacturer =>
      throw _privateConstructorUsedError; // Indicates whether the tip has been shown to the user
  bool get shown => throw _privateConstructorUsedError;

  /// Create a copy of ManufacturerTip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ManufacturerTipCopyWith<ManufacturerTip> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManufacturerTipCopyWith<$Res> {
  factory $ManufacturerTipCopyWith(
          ManufacturerTip value, $Res Function(ManufacturerTip) then) =
      _$ManufacturerTipCopyWithImpl<$Res, ManufacturerTip>;
  @useResult
  $Res call({Manufacturer manufacturer, bool shown});
}

/// @nodoc
class _$ManufacturerTipCopyWithImpl<$Res, $Val extends ManufacturerTip>
    implements $ManufacturerTipCopyWith<$Res> {
  _$ManufacturerTipCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ManufacturerTip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? manufacturer = null,
    Object? shown = null,
  }) {
    return _then(_value.copyWith(
      manufacturer: null == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as Manufacturer,
      shown: null == shown
          ? _value.shown
          : shown // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ManufacturerTipImplCopyWith<$Res>
    implements $ManufacturerTipCopyWith<$Res> {
  factory _$$ManufacturerTipImplCopyWith(_$ManufacturerTipImpl value,
          $Res Function(_$ManufacturerTipImpl) then) =
      __$$ManufacturerTipImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Manufacturer manufacturer, bool shown});
}

/// @nodoc
class __$$ManufacturerTipImplCopyWithImpl<$Res>
    extends _$ManufacturerTipCopyWithImpl<$Res, _$ManufacturerTipImpl>
    implements _$$ManufacturerTipImplCopyWith<$Res> {
  __$$ManufacturerTipImplCopyWithImpl(
      _$ManufacturerTipImpl _value, $Res Function(_$ManufacturerTipImpl) _then)
      : super(_value, _then);

  /// Create a copy of ManufacturerTip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? manufacturer = null,
    Object? shown = null,
  }) {
    return _then(_$ManufacturerTipImpl(
      manufacturer: null == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as Manufacturer,
      shown: null == shown
          ? _value.shown
          : shown // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ManufacturerTipImpl implements _ManufacturerTip {
  const _$ManufacturerTipImpl({required this.manufacturer, this.shown = false});

  @override
  final Manufacturer manufacturer;
// Indicates whether the tip has been shown to the user
  @override
  @JsonKey()
  final bool shown;

  @override
  String toString() {
    return 'ManufacturerTip(manufacturer: $manufacturer, shown: $shown)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ManufacturerTipImpl &&
            (identical(other.manufacturer, manufacturer) ||
                other.manufacturer == manufacturer) &&
            (identical(other.shown, shown) || other.shown == shown));
  }

  @override
  int get hashCode => Object.hash(runtimeType, manufacturer, shown);

  /// Create a copy of ManufacturerTip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ManufacturerTipImplCopyWith<_$ManufacturerTipImpl> get copyWith =>
      __$$ManufacturerTipImplCopyWithImpl<_$ManufacturerTipImpl>(
          this, _$identity);
}

abstract class _ManufacturerTip implements ManufacturerTip {
  const factory _ManufacturerTip(
      {required final Manufacturer manufacturer,
      final bool shown}) = _$ManufacturerTipImpl;

  @override
  Manufacturer
      get manufacturer; // Indicates whether the tip has been shown to the user
  @override
  bool get shown;

  /// Create a copy of ManufacturerTip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ManufacturerTipImplCopyWith<_$ManufacturerTipImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
