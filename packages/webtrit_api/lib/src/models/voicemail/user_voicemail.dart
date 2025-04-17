import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_voicemail.freezed.dart';
part 'user_voicemail.g.dart';

@freezed
class UserVoicemail with _$UserVoicemail {
  const factory UserVoicemail({
    required String id,
    required String date,
    required double duration,
    required String sender,
    required String receiver,
    required bool seen,
    required int size,
    required String type,
    required List<UserVoicemailAttachment> attachments,
  }) = _UserVoicemail;

  factory UserVoicemail.fromJson(Map<String, dynamic> json) =>
      _$UserVoicemailFromJson(json);
}

@freezed
class UserVoicemailAttachment with _$UserVoicemailAttachment {
  const factory UserVoicemailAttachment({
    required String filename,
    required int size,
    required String type,
    required String subtype,
  }) = _UserVoicemailAttachment;

  factory UserVoicemailAttachment.fromJson(Map<String, dynamic> json) =>
      _$UserVoicemailAttachmentFromJson(json);
}