// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserContactImpl _$$UserContactImplFromJson(Map<String, dynamic> json) =>
    _$UserContactImpl(
      userId: json['user_id'] as String,
      sipStatus: $enumDecodeNullable(_$SipStatusEnumMap, json['sip_status']),
      numbers: Numbers.fromJson(json['numbers'] as Map<String, dynamic>),
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      aliasName: json['alias_name'] as String?,
      companyName: json['company_name'] as String?,
    );

Map<String, dynamic> _$$UserContactImplToJson(_$UserContactImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
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
