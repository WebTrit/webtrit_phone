// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ContactState {
  Contact? get contact => throw _privateConstructorUsedError;
  bool get deleted => throw _privateConstructorUsedError;
  List<PresenceInfo> get presenceInfo => throw _privateConstructorUsedError;

  /// Create a copy of ContactState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactStateCopyWith<ContactState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactStateCopyWith<$Res> {
  factory $ContactStateCopyWith(
          ContactState value, $Res Function(ContactState) then) =
      _$ContactStateCopyWithImpl<$Res, ContactState>;
  @useResult
  $Res call({Contact? contact, bool deleted, List<PresenceInfo> presenceInfo});
}

/// @nodoc
class _$ContactStateCopyWithImpl<$Res, $Val extends ContactState>
    implements $ContactStateCopyWith<$Res> {
  _$ContactStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contact = freezed,
    Object? deleted = null,
    Object? presenceInfo = null,
  }) {
    return _then(_value.copyWith(
      contact: freezed == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as Contact?,
      deleted: null == deleted
          ? _value.deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as bool,
      presenceInfo: null == presenceInfo
          ? _value.presenceInfo
          : presenceInfo // ignore: cast_nullable_to_non_nullable
              as List<PresenceInfo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContactStateImplCopyWith<$Res>
    implements $ContactStateCopyWith<$Res> {
  factory _$$ContactStateImplCopyWith(
          _$ContactStateImpl value, $Res Function(_$ContactStateImpl) then) =
      __$$ContactStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Contact? contact, bool deleted, List<PresenceInfo> presenceInfo});
}

/// @nodoc
class __$$ContactStateImplCopyWithImpl<$Res>
    extends _$ContactStateCopyWithImpl<$Res, _$ContactStateImpl>
    implements _$$ContactStateImplCopyWith<$Res> {
  __$$ContactStateImplCopyWithImpl(
      _$ContactStateImpl _value, $Res Function(_$ContactStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContactState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contact = freezed,
    Object? deleted = null,
    Object? presenceInfo = null,
  }) {
    return _then(_$ContactStateImpl(
      contact: freezed == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as Contact?,
      deleted: null == deleted
          ? _value.deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as bool,
      presenceInfo: null == presenceInfo
          ? _value._presenceInfo
          : presenceInfo // ignore: cast_nullable_to_non_nullable
              as List<PresenceInfo>,
    ));
  }
}

/// @nodoc

class _$ContactStateImpl implements _ContactState {
  const _$ContactStateImpl(
      {this.contact,
      this.deleted = false,
      final List<PresenceInfo> presenceInfo = const []})
      : _presenceInfo = presenceInfo;

  @override
  final Contact? contact;
  @override
  @JsonKey()
  final bool deleted;
  final List<PresenceInfo> _presenceInfo;
  @override
  @JsonKey()
  List<PresenceInfo> get presenceInfo {
    if (_presenceInfo is EqualUnmodifiableListView) return _presenceInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_presenceInfo);
  }

  @override
  String toString() {
    return 'ContactState(contact: $contact, deleted: $deleted, presenceInfo: $presenceInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactStateImpl &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.deleted, deleted) || other.deleted == deleted) &&
            const DeepCollectionEquality()
                .equals(other._presenceInfo, _presenceInfo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contact, deleted,
      const DeepCollectionEquality().hash(_presenceInfo));

  /// Create a copy of ContactState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactStateImplCopyWith<_$ContactStateImpl> get copyWith =>
      __$$ContactStateImplCopyWithImpl<_$ContactStateImpl>(this, _$identity);
}

abstract class _ContactState implements ContactState {
  const factory _ContactState(
      {final Contact? contact,
      final bool deleted,
      final List<PresenceInfo> presenceInfo}) = _$ContactStateImpl;

  @override
  Contact? get contact;
  @override
  bool get deleted;
  @override
  List<PresenceInfo> get presenceInfo;

  /// Create a copy of ContactState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactStateImplCopyWith<_$ContactStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
