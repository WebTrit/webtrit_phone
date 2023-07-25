import 'package:freezed_annotation/freezed_annotation.dart';

import 'common.dart';

part 'user_info.freezed.dart';

part 'user_info.g.dart';

@freezed
class UserInfo with _$UserInfo {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserInfo({
    UserInfoStatus? status,
    required SipInfo sip,
    Balance? balance,
    required Numbers numbers,
    String? firstName,
    String? lastName,
    String? email,
    String? companyName,
    String? timeZone,
  }) = _UserInfo;

  factory UserInfo.fromJson(Map<String, Object?> json) => _$UserInfoFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.snake)
enum UserInfoStatus {
  active,
  limited,
  blocked,
}
