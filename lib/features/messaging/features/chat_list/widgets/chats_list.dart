import 'package:flutter/material.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

class ChatsList extends StatefulWidget {
  const ChatsList({required this.chatlist, required this.smsChatlist, super.key});
  final List<(Chat, ChatMessage?)> chatlist;
  final List<(Chat, ChatMessage?)> smsChatlist;

  @override
  State<ChatsList> createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
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
            child: Builder(
              builder: (context) {
                final chats = widget.chatlist;
                if (chats.isEmpty) return Center(child: Text(context.l10n.chats_ChatListScreen_empty));

                return ListView(
                  children: chats.map((e) {
                    final chat = e.$1;
                    final lastMessage = e.$2;
                    return ChatListItem(chat: chat, lastMessage: lastMessage, userId: userId);
                  }).toList(),
                );
              },
            ),
          ),
        if (showSms)
          Expanded(
            child: Builder(
              builder: (context) {
                final smsChats = widget.smsChatlist;
                if (smsChats.isEmpty) return Center(child: Text(context.l10n.chats_ChatListScreen_empty));

                return ListView(
                  children: smsChats.map((e) {
                    final chat = e.$1;
                    final lastMessage = e.$2;
                    return ChatListItem(chat: chat, lastMessage: lastMessage, userId: userId);
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
