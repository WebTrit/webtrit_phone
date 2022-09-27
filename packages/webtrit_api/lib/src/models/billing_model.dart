import 'package:json_annotation/json_annotation.dart';

enum BillingModel {
  debit,
  @JsonValue('recharge_voucher')
  rechargeVoucher,
  credit,
  alias,
  internal,
  beneficiary,
  unknown,
}
