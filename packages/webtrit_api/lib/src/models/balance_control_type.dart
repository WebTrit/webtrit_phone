import 'package:json_annotation/json_annotation.dart';

@JsonEnum(
  fieldRename: FieldRename.snake,
)
enum BalanceControlType {
  undefined,
  individualCreditLimit,
  subordinate,
  unknown,
}
