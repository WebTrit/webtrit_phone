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
  List<UserVoicemailItem> get items => throw _privateConstructorUsedError;

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
  $Res call({List<UserVoicemailItem> items});
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
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<UserVoicemailItem>,
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
  $Res call({List<UserVoicemailItem> items});
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
    Object? items = null,
  }) {
    return _then(_$VoicemailStateImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<UserVoicemailItem>,
    ));
  }
}

/// @nodoc

class _$VoicemailStateImpl implements _VoicemailState {
  const _$VoicemailStateImpl({final List<UserVoicemailItem> items = const []})
      : _items = items;

  final List<UserVoicemailItem> _items;
  @override
  @JsonKey()
  List<UserVoicemailItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'VoicemailState(items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoicemailStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

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
  const factory _VoicemailState({final List<UserVoicemailItem> items}) =
      _$VoicemailStateImpl;

  @override
  List<UserVoicemailItem> get items;

  /// Create a copy of VoicemailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoicemailStateImplCopyWith<_$VoicemailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
