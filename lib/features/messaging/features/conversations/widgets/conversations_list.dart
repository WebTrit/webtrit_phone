import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class ConversationsList extends StatefulWidget {
  const ConversationsList({super.key});

  @override
  State<ConversationsList> createState() => _ConversationsListState();
}

class _ConversationsListState extends State<ConversationsList> {
  final userId = AppPreferences().getChatUserId()!;
  final chatsEnabled = EnvironmentConfig.CHAT_FEATURE_ENABLE;
  final smsEnabled = EnvironmentConfig.SMS_FEATURE_ENABLE;

  TabType? tabType = TabType.chat;

  bool get showChats => (chatsEnabled && smsEnabled && tabType == TabType.chat) || (chatsEnabled && !smsEnabled);
  bool get showSms => (chatsEnabled && smsEnabled && tabType == TabType.sms) || (!chatsEnabled && smsEnabled);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        if (chatsEnabled && smsEnabled) ...[
          const SizedBox(height: 10),
          tabButtons(colorScheme),
          const SizedBox(height: 10),
        ],
        if (showChats)
          Expanded(
            child: BlocBuilder<ChatConversationsCubit, ChatConversationsState>(
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
            ),
          ),
        if (showSms)
          Expanded(
            child: BlocBuilder<SmsConversationsCubit, SmsConversationsState>(
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
            ),
          ),
      ],
    );
  }

  Widget tabButtons(ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primary,
        border: Border.all(color: colorScheme.secondaryFixedDim),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: tabType == TabType.chat ? colorScheme.primary : colorScheme.surfaceBright,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {
                setState(() {
                  tabType = TabType.chat;
                });
              },
              child: Container(
                width: 120,
                height: 30,
                alignment: Alignment.center,
                child: Text(
                  'Messages',
                  style: TextStyle(
                    color: tabType == TabType.chat ? colorScheme.onPrimary : colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ),
          Material(
            color: tabType == TabType.sms ? colorScheme.primary : colorScheme.surfaceBright,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {
                setState(() {
                  tabType = TabType.sms;
                });
              },
              child: Container(
                width: 120,
                height: 30,
                alignment: Alignment.center,
                child: Text(
                  'SMS',
                  style: TextStyle(
                    color: tabType == TabType.sms ? colorScheme.onPrimary : colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum TabType { chat, sms }
