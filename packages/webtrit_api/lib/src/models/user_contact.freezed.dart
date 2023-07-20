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
  String? get companyName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  Numbers? get numbers => throw _privateConstructorUsedError;
  Sip? get sip => throw _privateConstructorUsedError;

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
      {String? companyName,
      String? email,
      String? firstName,
      String? lastName,
      Numbers? numbers,
      Sip? sip});

  $NumbersCopyWith<$Res>? get numbers;
  $SipCopyWith<$Res>? get sip;
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
    Object? companyName = freezed,
    Object? email = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? numbers = freezed,
    Object? sip = freezed,
  }) {
    return _then(_value.copyWith(
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
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
      numbers: freezed == numbers
          ? _value.numbers
          : numbers // ignore: cast_nullable_to_non_nullable
              as Numbers?,
      sip: freezed == sip
          ? _value.sip
          : sip // ignore: cast_nullable_to_non_nullable
              as Sip?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NumbersCopyWith<$Res>? get numbers {
    if (_value.numbers == null) {
      return null;
    }

    return $NumbersCopyWith<$Res>(_value.numbers!, (value) {
      return _then(_value.copyWith(numbers: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SipCopyWith<$Res>? get sip {
    if (_value.sip == null) {
      return null;
    }

    return $SipCopyWith<$Res>(_value.sip!, (value) {
      return _then(_value.copyWith(sip: value) as $Val);
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
      {String? companyName,
      String? email,
      String? firstName,
      String? lastName,
      Numbers? numbers,
      Sip? sip});

  @override
  $NumbersCopyWith<$Res>? get numbers;
  @override
  $SipCopyWith<$Res>? get sip;
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
    Object? companyName = freezed,
    Object? email = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? numbers = freezed,
    Object? sip = freezed,
  }) {
    return _then(_$_UserContact(
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
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
      numbers: freezed == numbers
          ? _value.numbers
          : numbers // ignore: cast_nullable_to_non_nullable
              as Numbers?,
      sip: freezed == sip
          ? _value.sip
          : sip // ignore: cast_nullable_to_non_nullable
              as Sip?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_UserContact implements _UserContact {
  const _$_UserContact(
      {this.companyName,
      this.email,
      this.firstName,
      this.lastName,
      this.numbers,
      this.sip});

  factory _$_UserContact.fromJson(Map<String, dynamic> json) =>
      _$$_UserContactFromJson(json);

  @override
  final String? companyName;
  @override
  final String? email;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final Numbers? numbers;
  @override
  final Sip? sip;

  @override
  String toString() {
    return 'UserContact(companyName: $companyName, email: $email, firstName: $firstName, lastName: $lastName, numbers: $numbers, sip: $sip)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserContact &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.numbers, numbers) || other.numbers == numbers) &&
            (identical(other.sip, sip) || other.sip == sip));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, companyName, email, firstName, lastName, numbers, sip);

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
      {final String? companyName,
      final String? email,
      final String? firstName,
      final String? lastName,
      final Numbers? numbers,
      final Sip? sip}) = _$_UserContact;

  factory _UserContact.fromJson(Map<String, dynamic> json) =
      _$_UserContact.fromJson;

  @override
  String? get companyName;
  @override
  String? get email;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  Numbers? get numbers;
  @override
  Sip? get sip;
  @override
  @JsonKey(ignore: true)
  _$$_UserContactCopyWith<_$_UserContact> get copyWith =>
      throw _privateConstructorUsedError;
}

Sip _$SipFromJson(Map<String, dynamic> json) {
  return _Sip.fromJson(json);
}

/// @nodoc
mixin _$Sip {
  String? get displayName => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SipCopyWith<Sip> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SipCopyWith<$Res> {
  factory $SipCopyWith(Sip value, $Res Function(Sip) then) =
      _$SipCopyWithImpl<$Res, Sip>;
  @useResult
  $Res call({String? displayName, String? status});
}

/// @nodoc
class _$SipCopyWithImpl<$Res, $Val extends Sip> implements $SipCopyWith<$Res> {
  _$SipCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SipCopyWith<$Res> implements $SipCopyWith<$Res> {
  factory _$$_SipCopyWith(_$_Sip value, $Res Function(_$_Sip) then) =
      __$$_SipCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? displayName, String? status});
}

/// @nodoc
class __$$_SipCopyWithImpl<$Res> extends _$SipCopyWithImpl<$Res, _$_Sip>
    implements _$$_SipCopyWith<$Res> {
  __$$_SipCopyWithImpl(_$_Sip _value, $Res Function(_$_Sip) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_Sip(
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Sip implements _Sip {
  const _$_Sip({this.displayName, this.status});

  factory _$_Sip.fromJson(Map<String, dynamic> json) => _$$_SipFromJson(json);

  @override
  final String? displayName;
  @override
  final String? status;

  @override
  String toString() {
    return 'Sip(displayName: $displayName, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Sip &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, displayName, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SipCopyWith<_$_Sip> get copyWith =>
      __$$_SipCopyWithImpl<_$_Sip>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SipToJson(
      this,
    );
  }
}

abstract class _Sip implements Sip {
  const factory _Sip({final String? displayName, final String? status}) =
      _$_Sip;

  factory _Sip.fromJson(Map<String, dynamic> json) = _$_Sip.fromJson;

  @override
  String? get displayName;
  @override
  String? get status;
  @override
  @JsonKey(ignore: true)
  _$$_SipCopyWith<_$_Sip> get copyWith => throw _privateConstructorUsedError;
}
