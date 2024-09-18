import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class ConversationsList extends StatelessWidget {
  const ConversationsList({required this.tabType, super.key});

  final TabType tabType;

  @override
  Widget build(BuildContext context) {
    final userId = AppPreferences().getChatUserId()!;
    if (tabType == TabType.chat) {
      return BlocBuilder<ChatConversationsCubit, ChatConversationsState>(
        builder: (context, state) {
          if (state.initialising) return const Center(child: CircularProgressIndicator());

          final conversations = state.conversations;
          if (conversations.isEmpty) return Center(child: Text(context.l10n.chats_ConversationsScreen_empty));

          return ListView(
            children: conversations.map((e) {
              final conversation = e.$1;
              final lastMessage = e.$2;
              return ChatConversationsTile(conversation: conversation, lastMessage: lastMessage, userId: userId);
            }).toList(),
          );
        },
      );
    }
    if (tabType == TabType.sms) {
      return BlocBuilder<SmsConversationsCubit, SmsConversationsState>(
        builder: (context, state) {
          if (state.initialising) return const Center(child: CircularProgressIndicator());

          final conversations = state.conversations;
          if (conversations.isEmpty) return Center(child: Text(context.l10n.chats_ConversationsScreen_empty));

          return ListView(
            children: conversations.map((e) {
              final conversation = e.$1;
              final lastMessage = e.$2;
              return SmsConversationsTile(conversation: conversation, lastMessage: lastMessage, userId: userId);
            }).toList(),
          );
        },
      );
    }

    return const SizedBox();
  }
}
