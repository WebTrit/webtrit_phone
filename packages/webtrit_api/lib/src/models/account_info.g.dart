// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInfoResponse _$AccountInfoResponseFromJson(Map<String, dynamic> json) {
  return AccountInfoResponse(
    data: AccountInfo.fromJson(json['data'] as Map<String, dynamic>),
  );
}

AccountInfo _$AccountInfoFromJson(Map<String, dynamic> json) {
  return AccountInfo(
    balance: (json['balance'] as num).toDouble(),
    currency: json['currency'] as String,
    extensionName: json['extension_name'] as String,
    firstname: json['firstname'] as String,
    lastname: json['lastname'] as String,
    email: json['email'] as String?,
    mobile: json['mobile'] as String?,
    companyName: json['company_name'] as String?,
    ext: json['ext'] as String,
  );
}

Map<String, dynamic> _$AccountInfoToJson(AccountInfo instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'currency': instance.currency,
      'extension_name': instance.extensionName,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'mobile': instance.mobile,
      'company_name': instance.companyName,
      'ext': instance.ext,
    };
