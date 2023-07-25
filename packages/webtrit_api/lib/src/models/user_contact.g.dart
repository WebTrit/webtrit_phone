// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserContact _$$_UserContactFromJson(Map<String, dynamic> json) =>
    _$_UserContact(
      sip: json['sip'] == null
          ? null
          : SipStatus.fromJson(json['sip'] as Map<String, dynamic>),
      numbers: Numbers.fromJson(json['numbers'] as Map<String, dynamic>),
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      companyName: json['company_name'] as String?,
    );

Map<String, dynamic> _$$_UserContactToJson(_$_UserContact instance) =>
    <String, dynamic>{
      'sip': instance.sip,
      'numbers': instance.numbers,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'company_name': instance.companyName,
    };
