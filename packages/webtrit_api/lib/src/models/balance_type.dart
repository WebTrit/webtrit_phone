import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum BalanceType { unknown, inapplicable, prepaid, postpaid }
