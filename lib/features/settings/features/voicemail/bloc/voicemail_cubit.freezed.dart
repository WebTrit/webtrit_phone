// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voicemail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VoicemailState {
  VoicemailStatus get status => throw _privateConstructorUsedError;
  List<Voicemail> get items => throw _privateConstructorUsedError;
  DefaultErrorNotification? get error => throw _privateConstructorUsedError;

  /// Create a copy of VoicemailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoicemailStateCopyWith<VoicemailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoicemailStateCopyWith<$Res> {
  factory $VoicemailStateCopyWith(
          VoicemailState value, $Res Function(VoicemailState) then) =
      _$VoicemailStateCopyWithImpl<$Res, VoicemailState>;
  @useResult
  $Res call(
      {VoicemailStatus status,
      List<Voicemail> items,
      DefaultErrorNotification? error});
}

/// @nodoc
class _$VoicemailStateCopyWithImpl<$Res, $Val extends VoicemailState>
    implements $VoicemailStateCopyWith<$Res> {
  _$VoicemailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoicemailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? items = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VoicemailStatus,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Voicemail>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as DefaultErrorNotification?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoicemailStateImplCopyWith<$Res>
    implements $VoicemailStateCopyWith<$Res> {
  factory _$$VoicemailStateImplCopyWith(_$VoicemailStateImpl value,
          $Res Function(_$VoicemailStateImpl) then) =
      __$$VoicemailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {VoicemailStatus status,
      List<Voicemail> items,
      DefaultErrorNotification? error});
}

/// @nodoc
class __$$VoicemailStateImplCopyWithImpl<$Res>
    extends _$VoicemailStateCopyWithImpl<$Res, _$VoicemailStateImpl>
    implements _$$VoicemailStateImplCopyWith<$Res> {
  __$$VoicemailStateImplCopyWithImpl(
      _$VoicemailStateImpl _value, $Res Function(_$VoicemailStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoicemailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? items = null,
    Object? error = freezed,
  }) {
    return _then(_$VoicemailStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VoicemailStatus,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Voicemail>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as DefaultErrorNotification?,
    ));
  }
}

/// @nodoc

class _$VoicemailStateImpl extends _VoicemailState
    with DiagnosticableTreeMixin {
  const _$VoicemailStateImpl(
      {this.status = VoicemailStatus.loading,
      final List<Voicemail> items = const [],
      this.error})
      : _items = items,
        super._();

  @override
  @JsonKey()
  final VoicemailStatus status;
  final List<Voicemail> _items;
  @override
  @JsonKey()
  List<Voicemail> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final DefaultErrorNotification? error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VoicemailState(status: $status, items: $items, error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VoicemailState'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoicemailStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_items), error);

  /// Create a copy of VoicemailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoicemailStateImplCopyWith<_$VoicemailStateImpl> get copyWith =>
      __$$VoicemailStateImplCopyWithImpl<_$VoicemailStateImpl>(
          this, _$identity);
}

abstract class _VoicemailState extends VoicemailState {
  const factory _VoicemailState(
      {final VoicemailStatus status,
      final List<Voicemail> items,
      final DefaultErrorNotification? error}) = _$VoicemailStateImpl;
  const _VoicemailState._() : super._();

  @override
  VoicemailStatus get status;
  @override
  List<Voicemail> get items;
  @override
  DefaultErrorNotification? get error;

  /// Create a copy of VoicemailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoicemailStateImplCopyWith<_$VoicemailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
