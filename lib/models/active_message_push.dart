import 'package:equatable/equatable.dart';

class ActiveMessagePush extends Equatable {
  final String notificationId;
  final int messageId;
  final int conversationId;
  final String title;
  final String body;
  final DateTime time;

  const ActiveMessagePush({
    required this.notificationId,
    required this.messageId,
    required this.conversationId,
    required this.title,
    required this.body,
    required this.time,
  });

  @override
  List<Object?> get props => [notificationId, messageId, conversationId, title, body, time];

  @override
  bool get stringify => true;
}
