// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserContact _$UserContactFromJson(Map<String, dynamic> json) {
  return _UserContact.fromJson(json);
}

/// @nodoc
mixin _$UserContact {
  SipStatus? get sipStatus => throw _privateConstructorUsedError;
  Numbers get numbers => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get aliasName => throw _privateConstructorUsedError;
  String? get companyName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserContactCopyWith<UserContact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserContactCopyWith<$Res> {
  factory $UserContactCopyWith(
          UserContact value, $Res Function(UserContact) then) =
      _$UserContactCopyWithImpl<$Res, UserContact>;
  @useResult
  $Res call(
      {SipStatus? sipStatus,
      Numbers numbers,
      String? email,
      String? firstName,
      String? lastName,
      String? aliasName,
      String? companyName});

  $NumbersCopyWith<$Res> get numbers;
}

/// @nodoc
class _$UserContactCopyWithImpl<$Res, $Val extends UserContact>
    implements $UserContactCopyWith<$Res> {
  _$UserContactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sipStatus = freezed,
    Object? numbers = null,
    Object? email = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? aliasName = freezed,
    Object? companyName = freezed,
  }) {
    return _then(_value.copyWith(
      sipStatus: freezed == sipStatus
          ? _value.sipStatus
          : sipStatus // ignore: cast_nullable_to_non_nullable
              as SipStatus?,
      numbers: null == numbers
          ? _value.numbers
          : numbers // ignore: cast_nullable_to_non_nullable
              as Numbers,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      aliasName: freezed == aliasName
          ? _value.aliasName
          : aliasName // ignore: cast_nullable_to_non_nullable
              as String?,
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NumbersCopyWith<$Res> get numbers {
    return $NumbersCopyWith<$Res>(_value.numbers, (value) {
      return _then(_value.copyWith(numbers: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserContactImplCopyWith<$Res>
    implements $UserContactCopyWith<$Res> {
  factory _$$UserContactImplCopyWith(
          _$UserContactImpl value, $Res Function(_$UserContactImpl) then) =
      __$$UserContactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SipStatus? sipStatus,
      Numbers numbers,
      String? email,
      String? firstName,
      String? lastName,
      String? aliasName,
      String? companyName});

  @override
  $NumbersCopyWith<$Res> get numbers;
}

/// @nodoc
class __$$UserContactImplCopyWithImpl<$Res>
    extends _$UserContactCopyWithImpl<$Res, _$UserContactImpl>
    implements _$$UserContactImplCopyWith<$Res> {
  __$$UserContactImplCopyWithImpl(
      _$UserContactImpl _value, $Res Function(_$UserContactImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sipStatus = freezed,
    Object? numbers = null,
    Object? email = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? aliasName = freezed,
    Object? companyName = freezed,
  }) {
    return _then(_$UserContactImpl(
      sipStatus: freezed == sipStatus
          ? _value.sipStatus
          : sipStatus // ignore: cast_nullable_to_non_nullable
              as SipStatus?,
      numbers: null == numbers
          ? _value.numbers
          : numbers // ignore: cast_nullable_to_non_nullable
              as Numbers,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      aliasName: freezed == aliasName
          ? _value.aliasName
          : aliasName // ignore: cast_nullable_to_non_nullable
              as String?,
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$UserContactImpl implements _UserContact {
  const _$UserContactImpl(
      {this.sipStatus,
      required this.numbers,
      this.email,
      this.firstName,
      this.lastName,
      this.aliasName,
      this.companyName});

  factory _$UserContactImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserContactImplFromJson(json);

  @override
  final SipStatus? sipStatus;
  @override
  final Numbers numbers;
  @override
  final String? email;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? aliasName;
  @override
  final String? companyName;

  @override
  String toString() {
    return 'UserContact(sipStatus: $sipStatus, numbers: $numbers, email: $email, firstName: $firstName, lastName: $lastName, aliasName: $aliasName, companyName: $companyName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserContactImpl &&
            (identical(other.sipStatus, sipStatus) ||
                other.sipStatus == sipStatus) &&
            (identical(other.numbers, numbers) || other.numbers == numbers) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.aliasName, aliasName) ||
                other.aliasName == aliasName) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, sipStatus, numbers, email,
      firstName, lastName, aliasName, companyName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserContactImplCopyWith<_$UserContactImpl> get copyWith =>
      __$$UserContactImplCopyWithImpl<_$UserContactImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserContactImplToJson(
      this,
    );
  }
}

abstract class _UserContact implements UserContact {
  const factory _UserContact(
      {final SipStatus? sipStatus,
      required final Numbers numbers,
      final String? email,
      final String? firstName,
      final String? lastName,
      final String? aliasName,
      final String? companyName}) = _$UserContactImpl;

  factory _UserContact.fromJson(Map<String, dynamic> json) =
      _$UserContactImpl.fromJson;

  @override
  SipStatus? get sipStatus;
  @override
  Numbers get numbers;
  @override
  String? get email;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get aliasName;
  @override
  String? get companyName;
  @override
  @JsonKey(ignore: true)
  _$$UserContactImplCopyWith<_$UserContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
