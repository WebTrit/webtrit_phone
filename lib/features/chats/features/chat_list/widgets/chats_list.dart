import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({required this.chatlist, super.key});
  final List<(Chat, ChatMessage?)> chatlist;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsBloc, ChatsState>(
      builder: (context, state) {
        final userId = state.userId;
        if (userId == null) return const Center(child: CircularProgressIndicator());

        return ListView(
          children: chatlist.map((e) {
            final chat = e.$1;
            final lastMessage = e.$2;
            return ChatListItem(chat: chat, lastMessage: lastMessage, userId: userId);
          }).toList(),
        );
      },
    );
  }
}
