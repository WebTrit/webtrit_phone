import 'package:freezed_annotation/freezed_annotation.dart';

import 'common.dart';

part 'user_info.freezed.dart';

part 'user_info.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class UserInfo with _$UserInfo {
  const UserInfo({
    this.status,
    this.balance,
    required this.numbers,
    this.email,
    this.firstName,
    this.lastName,
    this.aliasName,
    this.companyName,
    this.timeZone,
  });

  @override
  final UserInfoStatus? status;

  @override
  final Balance? balance;

  @override
  final Numbers numbers;

  @override
  final String? email;

  @override
  final String? firstName;

  @override
  final String? lastName;

  @override
  final String? aliasName;

  @override
  final String? companyName;

  @override
  final String? timeZone;

  factory UserInfo.fromJson(Map<String, Object?> json) => _$UserInfoFromJson(json);

  Map<String, Object?> toJson() => _$UserInfoToJson(this);
}

@JsonEnum(fieldRename: FieldRename.snake)
enum UserInfoStatus { active, limited, blocked }
