import 'package:webtrit_phone/models/chat_member.dart';

class ChatMemberPhxMapper {
  static ChatMember fromMap(Map<String, dynamic> map) {
    return ChatMember(
      id: map['id'] as int,
      chatId: map['chat_id'] as int,
      userId: map['user_id'] as String,
      groupAuthorities:
          map['group_authorities'] == null ? null : GroupAuthorities.values.byName(map['group_authorities'] as String),
    );
  }
}

mixin ChatMemberPhxMapperMixin {
  ChatMember fromMap(Map<String, dynamic> map) => ChatMemberPhxMapper.fromMap(map);
}
