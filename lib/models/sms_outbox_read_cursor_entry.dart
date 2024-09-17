// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SmsOutboxReadCursorEntry extends Equatable {
  final int conversationId;
  final DateTime time;
  final int sendAttempts;

  const SmsOutboxReadCursorEntry({required this.conversationId, required this.time, this.sendAttempts = 0});

  SmsOutboxReadCursorEntry copyWith({
    int? conversationId,
    DateTime? time,
    int? sendAttempts,
  }) {
    return SmsOutboxReadCursorEntry(
      conversationId: conversationId ?? this.conversationId,
      time: time ?? this.time,
      sendAttempts: sendAttempts ?? this.sendAttempts,
    );
  }

  SmsOutboxReadCursorEntry incAttempts() {
    return copyWith(sendAttempts: sendAttempts + 1);
  }

  @override
  List<Object> get props => [conversationId, time, sendAttempts];
}
