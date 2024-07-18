import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({required this.chatlist, super.key});
  final List<Chat> chatlist;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatlist.length,
      itemBuilder: (context, index) {
        final chat = chatlist[index];
        return BlocBuilder<ChatsBloc, ChatsState>(
          builder: (context, state) {
            return ChatListItem(
              chat: chat,
              userId: state.userId,
              key: ValueKey(chat.id),
            );
          },
        );
      },
    );
  }
}
