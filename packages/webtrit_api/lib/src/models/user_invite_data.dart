import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_type.dart';

part 'user_invite_data.freezed.dart';

part 'user_invite_data.g.dart';

@freezed
class UserInviteData with _$UserInviteData {
  // ignore_for_file: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserInviteData({
    required String inviteFriendsUrl,
  }) = _UserInviteData;

  factory UserInviteData.fromJson(Map<String, dynamic> json) => _$UserInviteDataFromJson(json);
}
