// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AccountContact _$AccountContactFromJson(Map<String, dynamic> json) {
  return _AccountContact.fromJson(json);
}

/// @nodoc
mixin _$AccountContact {
  String get number => throw _privateConstructorUsedError;
  String get extensionId => throw _privateConstructorUsedError;
  String? get extensionName => throw _privateConstructorUsedError;
  @JsonKey(name: 'firstname')
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'lastname')
  String? get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get mobile => throw _privateConstructorUsedError;
  String? get companyName => throw _privateConstructorUsedError;
  int get sipStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AccountContactCopyWith<AccountContact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountContactCopyWith<$Res> {
  factory $AccountContactCopyWith(
          AccountContact value, $Res Function(AccountContact) then) =
      _$AccountContactCopyWithImpl<$Res, AccountContact>;
  @useResult
  $Res call(
      {String number,
      String extensionId,
      String? extensionName,
      @JsonKey(name: 'firstname') String? firstName,
      @JsonKey(name: 'lastname') String? lastName,
      String? email,
      String? mobile,
      String? companyName,
      int sipStatus});
}

/// @nodoc
class _$AccountContactCopyWithImpl<$Res, $Val extends AccountContact>
    implements $AccountContactCopyWith<$Res> {
  _$AccountContactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? extensionId = null,
    Object? extensionName = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? mobile = freezed,
    Object? companyName = freezed,
    Object? sipStatus = null,
  }) {
    return _then(_value.copyWith(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      extensionId: null == extensionId
          ? _value.extensionId
          : extensionId // ignore: cast_nullable_to_non_nullable
              as String,
      extensionName: freezed == extensionName
          ? _value.extensionName
          : extensionName // ignore: cast_nullable_to_non_nullable
              as String?,
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
      mobile: freezed == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String?,
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
      sipStatus: null == sipStatus
          ? _value.sipStatus
          : sipStatus // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AccountContactCopyWith<$Res>
    implements $AccountContactCopyWith<$Res> {
  factory _$$_AccountContactCopyWith(
          _$_AccountContact value, $Res Function(_$_AccountContact) then) =
      __$$_AccountContactCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String number,
      String extensionId,
      String? extensionName,
      @JsonKey(name: 'firstname') String? firstName,
      @JsonKey(name: 'lastname') String? lastName,
      String? email,
      String? mobile,
      String? companyName,
      int sipStatus});
}

/// @nodoc
class __$$_AccountContactCopyWithImpl<$Res>
    extends _$AccountContactCopyWithImpl<$Res, _$_AccountContact>
    implements _$$_AccountContactCopyWith<$Res> {
  __$$_AccountContactCopyWithImpl(
      _$_AccountContact _value, $Res Function(_$_AccountContact) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? extensionId = null,
    Object? extensionName = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? mobile = freezed,
    Object? companyName = freezed,
    Object? sipStatus = null,
  }) {
    return _then(_$_AccountContact(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      extensionId: null == extensionId
          ? _value.extensionId
          : extensionId // ignore: cast_nullable_to_non_nullable
              as String,
      extensionName: freezed == extensionName
          ? _value.extensionName
          : extensionName // ignore: cast_nullable_to_non_nullable
              as String?,
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
      mobile: freezed == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String?,
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
      sipStatus: null == sipStatus
          ? _value.sipStatus
          : sipStatus // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_AccountContact implements _AccountContact {
  const _$_AccountContact(
      {required this.number,
      required this.extensionId,
      this.extensionName,
      @JsonKey(name: 'firstname') this.firstName,
      @JsonKey(name: 'lastname') this.lastName,
      this.email,
      this.mobile,
      this.companyName,
      required this.sipStatus});

  factory _$_AccountContact.fromJson(Map<String, dynamic> json) =>
      _$$_AccountContactFromJson(json);

  @override
  final String number;
  @override
  final String extensionId;
  @override
  final String? extensionName;
  @override
  @JsonKey(name: 'firstname')
  final String? firstName;
  @override
  @JsonKey(name: 'lastname')
  final String? lastName;
  @override
  final String? email;
  @override
  final String? mobile;
  @override
  final String? companyName;
  @override
  final int sipStatus;

  @override
  String toString() {
    return 'AccountContact(number: $number, extensionId: $extensionId, extensionName: $extensionName, firstName: $firstName, lastName: $lastName, email: $email, mobile: $mobile, companyName: $companyName, sipStatus: $sipStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AccountContact &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.extensionId, extensionId) ||
                other.extensionId == extensionId) &&
            (identical(other.extensionName, extensionName) ||
                other.extensionName == extensionName) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.mobile, mobile) || other.mobile == mobile) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.sipStatus, sipStatus) ||
                other.sipStatus == sipStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      number,
      extensionId,
      extensionName,
      firstName,
      lastName,
      email,
      mobile,
      companyName,
      sipStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AccountContactCopyWith<_$_AccountContact> get copyWith =>
      __$$_AccountContactCopyWithImpl<_$_AccountContact>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AccountContactToJson(
      this,
    );
  }
}

abstract class _AccountContact implements AccountContact {
  const factory _AccountContact(
      {required final String number,
      required final String extensionId,
      final String? extensionName,
      @JsonKey(name: 'firstname') final String? firstName,
      @JsonKey(name: 'lastname') final String? lastName,
      final String? email,
      final String? mobile,
      final String? companyName,
      required final int sipStatus}) = _$_AccountContact;

  factory _AccountContact.fromJson(Map<String, dynamic> json) =
      _$_AccountContact.fromJson;

  @override
  String get number;
  @override
  String get extensionId;
  @override
  String? get extensionName;
  @override
  @JsonKey(name: 'firstname')
  String? get firstName;
  @override
  @JsonKey(name: 'lastname')
  String? get lastName;
  @override
  String? get email;
  @override
  String? get mobile;
  @override
  String? get companyName;
  @override
  int get sipStatus;
  @override
  @JsonKey(ignore: true)
  _$$_AccountContactCopyWith<_$_AccountContact> get copyWith =>
      throw _privateConstructorUsedError;
}
