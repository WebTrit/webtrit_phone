// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      status: $enumDecodeNullable(_$UserInfoStatusEnumMap, json['status']),
      balance: json['balance'] == null
          ? null
          : Balance.fromJson(json['balance'] as Map<String, dynamic>),
      numbers: Numbers.fromJson(json['numbers'] as Map<String, dynamic>),
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      aliasName: json['alias_name'] as String?,
      companyName: json['company_name'] as String?,
      timeZone: json['time_zone'] as String?,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'status': _$UserInfoStatusEnumMap[instance.status],
      'balance': instance.balance?.toJson(),
      'numbers': instance.numbers.toJson(),
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'alias_name': instance.aliasName,
      'company_name': instance.companyName,
      'time_zone': instance.timeZone,
    };

const _$UserInfoStatusEnumMap = {
  UserInfoStatus.active: 'active',
  UserInfoStatus.limited: 'limited',
  UserInfoStatus.blocked: 'blocked',
};
