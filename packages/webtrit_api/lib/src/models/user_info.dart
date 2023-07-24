import 'package:freezed_annotation/freezed_annotation.dart';

import 'balance_type.dart';
import 'contact_numbers.dart';

part 'user_info.freezed.dart';

part 'user_info.g.dart';

@freezed
class UserInfo with _$UserInfo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserInfo({
    Balance? balance,
    String? companyName,
    String? email,
    String? firstName,
    String? lastName,
    ContactNumbers? numbers,
    SipData? sip,
    String? status,
    String? timeZone,
  }) = _UserInfo;

  factory UserInfo.fromJson(Map<String, Object?> json) => _$UserInfoFromJson(json);
}

@freezed
class SipData with _$SipData {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SipData({
    String? displayName,
    String? login,
    String? password,
    RegistrationServer? registrationServer,
    SipServer? sipServer,
  }) = _SipData;

  factory SipData.fromJson(Map<String, Object?> json) => _$SipDataFromJson(json);
}

@freezed
class SipServer with _$SipServer {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SipServer({
    bool? forceTcp,
    String? host,
    int? port,
  }) = _SipServer;

  factory SipServer.fromJson(Map<String, Object?> json) => _$SipServerFromJson(json);
}

@freezed
class RegistrationServer with _$RegistrationServer {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory RegistrationServer({
    bool? forceTcp,
    String? host,
    int? port,
  }) = _RegistrationServer;

  factory RegistrationServer.fromJson(Map<String, Object?> json) => _$RegistrationServerFromJson(json);
}

@freezed
class Balance with _$Balance {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Balance({
    double? amount,
    BalanceType? balanceType,
    int? creditLimit,
    String? currency,
  }) = _Balance;

  factory Balance.fromJson(Map<String, Object?> json) => _$BalanceFromJson(json);
}
