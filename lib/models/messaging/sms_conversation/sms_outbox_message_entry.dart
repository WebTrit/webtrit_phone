import 'package:equatable/equatable.dart';

class SmsOutboxMessageEntry extends Equatable {
  final String idKey;
  final String fromPhoneNumber;
  final String toPhoneNumber;
  final String content;

  /// recipientId should be removed as soon as possible when backend will be ready
  /// to avoid unsecurity bullshit from the backend side
  final String? recepientId;
  final int? conversationId;
  final int sendAttempts;

  const SmsOutboxMessageEntry({
    required this.idKey,
    required this.fromPhoneNumber,
    required this.toPhoneNumber,
    required this.content,
    this.recepientId,
    this.conversationId,
    this.sendAttempts = 0,
  });

  @override
  List<Object?> get props => [
        idKey,
        fromPhoneNumber,
        toPhoneNumber,
        content,
        recepientId,
        conversationId,
        sendAttempts,
      ];

  @override
  bool get stringify => true;

  SmsOutboxMessageEntry copyWith({
    String? idKey,
    String? fromPhoneNumber,
    String? toPhoneNumber,
    String? content,
    String? recepientId,
    int? conversationId,
    int? sendAttempts,
  }) {
    return SmsOutboxMessageEntry(
      idKey: idKey ?? this.idKey,
      fromPhoneNumber: fromPhoneNumber ?? this.fromPhoneNumber,
      toPhoneNumber: toPhoneNumber ?? this.toPhoneNumber,
      content: content ?? this.content,
      recepientId: recepientId ?? this.recepientId,
      conversationId: conversationId ?? this.conversationId,
      sendAttempts: sendAttempts ?? this.sendAttempts,
    );
  }

  SmsOutboxMessageEntry incAttempt() {
    return copyWith(sendAttempts: sendAttempts + 1);
  }

  @override
  String toString() {
    return 'SmsOutboxMessageEntry(idKey: $idKey, fromPhoneNumber: $fromPhoneNumber, toPhoneNumber: $toPhoneNumber, content: $content, recepientId: $recepientId, conversationId: $conversationId, sendAttempts: $sendAttempts)';
  }
}
