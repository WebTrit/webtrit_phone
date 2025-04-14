import 'package:equatable/equatable.dart';
import 'package:webtrit_phone/models/messaging/messaging.dart';

class SmsOutboxMessageEntry extends Equatable {
  final String idKey;
  final String fromPhoneNumber;
  final String toPhoneNumber;
  final String content;
  final List<OutboxAttachment> attachments;

  /// recipientId should be removed as soon as possible when backend will be ready
  /// to avoid unsecurity bullshit from the backend side
  final String? recepientId;
  final int? conversationId;
  final int sendAttempts;
  final String? failureCode;

  const SmsOutboxMessageEntry({
    required this.idKey,
    required this.fromPhoneNumber,
    required this.toPhoneNumber,
    required this.content,
    this.attachments = const [],
    this.recepientId,
    this.conversationId,
    this.sendAttempts = 0,
    this.failureCode,
  });

  @override
  List<Object?> get props => [
        idKey,
        fromPhoneNumber,
        toPhoneNumber,
        content,
        attachments,
        recepientId,
        conversationId,
        sendAttempts,
        failureCode,
      ];

  @override
  String toString() {
    return 'SmsOutboxMessageEntry{idKey: $idKey, fromPhoneNumber: $fromPhoneNumber, toPhoneNumber: $toPhoneNumber, content: $content, attachments: $attachments, recepientId: $recepientId, conversationId: $conversationId, sendAttempts: $sendAttempts, failureCode: $failureCode}';
  }

  SmsOutboxMessageEntry copyWith({
    String? idKey,
    String? fromPhoneNumber,
    String? toPhoneNumber,
    String? content,
    List<OutboxAttachment>? attachments,
    String? recepientId,
    int? conversationId,
    int? sendAttempts,
    String? failureCode,
  }) {
    return SmsOutboxMessageEntry(
      idKey: idKey ?? this.idKey,
      fromPhoneNumber: fromPhoneNumber ?? this.fromPhoneNumber,
      toPhoneNumber: toPhoneNumber ?? this.toPhoneNumber,
      content: content ?? this.content,
      attachments: attachments ?? this.attachments,
      recepientId: recepientId ?? this.recepientId,
      conversationId: conversationId ?? this.conversationId,
      sendAttempts: sendAttempts ?? this.sendAttempts,
      failureCode: failureCode ?? this.failureCode,
    );
  }

  SmsOutboxMessageEntry incAttempt() {
    return copyWith(sendAttempts: sendAttempts + 1);
  }

  SmsOutboxMessageEntry setFailureCode(String code) {
    return SmsOutboxMessageEntry(
      idKey: idKey,
      fromPhoneNumber: fromPhoneNumber,
      toPhoneNumber: toPhoneNumber,
      content: content,
      recepientId: recepientId,
      attachments: attachments,
      conversationId: conversationId,
      sendAttempts: sendAttempts,
      failureCode: code,
    );
  }

  SmsOutboxMessageEntry resetFailure() {
    return SmsOutboxMessageEntry(
      idKey: idKey,
      fromPhoneNumber: fromPhoneNumber,
      toPhoneNumber: toPhoneNumber,
      content: content,
      recepientId: recepientId,
      attachments: attachments,
      conversationId: conversationId,
      sendAttempts: sendAttempts,
      failureCode: null,
    );
  }
}
