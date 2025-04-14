import 'dart:convert';

import 'package:webtrit_phone/models/messaging/chat/chat_conversation.dart';
import 'package:webtrit_phone/models/messaging/chat/chat_member.dart';

import 'chat_member.dart';

class ChatConversationJsonMapper {
  static Map<String, dynamic> toMap(Chat chat) {
    return <String, dynamic>{
      'id': chat.id,
      'type': chat.type.name,
      'name': chat.name,
      'inserted_at': chat.createdAt.toIso8601String(),
      'updated_at': chat.updatedAt.toIso8601String(),
      'members': chat.members.map((x) => ChatMemberJsonMapper.toMap(x)).toList(),
    };
  }

  static Chat fromMap(Map<String, dynamic> map) {
    // Backward compatibility for the old 'dialog' type
    // TODO: Remove someday
    if (map['type'] == 'dialog') map['type'] = 'direct';

    return Chat(
      id: map['id'] as int,
      type: ChatType.values.byName(map['type']),
      name: map['name'] != null ? map['name'] as String : null,
      createdAt: DateTime.parse(map['inserted_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      members: List<ChatMember>.from(
        (map['members'] as List<dynamic>).map<ChatMember>(
          (x) => ChatMemberJsonMapper.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  static String toJson(Chat chat) => json.encode(toMap(chat));

  static Chat fromJson(String source) => fromMap(json.decode(source) as Map<String, dynamic>);
}

mixin ChatConversationJsonMapperMixin {
  chatConversationtoMap(Chat chat) => ChatConversationJsonMapper.toMap(chat);
  chatConversationfromMap(Map<String, dynamic> map) => ChatConversationJsonMapper.fromMap(map);
  chatConversationtoJson(Chat chat) => ChatConversationJsonMapper.toJson(chat);
  chatConversationfromJson(String source) => ChatConversationJsonMapper.fromJson(source);
}
