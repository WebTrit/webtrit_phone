// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserInfo _$$_UserInfoFromJson(Map<String, dynamic> json) => _$_UserInfo(
      balance: json['balance'] == null
          ? null
          : Balance.fromJson(json['balance'] as Map<String, dynamic>),
      companyName: json['company_name'] as String?,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      numbers: json['numbers'] == null
          ? null
          : Numbers.fromJson(json['numbers'] as Map<String, dynamic>),
      sip: json['sip'] == null
          ? null
          : UserSipInfo.fromJson(json['sip'] as Map<String, dynamic>),
      status: json['status'] as String?,
      timeZone: json['time_zone'] as String?,
    );

Map<String, dynamic> _$$_UserInfoToJson(_$_UserInfo instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'company_name': instance.companyName,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'numbers': instance.numbers,
      'sip': instance.sip,
      'status': instance.status,
      'time_zone': instance.timeZone,
    };

_$_UserSipInfo _$$_UserSipInfoFromJson(Map<String, dynamic> json) =>
    _$_UserSipInfo(
      displayName: json['display_name'] as String?,
      login: json['login'] as String?,
      password: json['password'] as String?,
      registrationServer: json['registration_server'] == null
          ? null
          : SipServer.fromJson(
              json['registration_server'] as Map<String, dynamic>),
      sipServer: json['sip_server'] == null
          ? null
          : SipServer.fromJson(json['sip_server'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserSipInfoToJson(_$_UserSipInfo instance) =>
    <String, dynamic>{
      'display_name': instance.displayName,
      'login': instance.login,
      'password': instance.password,
      'registration_server': instance.registrationServer,
      'sip_server': instance.sipServer,
    };

_$_SipServer _$$_SipServerFromJson(Map<String, dynamic> json) => _$_SipServer(
      forceTcp: json['force_tcp'] as bool?,
      host: json['host'] as String?,
      port: json['port'] as int?,
    );

Map<String, dynamic> _$$_SipServerToJson(_$_SipServer instance) =>
    <String, dynamic>{
      'force_tcp': instance.forceTcp,
      'host': instance.host,
      'port': instance.port,
    };

_$_Balance _$$_BalanceFromJson(Map<String, dynamic> json) => _$_Balance(
      amount: (json['amount'] as num?)?.toDouble(),
      balanceType:
          $enumDecodeNullable(_$BalanceTypeEnumMap, json['balance_type']),
      creditLimit: json['credit_limit'] as int?,
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$$_BalanceToJson(_$_Balance instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'balance_type': _$BalanceTypeEnumMap[instance.balanceType],
      'credit_limit': instance.creditLimit,
      'currency': instance.currency,
    };

const _$BalanceTypeEnumMap = {
  BalanceType.postpaid: 'postpaid',
  BalanceType.prepaid: 'prepaid',
  BalanceType.inapplicable: 'inapplicable',
  BalanceType.unknown: 'unknown',
};
