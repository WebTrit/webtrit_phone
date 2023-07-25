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
  SipStatus? get sip => throw _privateConstructorUsedError;
  Numbers get numbers => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
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
      {SipStatus? sip,
      Numbers numbers,
      String? firstName,
      String? lastName,
      String? email,
      String? companyName});

  $SipStatusCopyWith<$Res>? get sip;
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
    Object? sip = freezed,
    Object? numbers = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? companyName = freezed,
  }) {
    return _then(_value.copyWith(
      sip: freezed == sip
          ? _value.sip
          : sip // ignore: cast_nullable_to_non_nullable
              as SipStatus?,
      numbers: null == numbers
          ? _value.numbers
          : numbers // ignore: cast_nullable_to_non_nullable
              as Numbers,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SipStatusCopyWith<$Res>? get sip {
    if (_value.sip == null) {
      return null;
    }

    return $SipStatusCopyWith<$Res>(_value.sip!, (value) {
      return _then(_value.copyWith(sip: value) as $Val);
    });
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
abstract class _$$_UserContactCopyWith<$Res>
    implements $UserContactCopyWith<$Res> {
  factory _$$_UserContactCopyWith(
          _$_UserContact value, $Res Function(_$_UserContact) then) =
      __$$_UserContactCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SipStatus? sip,
      Numbers numbers,
      String? firstName,
      String? lastName,
      String? email,
      String? companyName});

  @override
  $SipStatusCopyWith<$Res>? get sip;
  @override
  $NumbersCopyWith<$Res> get numbers;
}

/// @nodoc
class __$$_UserContactCopyWithImpl<$Res>
    extends _$UserContactCopyWithImpl<$Res, _$_UserContact>
    implements _$$_UserContactCopyWith<$Res> {
  __$$_UserContactCopyWithImpl(
      _$_UserContact _value, $Res Function(_$_UserContact) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sip = freezed,
    Object? numbers = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? companyName = freezed,
  }) {
    return _then(_$_UserContact(
      sip: freezed == sip
          ? _value.sip
          : sip // ignore: cast_nullable_to_non_nullable
              as SipStatus?,
      numbers: null == numbers
          ? _value.numbers
          : numbers // ignore: cast_nullable_to_non_nullable
              as Numbers,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
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
class _$_UserContact implements _UserContact {
  const _$_UserContact(
      {this.sip,
      required this.numbers,
      this.firstName,
      this.lastName,
      this.email,
      this.companyName});

  factory _$_UserContact.fromJson(Map<String, dynamic> json) =>
      _$$_UserContactFromJson(json);

  @override
  final SipStatus? sip;
  @override
  final Numbers numbers;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? email;
  @override
  final String? companyName;

  @override
  String toString() {
    return 'UserContact(sip: $sip, numbers: $numbers, firstName: $firstName, lastName: $lastName, email: $email, companyName: $companyName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserContact &&
            (identical(other.sip, sip) || other.sip == sip) &&
            (identical(other.numbers, numbers) || other.numbers == numbers) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, sip, numbers, firstName, lastName, email, companyName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserContactCopyWith<_$_UserContact> get copyWith =>
      __$$_UserContactCopyWithImpl<_$_UserContact>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserContactToJson(
      this,
    );
  }
}

abstract class _UserContact implements UserContact {
  const factory _UserContact(
      {final SipStatus? sip,
      required final Numbers numbers,
      final String? firstName,
      final String? lastName,
      final String? email,
      final String? companyName}) = _$_UserContact;

  factory _UserContact.fromJson(Map<String, dynamic> json) =
      _$_UserContact.fromJson;

  @override
  SipStatus? get sip;
  @override
  Numbers get numbers;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get email;
  @override
  String? get companyName;
  @override
  @JsonKey(ignore: true)
  _$$_UserContactCopyWith<_$_UserContact> get copyWith =>
      throw _privateConstructorUsedError;
}
