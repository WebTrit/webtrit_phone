// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_voicemail_list_response.freezed.dart';

part 'user_voicemail_list_response.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class UserVoicemailListResponse with _$UserVoicemailListResponse {
  const UserVoicemailListResponse({
    @JsonKey(name: 'has_new_messages') required this.hasNewMessages,
    required this.items,
  });

  @override
  @JsonKey(name: 'has_new_messages')
  final bool hasNewMessages;

  @override
  final List<UserVoicemailItem> items;

  factory UserVoicemailListResponse.fromJson(Map<String, dynamic> json) =>
      _$UserVoicemailListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserVoicemailListResponseToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class UserVoicemailItem with _$UserVoicemailItem {
  const UserVoicemailItem({
    required this.id,
    required this.date,
    required this.duration,
    required this.seen,
    required this.size,
    required this.type,
  });

  @override
  final String id;

  @override
  final String date;

  @override
  final double duration;

  @override
  final bool seen;

  @override
  final int size;

  @override
  final String type;

  factory UserVoicemailItem.fromJson(Map<String, dynamic> json) =>
      _$UserVoicemailItemFromJson(json);

  Map<String, dynamic> toJson() => _$UserVoicemailItemToJson(this);
}
