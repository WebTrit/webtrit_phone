// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserInfo _$$_UserInfoFromJson(Map<String, dynamic> json) => _$_UserInfo(
      status: $enumDecodeNullable(_$UserInfoStatusEnumMap, json['status']),
      sip: SipInfo.fromJson(json['sip'] as Map<String, dynamic>),
      balance: json['balance'] == null
          ? null
          : Balance.fromJson(json['balance'] as Map<String, dynamic>),
      numbers: Numbers.fromJson(json['numbers'] as Map<String, dynamic>),
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      companyName: json['company_name'] as String?,
      timeZone: json['time_zone'] as String?,
    );

Map<String, dynamic> _$$_UserInfoToJson(_$_UserInfo instance) =>
    <String, dynamic>{
      'status': _$UserInfoStatusEnumMap[instance.status],
      'sip': instance.sip,
      'balance': instance.balance,
      'numbers': instance.numbers,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'company_name': instance.companyName,
      'time_zone': instance.timeZone,
    };

const _$UserInfoStatusEnumMap = {
  UserInfoStatus.active: 'active',
  UserInfoStatus.limited: 'limited',
  UserInfoStatus.blocked: 'blocked',
};
