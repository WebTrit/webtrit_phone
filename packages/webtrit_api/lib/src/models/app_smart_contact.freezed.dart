// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_smart_contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppSmartContact _$AppSmartContactFromJson(Map<String, dynamic> json) {
  return _AppSmartContact.fromJson(json);
}

/// @nodoc
mixin _$AppSmartContact {
  String get identifier => throw _privateConstructorUsedError;
  List<String> get phones => throw _privateConstructorUsedError;

  /// Serializes this AppSmartContact to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppSmartContact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppSmartContactCopyWith<AppSmartContact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSmartContactCopyWith<$Res> {
  factory $AppSmartContactCopyWith(
          AppSmartContact value, $Res Function(AppSmartContact) then) =
      _$AppSmartContactCopyWithImpl<$Res, AppSmartContact>;
  @useResult
  $Res call({String identifier, List<String> phones});
}

/// @nodoc
class _$AppSmartContactCopyWithImpl<$Res, $Val extends AppSmartContact>
    implements $AppSmartContactCopyWith<$Res> {
  _$AppSmartContactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppSmartContact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = null,
    Object? phones = null,
  }) {
    return _then(_value.copyWith(
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      phones: null == phones
          ? _value.phones
          : phones // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppSmartContactImplCopyWith<$Res>
    implements $AppSmartContactCopyWith<$Res> {
  factory _$$AppSmartContactImplCopyWith(_$AppSmartContactImpl value,
          $Res Function(_$AppSmartContactImpl) then) =
      __$$AppSmartContactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String identifier, List<String> phones});
}

/// @nodoc
class __$$AppSmartContactImplCopyWithImpl<$Res>
    extends _$AppSmartContactCopyWithImpl<$Res, _$AppSmartContactImpl>
    implements _$$AppSmartContactImplCopyWith<$Res> {
  __$$AppSmartContactImplCopyWithImpl(
      _$AppSmartContactImpl _value, $Res Function(_$AppSmartContactImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppSmartContact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = null,
    Object? phones = null,
  }) {
    return _then(_$AppSmartContactImpl(
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      phones: null == phones
          ? _value._phones
          : phones // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$AppSmartContactImpl implements _AppSmartContact {
  const _$AppSmartContactImpl(
      {required this.identifier, required final List<String> phones})
      : _phones = phones;

  factory _$AppSmartContactImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppSmartContactImplFromJson(json);

  @override
  final String identifier;
  final List<String> _phones;
  @override
  List<String> get phones {
    if (_phones is EqualUnmodifiableListView) return _phones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_phones);
  }

  @override
  String toString() {
    return 'AppSmartContact(identifier: $identifier, phones: $phones)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSmartContactImpl &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            const DeepCollectionEquality().equals(other._phones, _phones));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, identifier, const DeepCollectionEquality().hash(_phones));

  /// Create a copy of AppSmartContact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSmartContactImplCopyWith<_$AppSmartContactImpl> get copyWith =>
      __$$AppSmartContactImplCopyWithImpl<_$AppSmartContactImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppSmartContactImplToJson(
      this,
    );
  }
}

abstract class _AppSmartContact implements AppSmartContact {
  const factory _AppSmartContact(
      {required final String identifier,
      required final List<String> phones}) = _$AppSmartContactImpl;

  factory _AppSmartContact.fromJson(Map<String, dynamic> json) =
      _$AppSmartContactImpl.fromJson;

  @override
  String get identifier;
  @override
  List<String> get phones;

  /// Create a copy of AppSmartContact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppSmartContactImplCopyWith<_$AppSmartContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
