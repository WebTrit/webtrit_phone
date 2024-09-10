import 'package:equatable/equatable.dart';

class SmsOutboxMessageEntry extends Equatable {
  final String idKey;
  final String fromPhoneNumber;
  final String toPhoneNumber;
  final String content;
  final int? conversationId;
  final int sendAttempts;

  const SmsOutboxMessageEntry({
    required this.idKey,
    required this.fromPhoneNumber,
    required this.toPhoneNumber,
    required this.content,
    this.conversationId,
    this.sendAttempts = 0,
  });

  @override
  List<Object?> get props => [idKey, fromPhoneNumber, toPhoneNumber, content, conversationId, sendAttempts];

  @override
  bool get stringify => true;

  SmsOutboxMessageEntry copyWith({
    String? idKey,
    String? fromPhoneNumber,
    String? toPhoneNumber,
    String? content,
    int? conversationId,
    int? sendAttempts,
  }) {
    return SmsOutboxMessageEntry(
      idKey: idKey ?? this.idKey,
      fromPhoneNumber: fromPhoneNumber ?? this.fromPhoneNumber,
      toPhoneNumber: toPhoneNumber ?? this.toPhoneNumber,
      content: content ?? this.content,
      conversationId: conversationId ?? this.conversationId,
      sendAttempts: sendAttempts ?? this.sendAttempts,
    );
  }

  SmsOutboxMessageEntry incAttempt() {
    return copyWith(sendAttempts: sendAttempts + 1);
  }
}
