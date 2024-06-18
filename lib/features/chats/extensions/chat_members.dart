import 'package:webtrit_phone/models/chat_member.dart';

extension ChatMembersIterableExtension<T extends ChatMember> on Iterable<T> {
  bool isActiveMember(int memberId) =>
      any((member) => member.id == memberId && member.blockedAt == null && member.leftAt == null);
}
