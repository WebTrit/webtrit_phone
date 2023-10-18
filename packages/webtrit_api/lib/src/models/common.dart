import 'package:freezed_annotation/freezed_annotation.dart';

import 'balance_type.dart';

part 'common.freezed.dart';

part 'common.g.dart';

@freezed
class Numbers with _$Numbers {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Numbers({
    required String main,
    String? ext,
    List<String>? additional,
  }) = _Numbers;

  factory Numbers.fromJson(Map<String, Object?> json) => _$NumbersFromJson(json);
}

@freezed
class Balance with _$Balance {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Balance({
    BalanceType? balanceType,
    double? amount,
    double? creditLimit,
    String? currency,
  }) = _Balance;

  factory Balance.fromJson(Map<String, Object?> json) => _$BalanceFromJson(json);
}
