// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserContact _$$_UserContactFromJson(Map<String, dynamic> json) =>
    _$_UserContact(
      sipStatus: $enumDecodeNullable(_$SipStatusEnumMap, json['sip_status']),
      numbers: Numbers.fromJson(json['numbers'] as Map<String, dynamic>),
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      aliasName: json['alias_name'] as String?,
      companyName: json['company_name'] as String?,
    );

Map<String, dynamic> _$$_UserContactToJson(_$_UserContact instance) =>
    <String, dynamic>{
      'sip_status': _$SipStatusEnumMap[instance.sipStatus],
      'numbers': instance.numbers,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'alias_name': instance.aliasName,
      'company_name': instance.companyName,
    };

const _$SipStatusEnumMap = {
  SipStatus.registered: 'registered',
  SipStatus.notregistered: 'notregistered',
};
