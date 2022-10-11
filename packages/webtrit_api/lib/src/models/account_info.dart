import 'package:json_annotation/json_annotation.dart';

import 'balance_control_type.dart';
import 'billing_model.dart';

part 'account_info.g.dart';

@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class AccountInfoResponse {
  const AccountInfoResponse({
    required this.data,
  });

  factory AccountInfoResponse.fromJson(Map<String, dynamic> json) => _$AccountInfoResponseFromJson(json);

  final AccountInfo data;
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class AccountInfo {
  const AccountInfo({
    required this.login,
    required this.billingModel,
    this.balanceControlType,
    required this.balance,
    this.creditLimit,
    required this.currency,
    required this.extensionName,
    required this.firstname,
    required this.lastname,
    this.email,
    this.mobile,
    this.companyName,
    this.ext,
  });

  factory AccountInfo.fromJson(Map<String, dynamic> json) => _$AccountInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInfoToJson(this);

  final String login;
  final BillingModel billingModel;
  final BalanceControlType? balanceControlType;
  final double balance;
  final double? creditLimit;
  final String currency;
  final String? extensionName;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? mobile;
  final String? companyName;
  final String? ext;
}
