// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'package:equatable/equatable.dart';

class ChatMember extends Equatable {
  final int id;
  final int chatId;
  final String userId;
  final DateTime joinedAt;
  final DateTime? leftAt;
  final DateTime? blockedAt;

  const ChatMember({
    required this.id,
    required this.chatId,
    required this.userId,
    required this.joinedAt,
    this.leftAt,
    this.blockedAt,
  });

  @override
  List<Object?> get props => [id, chatId, userId, joinedAt, leftAt, blockedAt];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'chat_id': chatId,
      'user_id': userId,
      'joined_at': joinedAt.millisecondsSinceEpoch,
      'left_at': leftAt?.millisecondsSinceEpoch,
      'blocked_at': blockedAt?.millisecondsSinceEpoch,
    };
  }

  factory ChatMember.fromMap(Map<String, dynamic> map) {
    return ChatMember(
      id: map['id'] as int,
      chatId: map['chat_id'] as int,
      userId: map['user_id'] as String,
      joinedAt: DateTime.parse(map['joined_at']),
      leftAt: map['left_at'] != null ? DateTime.parse(map['left_at']) : null,
      blockedAt: map['blocked_at'] != null ? DateTime.parse(map['blocked_at']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMember.fromJson(String source) => ChatMember.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension ChatMembersIterableExtension<T extends ChatMember> on Iterable<T> {
  bool isActiveMember(String memberId) =>
      any((member) => member.userId == memberId && member.blockedAt == null && member.leftAt == null);

  List<ChatMember> participants(String userId) => where((member) => member.userId != userId).toList();
}
