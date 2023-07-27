// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SipStatus _$$_SipStatusFromJson(Map<String, dynamic> json) => _$_SipStatus(
      displayName: json['display_name'] as String?,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$_SipStatusToJson(_$_SipStatus instance) =>
    <String, dynamic>{
      'display_name': instance.displayName,
      'status': instance.status,
    };

_$_Numbers _$$_NumbersFromJson(Map<String, dynamic> json) => _$_Numbers(
      main: json['main'] as String,
      ext: json['ext'] as String?,
      additional: (json['additional'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_NumbersToJson(_$_Numbers instance) =>
    <String, dynamic>{
      'main': instance.main,
      'ext': instance.ext,
      'additional': instance.additional,
    };

_$_Balance _$$_BalanceFromJson(Map<String, dynamic> json) => _$_Balance(
      balanceType:
          $enumDecodeNullable(_$BalanceTypeEnumMap, json['balance_type']),
      amount: (json['amount'] as num?)?.toDouble(),
      creditLimit: json['credit_limit'] as int?,
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$$_BalanceToJson(_$_Balance instance) =>
    <String, dynamic>{
      'balance_type': _$BalanceTypeEnumMap[instance.balanceType],
      'amount': instance.amount,
      'credit_limit': instance.creditLimit,
      'currency': instance.currency,
    };

const _$BalanceTypeEnumMap = {
  BalanceType.postpaid: 'postpaid',
  BalanceType.prepaid: 'prepaid',
  BalanceType.inapplicable: 'inapplicable',
  BalanceType.unknown: 'unknown',
};

_$_SipInfo _$$_SipInfoFromJson(Map<String, dynamic> json) => _$_SipInfo(
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

Map<String, dynamic> _$$_SipInfoToJson(_$_SipInfo instance) =>
    <String, dynamic>{
      'display_name': instance.displayName,
      'login': instance.login,
      'password': instance.password,
      'registration_server': instance.registrationServer,
      'sip_server': instance.sipServer,
    };

_$_SipServer _$$_SipServerFromJson(Map<String, dynamic> json) => _$_SipServer(
      forceTcp: json['force_tcp'] as bool?,
      host: json['host'] as String,
      port: json['port'] as int?,
    );

Map<String, dynamic> _$$_SipServerToJson(_$_SipServer instance) =>
    <String, dynamic>{
      'force_tcp': instance.forceTcp,
      'host': instance.host,
      'port': instance.port,
    };
