// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
  BalanceType.unknown: 'unknown',
  BalanceType.inapplicable: 'inapplicable',
  BalanceType.prepaid: 'prepaid',
  BalanceType.postpaid: 'postpaid',
};
