import 'package:flutter/material.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({
    required this.chatlist,
    super.key,
  });

  final List<Chat> chatlist;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatlist.length,
      itemBuilder: (context, index) {
        final chat = chatlist[index];
        return ChatListItem(chat: chat);
      },
    );
  }
}
