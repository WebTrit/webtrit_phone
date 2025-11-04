import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_voicemail.freezed.dart';

part 'user_voicemail.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class UserVoicemail with _$UserVoicemail {
  const UserVoicemail({
    required this.id,
    required this.date,
    required this.duration,
    required this.sender,
    required this.receiver,
    required this.seen,
    required this.size,
    required this.type,
    required this.attachments,
  });

  @override
  final String id;

  @override
  final String date;

  @override
  final double duration;

  @override
  final String sender;

  @override
  final String receiver;

  @override
  final bool seen;

  @override
  final int size;

  @override
  final String type;

  @override
  final List<UserVoicemailAttachment> attachments;

  factory UserVoicemail.fromJson(Map<String, dynamic> json) => _$UserVoicemailFromJson(json);

  Map<String, dynamic> toJson() => _$UserVoicemailToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class UserVoicemailAttachment with _$UserVoicemailAttachment {
  const UserVoicemailAttachment({
    required this.filename,
    required this.size,
    required this.type,
    required this.subtype,
  });

  @override
  final String filename;

  @override
  final int size;

  @override
  final String type;

  @override
  final String subtype;

  factory UserVoicemailAttachment.fromJson(Map<String, dynamic> json) => _$UserVoicemailAttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$UserVoicemailAttachmentToJson(this);
}
