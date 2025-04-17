import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_voicemail_list_response.freezed.dart';
part 'user_voicemail_list_response.g.dart';

@freezed
class UserVoicemailListResponse with _$UserVoicemailListResponse {
  const factory UserVoicemailListResponse({
    @JsonKey(name: 'has_new_messages') required bool hasNewMessages,
    required List<UserVoicemailItem> items,
  }) = _UserVoicemailListResponse;

  factory UserVoicemailListResponse.fromJson(Map<String, dynamic> json) =>
      _$UserVoicemailListResponseFromJson(json);
}

@freezed
class UserVoicemailItem with _$UserVoicemailItem {
  const factory UserVoicemailItem({
    required String id,
    required String date,
    required double duration,
    required bool seen,
    required int size,
    required String type,
  }) = _UserVoicemailItem;

  factory UserVoicemailItem.fromJson(Map<String, dynamic> json) =>
      _$UserVoicemailItemFromJson(json);
}