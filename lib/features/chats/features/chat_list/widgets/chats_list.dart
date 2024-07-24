import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({required this.chatlist, super.key});
  final List<Chat> chatlist;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsBloc, ChatsState>(
      builder: (context, state) {
        final userId = state.userId;
        if (userId == null) return const Center(child: CircularProgressIndicator());

        return ListView.builder(
          itemCount: chatlist.length,
          itemBuilder: (context, index) {
            final chat = chatlist[index];

            return ChatListItem(chat: chat, userId: userId, key: ValueKey(chat.id));
          },
        );
      },
    );
  }
}
