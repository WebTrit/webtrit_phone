import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:webtrit_phone/models/mediafile_metadata.dart';

class ChatOutboxMessageEntry extends Equatable {
  final String idKey;
  final String content;
  final List<OutgoingAttachment> attachments;
  final int? chatId;
  final String? participantId;
  final int? replyToId;
  final int? forwardFromId;
  final String? authorId;
  final int sendAttempts;
  final String? failureCode;

  const ChatOutboxMessageEntry({
    required this.idKey,
    required this.content,
    this.attachments = const [],
    this.chatId,
    this.participantId,
    this.replyToId,
    this.forwardFromId,
    this.authorId,
    this.sendAttempts = 0,
    this.failureCode,
  });

  @override
  List<Object?> get props => [
        idKey,
        content,
        attachments,
        chatId,
        participantId,
        replyToId,
        forwardFromId,
        authorId,
        sendAttempts,
        failureCode,
      ];

  @override
  String toString() {
    return 'ChatOutboxMessageEntry{idKey: $idKey, content: $content, attachments: $attachments, chatId: $chatId, participantId: $participantId, replyToId: $replyToId, forwardFromId: $forwardFromId, authorId: $authorId, sendAttempts: $sendAttempts, failureCode: $failureCode}';
  }

  ChatOutboxMessageEntry copyWith({
    String? idKey,
    String? content,
    List<OutgoingAttachment>? attachments,
    int? chatId,
    String? participantId,
    int? replyToId,
    int? forwardFromId,
    String? authorId,
    int? sendAttempts,
    String? failureCode,
  }) {
    return ChatOutboxMessageEntry(
      idKey: idKey ?? this.idKey,
      content: content ?? this.content,
      attachments: attachments ?? this.attachments,
      chatId: chatId ?? this.chatId,
      participantId: participantId ?? this.participantId,
      replyToId: replyToId ?? this.replyToId,
      forwardFromId: forwardFromId ?? this.forwardFromId,
      authorId: authorId ?? this.authorId,
      sendAttempts: sendAttempts ?? this.sendAttempts,
      failureCode: failureCode ?? this.failureCode,
    );
  }

  ChatOutboxMessageEntry incAttempt() {
    return ChatOutboxMessageEntry(
      idKey: idKey,
      content: content,
      attachments: attachments,
      chatId: chatId,
      participantId: participantId,
      replyToId: replyToId,
      forwardFromId: forwardFromId,
      authorId: authorId,
      sendAttempts: sendAttempts + 1,
      failureCode: failureCode,
    );
  }

  ChatOutboxMessageEntry setFailureCode(String code) {
    return ChatOutboxMessageEntry(
      idKey: idKey,
      content: content,
      attachments: attachments,
      chatId: chatId,
      participantId: participantId,
      replyToId: replyToId,
      forwardFromId: forwardFromId,
      authorId: authorId,
      sendAttempts: sendAttempts,
      failureCode: code,
    );
  }

  ChatOutboxMessageEntry resetFailure() {
    return ChatOutboxMessageEntry(
      idKey: idKey,
      content: content,
      attachments: attachments,
      chatId: chatId,
      participantId: participantId,
      replyToId: replyToId,
      forwardFromId: forwardFromId,
      authorId: authorId,
      sendAttempts: 0,
      failureCode: null,
    );
  }
}

class OutgoingAttachment extends Equatable {
  const OutgoingAttachment({
    required this.pickedPath,
    this.encodedPath,
    this.metadata,
    this.uploadId,
  });

  final String pickedPath;
  final String? encodedPath;
  final MediaFileMetadata? metadata;
  final String? uploadId;

  @override
  List<Object?> get props => [pickedPath, encodedPath, metadata, uploadId];

  @override
  String toString() {
    return 'OutgoingAttachment{pickedPath: $pickedPath, encodedPath: $encodedPath, metadata: $metadata, uploadId: $uploadId}';
  }

  double get progress {
    if (uploadId != null) return 1;
    if (metadata != null) return 0.75;
    if (encodedPath != null) return 0.5;
    return 0.2;
  }

  OutgoingAttachment copyWith({
    String? pickedPath,
    String? encodedPath,
    MediaFileMetadata? metadata,
    String? uploadId,
  }) {
    return OutgoingAttachment(
      pickedPath: pickedPath ?? this.pickedPath,
      encodedPath: encodedPath ?? this.encodedPath,
      metadata: metadata ?? this.metadata,
      uploadId: uploadId ?? this.uploadId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pickedPath': pickedPath,
      'encodedPath': encodedPath,
      'metadata': metadata?.toMap(),
      'uploadId': uploadId,
    };
  }

  factory OutgoingAttachment.fromMap(Map<String, dynamic> map) {
    return OutgoingAttachment(
      pickedPath: map['pickedPath'] as String,
      encodedPath: map['encodedPath'] != null ? map['encodedPath'] as String : null,
      metadata: map['metadata'] != null ? MediaFileMetadata.fromMap(map['metadata'] as Map<String, dynamic>) : null,
      uploadId: map['uploadId'] != null ? map['uploadId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OutgoingAttachment.fromJson(String source) =>
      OutgoingAttachment.fromMap(json.decode(source) as Map<String, dynamic>);
}
