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
  Map<String, String> get mediaHeaders => throw _privateConstructorUsedError;
  List<Voicemail> get items => throw _privateConstructorUsedError;

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
  $Res call({Map<String, String> mediaHeaders, List<Voicemail> items});
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
    Object? mediaHeaders = null,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      mediaHeaders: null == mediaHeaders
          ? _value.mediaHeaders
          : mediaHeaders // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Voicemail>,
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
  $Res call({Map<String, String> mediaHeaders, List<Voicemail> items});
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
    Object? mediaHeaders = null,
    Object? items = null,
  }) {
    return _then(_$VoicemailStateImpl(
      mediaHeaders: null == mediaHeaders
          ? _value._mediaHeaders
          : mediaHeaders // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Voicemail>,
    ));
  }
}

/// @nodoc

class _$VoicemailStateImpl implements _VoicemailState {
  const _$VoicemailStateImpl(
      {required final Map<String, String> mediaHeaders,
      final List<Voicemail> items = const []})
      : _mediaHeaders = mediaHeaders,
        _items = items;

  final Map<String, String> _mediaHeaders;
  @override
  Map<String, String> get mediaHeaders {
    if (_mediaHeaders is EqualUnmodifiableMapView) return _mediaHeaders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_mediaHeaders);
  }

  final List<Voicemail> _items;
  @override
  @JsonKey()
  List<Voicemail> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'VoicemailState(mediaHeaders: $mediaHeaders, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoicemailStateImpl &&
            const DeepCollectionEquality()
                .equals(other._mediaHeaders, _mediaHeaders) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_mediaHeaders),
      const DeepCollectionEquality().hash(_items));

  /// Create a copy of VoicemailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoicemailStateImplCopyWith<_$VoicemailStateImpl> get copyWith =>
      __$$VoicemailStateImplCopyWithImpl<_$VoicemailStateImpl>(
          this, _$identity);
}

abstract class _VoicemailState implements VoicemailState {
  const factory _VoicemailState(
      {required final Map<String, String> mediaHeaders,
      final List<Voicemail> items}) = _$VoicemailStateImpl;

  @override
  Map<String, String> get mediaHeaders;
  @override
  List<Voicemail> get items;

  /// Create a copy of VoicemailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoicemailStateImplCopyWith<_$VoicemailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
