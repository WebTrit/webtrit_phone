// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInfoResponse _$AccountInfoResponseFromJson(Map<String, dynamic> json) =>
    AccountInfoResponse(
      data: AccountInfo.fromJson(json['data'] as Map<String, dynamic>),
    );

AccountInfo _$AccountInfoFromJson(Map<String, dynamic> json) => AccountInfo(
      login: json['login'] as String,
      billingModel: $enumDecode(_$BillingModelEnumMap, json['billing_model']),
      balanceControlType: $enumDecodeNullable(
          _$BalanceControlTypeEnumMap, json['balance_control_type']),
      balance: (json['balance'] as num).toDouble(),
      creditLimit: (json['credit_limit'] as num?)?.toDouble(),
      currency: json['currency'] as String,
      extensionName: json['extension_name'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      companyName: json['company_name'] as String?,
      ext: json['ext'] as String,
    );

Map<String, dynamic> _$AccountInfoToJson(AccountInfo instance) =>
    <String, dynamic>{
      'login': instance.login,
      'billing_model': _$BillingModelEnumMap[instance.billingModel]!,
      'balance_control_type':
          _$BalanceControlTypeEnumMap[instance.balanceControlType],
      'balance': instance.balance,
      'credit_limit': instance.creditLimit,
      'currency': instance.currency,
      'extension_name': instance.extensionName,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'mobile': instance.mobile,
      'company_name': instance.companyName,
      'ext': instance.ext,
    };

const _$BillingModelEnumMap = {
  BillingModel.debit: 'debit',
  BillingModel.rechargeVoucher: 'recharge_voucher',
  BillingModel.credit: 'credit',
  BillingModel.alias: 'alias',
  BillingModel.internal: 'internal',
  BillingModel.beneficiary: 'beneficiary',
  BillingModel.unknown: 'unknown',
};

const _$BalanceControlTypeEnumMap = {
  BalanceControlType.undefined: 'undefined',
  BalanceControlType.individualCreditLimit: 'individual_credit_limit',
  BalanceControlType.subordinate: 'subordinate',
  BalanceControlType.unknown: 'unknown',
};
