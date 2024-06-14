import 'package:flutter/material.dart';
import 'package:webtrit_phone/models/models.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    required this.chat,
    super.key,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    final membersCount = chat.members.length;
    final name = chat.name ?? 'Chat ${chat.id}';

    return ListTile(
      title: Text(name),
      subtitle: Text('Members: $membersCount'),
    );
  }
}
