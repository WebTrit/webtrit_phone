import 'dart:convert';
import 'package:equatable/equatable.dart';

class ChatMember extends Equatable {
  final int id;
  final int chatId;
  final String userId;
  final GroupAuthorities? groupAuthorities;

  const ChatMember({
    required this.id,
    required this.chatId,
    required this.userId,
    required this.groupAuthorities,
  });

  @override
  List<Object?> get props => [id, chatId, userId, groupAuthorities];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'chat_id': chatId,
      'user_id': userId,
      'group_authorities': groupAuthorities?.name,
    };
  }

  factory ChatMember.fromMap(Map<String, dynamic> map) {
    return ChatMember(
      id: map['id'] as int,
      chatId: map['chat_id'] as int,
      userId: map['user_id'] as String,
      groupAuthorities:
          map['group_authorities'] == null ? null : GroupAuthorities.values.byName(map['group_authorities'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMember.fromJson(String source) => ChatMember.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension ChatMembersIterableExtension<T extends ChatMember> on Iterable<T> {
  bool isActiveMember(String memberId) => any((member) => member.userId == memberId);

  List<ChatMember> participants(String userId) => where((member) => member.userId != userId).toList();
}

enum GroupAuthorities { moderator, owner }
