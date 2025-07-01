import 'package:webtrit_phone/models/messaging/chat_conversation/chat.dart';
import 'package:webtrit_phone/models/messaging/chat_conversation/chat_member.dart';

import 'chat_member_mapper.dart';

class ChatPhxMapper {
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
          (x) => ChatMemberPhxMapper.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

mixin ChatPhxMapperMixin {
  Chat fromMap(Map<String, dynamic> map) => ChatPhxMapper.fromMap(map);
}
