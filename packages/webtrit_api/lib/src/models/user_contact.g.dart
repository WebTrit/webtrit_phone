// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserContact _$UserContactFromJson(Map<String, dynamic> json) => UserContact(
  userId: json['user_id'] as String?,
  sipStatus: $enumDecodeNullable(_$SipStatusEnumMap, json['sip_status']),
  numbers: Numbers.fromJson(json['numbers'] as Map<String, dynamic>),
  email: json['email'] as String?,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  aliasName: json['alias_name'] as String?,
  companyName: json['company_name'] as String?,
  isCurrentUser: json['is_current_user'] as bool?,
  isRegisteredUser: json['is_registered_user'] as bool?,
);

Map<String, dynamic> _$UserContactToJson(UserContact instance) => <String, dynamic>{
  'user_id': instance.userId,
  'sip_status': _$SipStatusEnumMap[instance.sipStatus],
  'numbers': instance.numbers.toJson(),
  'email': instance.email,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'alias_name': instance.aliasName,
  'company_name': instance.companyName,
  'is_current_user': instance.isCurrentUser,
  'is_registered_user': instance.isRegisteredUser,
};

const _$SipStatusEnumMap = {SipStatus.registered: 'registered', SipStatus.notregistered: 'notregistered'};
