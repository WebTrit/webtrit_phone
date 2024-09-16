// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SmsOutboxMessageDeleteEntry extends Equatable {
  final int id;
  final String idKey;
  final int conversationId;
  final int sendAttempts;

  const SmsOutboxMessageDeleteEntry({
    required this.id,
    required this.idKey,
    required this.conversationId,
    this.sendAttempts = 0,
  });

  @override
  List<Object?> get props => [id, idKey, conversationId, sendAttempts];

  @override
  bool get stringify => true;

  SmsOutboxMessageDeleteEntry copyWith({
    int? id,
    String? idKey,
    int? conversationId,
    int? sendAttempts,
  }) {
    return SmsOutboxMessageDeleteEntry(
      id: id ?? this.id,
      idKey: idKey ?? this.idKey,
      conversationId: conversationId ?? this.conversationId,
      sendAttempts: sendAttempts ?? this.sendAttempts,
    );
  }

  SmsOutboxMessageDeleteEntry incAttempts() {
    return copyWith(sendAttempts: sendAttempts + 1);
  }
}
