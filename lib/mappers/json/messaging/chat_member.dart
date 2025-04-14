import 'dart:convert';

import 'package:webtrit_phone/models/messaging/chat/chat_member.dart';

class ChatMemberJsonMapper {
  static Map<String, dynamic> toMap(ChatMember chatMember) {
    return <String, dynamic>{
      'id': chatMember.id,
      'chat_id': chatMember.chatId,
      'user_id': chatMember.userId,
      'group_authorities': chatMember.groupAuthorities?.name,
    };
  }

  static ChatMember fromMap(Map<String, dynamic> map) {
    return ChatMember(
      id: map['id'] as int,
      chatId: map['chat_id'] as int,
      userId: map['user_id'] as String,
      groupAuthorities:
          map['group_authorities'] == null ? null : GroupAuthorities.values.byName(map['group_authorities'] as String),
    );
  }

  static String toJson(ChatMember chatMember) => json.encode(toMap(chatMember));

  static ChatMember fromJson(String source) => fromMap(json.decode(source) as Map<String, dynamic>);
}

mixin ChatMemberJsonMapperMixin {
  chatMembertoMap(ChatMember chatMember) => ChatMemberJsonMapper.toMap(chatMember);
  chatMemberfromMap(Map<String, dynamic> map) => ChatMemberJsonMapper.fromMap(map);
  chatMembertoJson(ChatMember chatMember) => ChatMemberJsonMapper.toJson(chatMember);
  chatMemberfromJson(String source) => ChatMemberJsonMapper.fromJson(source);
}
