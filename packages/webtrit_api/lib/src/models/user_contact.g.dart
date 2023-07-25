// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserContact _$$_UserContactFromJson(Map<String, dynamic> json) =>
    _$_UserContact(
      companyName: json['company_name'] as String?,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      numbers: json['numbers'] == null
          ? null
          : Numbers.fromJson(json['numbers'] as Map<String, dynamic>),
      sip: json['sip'] == null
          ? null
          : UserContactSip.fromJson(json['sip'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserContactToJson(_$_UserContact instance) =>
    <String, dynamic>{
      'company_name': instance.companyName,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'numbers': instance.numbers,
      'sip': instance.sip,
    };

_$_UserContactSip _$$_UserContactSipFromJson(Map<String, dynamic> json) =>
    _$_UserContactSip(
      displayName: json['display_name'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$_UserContactSipToJson(_$_UserContactSip instance) =>
    <String, dynamic>{
      'display_name': instance.displayName,
      'status': instance.status,
    };
