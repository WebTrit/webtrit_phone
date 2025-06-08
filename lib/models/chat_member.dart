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
  String toString() {
    return 'ChatMember(id: $id, chatId: $chatId, userId: $userId, groupAuthorities: $groupAuthorities)';
  }
}

extension ChatMembersIterableExtension<T extends ChatMember> on Iterable<T> {
  bool isActiveMember(String memberId) => any((member) => member.userId == memberId);

  List<ChatMember> participants(String userId) => where((member) => member.userId != userId).toList();

  bool isGroupModerator(String userId) {
    return any((m) => m.userId == userId && m.groupAuthorities == GroupAuthorities.moderator);
  }

  bool isGroupOwner(String userId) {
    return any((m) => m.userId == userId && m.groupAuthorities == GroupAuthorities.owner);
  }
}

enum GroupAuthorities { moderator, owner }
