import 'package:json_annotation/json_annotation.dart';

enum BalanceControlType {
  undefined,
  @JsonValue('individual_credit_limit')
  individualCreditLimit,
  subordinate,
  unknown,
}
