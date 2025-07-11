// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NetworkState {
  List<IncomingCallTypeModel> get incomingCallTypeModels =>
      throw _privateConstructorUsedError;
  List<IncomingCallType> get incomingCallTypesRemainder =>
      throw _privateConstructorUsedError;
  bool get smsFallbackEnabled => throw _privateConstructorUsedError;

  /// Create a copy of NetworkState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NetworkStateCopyWith<NetworkState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkStateCopyWith<$Res> {
  factory $NetworkStateCopyWith(
          NetworkState value, $Res Function(NetworkState) then) =
      _$NetworkStateCopyWithImpl<$Res, NetworkState>;
  @useResult
  $Res call(
      {List<IncomingCallTypeModel> incomingCallTypeModels,
      List<IncomingCallType> incomingCallTypesRemainder,
      bool smsFallbackEnabled});
}

/// @nodoc
class _$NetworkStateCopyWithImpl<$Res, $Val extends NetworkState>
    implements $NetworkStateCopyWith<$Res> {
  _$NetworkStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NetworkState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? incomingCallTypeModels = null,
    Object? incomingCallTypesRemainder = null,
    Object? smsFallbackEnabled = null,
  }) {
    return _then(_value.copyWith(
      incomingCallTypeModels: null == incomingCallTypeModels
          ? _value.incomingCallTypeModels
          : incomingCallTypeModels // ignore: cast_nullable_to_non_nullable
              as List<IncomingCallTypeModel>,
      incomingCallTypesRemainder: null == incomingCallTypesRemainder
          ? _value.incomingCallTypesRemainder
          : incomingCallTypesRemainder // ignore: cast_nullable_to_non_nullable
              as List<IncomingCallType>,
      smsFallbackEnabled: null == smsFallbackEnabled
          ? _value.smsFallbackEnabled
          : smsFallbackEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NetworkStateImplCopyWith<$Res>
    implements $NetworkStateCopyWith<$Res> {
  factory _$$NetworkStateImplCopyWith(
          _$NetworkStateImpl value, $Res Function(_$NetworkStateImpl) then) =
      __$$NetworkStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<IncomingCallTypeModel> incomingCallTypeModels,
      List<IncomingCallType> incomingCallTypesRemainder,
      bool smsFallbackEnabled});
}

/// @nodoc
class __$$NetworkStateImplCopyWithImpl<$Res>
    extends _$NetworkStateCopyWithImpl<$Res, _$NetworkStateImpl>
    implements _$$NetworkStateImplCopyWith<$Res> {
  __$$NetworkStateImplCopyWithImpl(
      _$NetworkStateImpl _value, $Res Function(_$NetworkStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NetworkState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? incomingCallTypeModels = null,
    Object? incomingCallTypesRemainder = null,
    Object? smsFallbackEnabled = null,
  }) {
    return _then(_$NetworkStateImpl(
      incomingCallTypeModels: null == incomingCallTypeModels
          ? _value._incomingCallTypeModels
          : incomingCallTypeModels // ignore: cast_nullable_to_non_nullable
              as List<IncomingCallTypeModel>,
      incomingCallTypesRemainder: null == incomingCallTypesRemainder
          ? _value._incomingCallTypesRemainder
          : incomingCallTypesRemainder // ignore: cast_nullable_to_non_nullable
              as List<IncomingCallType>,
      smsFallbackEnabled: null == smsFallbackEnabled
          ? _value.smsFallbackEnabled
          : smsFallbackEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$NetworkStateImpl extends _NetworkState {
  const _$NetworkStateImpl(
      {final List<IncomingCallTypeModel> incomingCallTypeModels = const [],
      final List<IncomingCallType> incomingCallTypesRemainder = const [],
      this.smsFallbackEnabled = false})
      : _incomingCallTypeModels = incomingCallTypeModels,
        _incomingCallTypesRemainder = incomingCallTypesRemainder,
        super._();

  final List<IncomingCallTypeModel> _incomingCallTypeModels;
  @override
  @JsonKey()
  List<IncomingCallTypeModel> get incomingCallTypeModels {
    if (_incomingCallTypeModels is EqualUnmodifiableListView)
      return _incomingCallTypeModels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_incomingCallTypeModels);
  }

  final List<IncomingCallType> _incomingCallTypesRemainder;
  @override
  @JsonKey()
  List<IncomingCallType> get incomingCallTypesRemainder {
    if (_incomingCallTypesRemainder is EqualUnmodifiableListView)
      return _incomingCallTypesRemainder;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_incomingCallTypesRemainder);
  }

  @override
  @JsonKey()
  final bool smsFallbackEnabled;

  @override
  String toString() {
    return 'NetworkState(incomingCallTypeModels: $incomingCallTypeModels, incomingCallTypesRemainder: $incomingCallTypesRemainder, smsFallbackEnabled: $smsFallbackEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkStateImpl &&
            const DeepCollectionEquality().equals(
                other._incomingCallTypeModels, _incomingCallTypeModels) &&
            const DeepCollectionEquality().equals(
                other._incomingCallTypesRemainder,
                _incomingCallTypesRemainder) &&
            (identical(other.smsFallbackEnabled, smsFallbackEnabled) ||
                other.smsFallbackEnabled == smsFallbackEnabled));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_incomingCallTypeModels),
      const DeepCollectionEquality().hash(_incomingCallTypesRemainder),
      smsFallbackEnabled);

  /// Create a copy of NetworkState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkStateImplCopyWith<_$NetworkStateImpl> get copyWith =>
      __$$NetworkStateImplCopyWithImpl<_$NetworkStateImpl>(this, _$identity);
}

abstract class _NetworkState extends NetworkState {
  const factory _NetworkState(
      {final List<IncomingCallTypeModel> incomingCallTypeModels,
      final List<IncomingCallType> incomingCallTypesRemainder,
      final bool smsFallbackEnabled}) = _$NetworkStateImpl;
  const _NetworkState._() : super._();

  @override
  List<IncomingCallTypeModel> get incomingCallTypeModels;
  @override
  List<IncomingCallType> get incomingCallTypesRemainder;
  @override
  bool get smsFallbackEnabled;

  /// Create a copy of NetworkState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkStateImplCopyWith<_$NetworkStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
