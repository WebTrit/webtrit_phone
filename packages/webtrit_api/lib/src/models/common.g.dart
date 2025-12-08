// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Numbers _$NumbersFromJson(Map<String, dynamic> json) => Numbers(
  main: json['main'] as String,
  ext: json['ext'] as String?,
  additional: (json['additional'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  sms: (json['sms'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$NumbersToJson(Numbers instance) => <String, dynamic>{
  'main': instance.main,
  'ext': instance.ext,
  'additional': instance.additional,
  'sms': instance.sms,
};

Balance _$BalanceFromJson(Map<String, dynamic> json) => Balance(
  balanceType: $enumDecodeNullable(_$BalanceTypeEnumMap, json['balance_type']),
  amount: (json['amount'] as num?)?.toDouble(),
  creditLimit: (json['credit_limit'] as num?)?.toDouble(),
  currency: json['currency'] as String?,
);

Map<String, dynamic> _$BalanceToJson(Balance instance) => <String, dynamic>{
  'balance_type': _$BalanceTypeEnumMap[instance.balanceType],
  'amount': instance.amount,
  'credit_limit': instance.creditLimit,
  'currency': instance.currency,
};

const _$BalanceTypeEnumMap = {
  BalanceType.unknown: 'unknown',
  BalanceType.inapplicable: 'inapplicable',
  BalanceType.prepaid: 'prepaid',
  BalanceType.postpaid: 'postpaid',
};
