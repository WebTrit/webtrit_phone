import 'package:webtrit_phone/models/chat_member.dart';

extension ChatMembersIterableExtension<T extends ChatMember> on Iterable<T> {
  bool isActiveMember(String memberId) =>
      any((member) => member.userId == memberId && member.blockedAt == null && member.leftAt == null);
}
