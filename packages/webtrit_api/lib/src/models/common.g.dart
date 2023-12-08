// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NumbersImpl _$$NumbersImplFromJson(Map<String, dynamic> json) =>
    _$NumbersImpl(
      main: json['main'] as String,
      ext: json['ext'] as String?,
      additional: (json['additional'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$NumbersImplToJson(_$NumbersImpl instance) =>
    <String, dynamic>{
      'main': instance.main,
      'ext': instance.ext,
      'additional': instance.additional,
    };

_$BalanceImpl _$$BalanceImplFromJson(Map<String, dynamic> json) =>
    _$BalanceImpl(
      balanceType:
          $enumDecodeNullable(_$BalanceTypeEnumMap, json['balance_type']),
      amount: (json['amount'] as num?)?.toDouble(),
      creditLimit: (json['credit_limit'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$$BalanceImplToJson(_$BalanceImpl instance) =>
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
