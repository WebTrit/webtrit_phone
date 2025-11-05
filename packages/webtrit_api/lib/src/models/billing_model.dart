import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum BillingModel { debit, rechargeVoucher, credit, alias, internal, beneficiary, unknown }
