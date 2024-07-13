import 'package:freezed_annotation/freezed_annotation.dart';

part 'demo_data.freezed.dart';

part 'demo_data.g.dart';

@freezed
class DemoData with _$DemoData {
  // ignore_for_file: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DemoData({
    String? status,
    String? message,
    String? tenantId,
    String? userId,
    String? convertPbxUrl,
    String? apiToken,
    String? tokenExpires,
    String? inviteFriendsUrl,
  }) = _UserActionData;

  factory DemoData.fromJson(Map<String, dynamic> json) => _$DemoDataFromJson(json);
}
