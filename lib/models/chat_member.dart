// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class ChatMember extends Equatable {
  final int chatId;
  final String userId;
  final DateTime joinedAt;
  final DateTime? leftAt;
  final DateTime? blockedAt;

  const ChatMember({
    required this.chatId,
    required this.userId,
    required this.joinedAt,
    this.leftAt,
    this.blockedAt,
  });

  @override
  List<Object?> get props => [chatId, userId, joinedAt, leftAt, blockedAt];

  @override
  bool get stringify => true;
}
