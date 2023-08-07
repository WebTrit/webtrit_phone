import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_action_data.freezed.dart';

part 'user_action_data.g.dart';

@freezed
class UserActionData with _$UserActionData {
  // ignore_for_file: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserActionData({
    String? status,
    String? message,
    String? tenantId,
    String? userId,
    String? convertPbxUrl,
    String? apiToken,
    String? tokenExpires,
    String? inviteFriendsUrl,
  }) = _UserActionData;

  factory UserActionData.fromJson(Map<String, dynamic> json) => _$UserActionDataFromJson(json);
}
