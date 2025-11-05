import 'package:freezed_annotation/freezed_annotation.dart';

import 'balance_type.dart';

part 'common.freezed.dart';

part 'common.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Numbers with _$Numbers {
  const Numbers({required this.main, this.ext, this.additional, this.sms});

  @override
  final String main;

  @override
  final String? ext;

  @override
  final List<String>? additional;

  @override
  final List<String>? sms;

  factory Numbers.fromJson(Map<String, Object?> json) => _$NumbersFromJson(json);

  Map<String, Object?> toJson() => _$NumbersToJson(this);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Balance with _$Balance {
  const Balance({this.balanceType, this.amount, this.creditLimit, this.currency});

  @override
  final BalanceType? balanceType;

  @override
  final double? amount;

  @override
  final double? creditLimit;

  @override
  final String? currency;

  factory Balance.fromJson(Map<String, Object?> json) => _$BalanceFromJson(json);

  Map<String, Object?> toJson() => _$BalanceToJson(this);
}
