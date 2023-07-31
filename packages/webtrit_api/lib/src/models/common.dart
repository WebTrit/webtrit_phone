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
    int? creditLimit,
    String? currency,
  }) = _Balance;

  factory Balance.fromJson(Map<String, Object?> json) => _$BalanceFromJson(json);
}

@freezed
class SipInfo with _$SipInfo {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SipInfo({
    required String login,
    required String password,
    required SipServer sipServer,
    SipServer? registrationServer,
    String? displayName,
  }) = _SipInfo;

  factory SipInfo.fromJson(Map<String, Object?> json) => _$SipInfoFromJson(json);
}

@freezed
class SipServer with _$SipServer {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SipServer({
    bool? forceTcp,
    required String host,
    int? port,
  }) = _SipServer;

  factory SipServer.fromJson(Map<String, Object?> json) => _$SipServerFromJson(json);
}
