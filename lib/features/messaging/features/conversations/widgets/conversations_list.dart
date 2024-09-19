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
    final chats = BlocBuilder<ChatConversationsCubit, ChatConversationsState>(
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

    final smses = BlocBuilder<SmsConversationsCubit, SmsConversationsState>(
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

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 0),
      switchInCurve: Curves.easeOutExpo,
      switchOutCurve: Curves.easeInExpo,
      child: tabType == TabType.chat ? chats : smses,
      transitionBuilder: (child, animation) {
        final reverse = tabType == TabType.sms;

        final begin = Offset(reverse ? 1.0 : -1.0, 0);
        const end = Offset(0, 0);

        return SlideTransition(position: animation.drive(Tween(begin: begin, end: end)), child: child);
      },
    );
  }
}
