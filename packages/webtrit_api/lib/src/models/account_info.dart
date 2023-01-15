// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'balance_control_type.dart';
import 'billing_model.dart';

part 'account_info.freezed.dart';

part 'account_info.g.dart';

@freezed
class AccountInfo with _$AccountInfo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AccountInfo({
    required String login,
    required BillingModel billingModel,
    BalanceControlType? balanceControlType,
    required double balance,
    double? creditLimit,
    required String currency,
    required String? extensionName,
    required String? firstname,
    required String? lastname,
    String? email,
    String? mobile,
    String? companyName,
    String? ext,
  }) = _AccountInfo;

  factory AccountInfo.fromJson(Map<String, dynamic> json) => _$AccountInfoFromJson(json);
}
