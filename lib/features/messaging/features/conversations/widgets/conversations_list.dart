import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

class ConversationsList extends StatefulWidget {
  const ConversationsList({required this.tabType, super.key});

  final TabType tabType;

  @override
  State<ConversationsList> createState() => _ConversationsListState();
}

class _ConversationsListState extends State<ConversationsList> {
  final chatsSearchController = TextEditingController();
  final smsSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final userId = AppPreferences().getChatUserId()!;

    final chats = BlocBuilder<ChatConversationsCubit, ChatConversationsState>(
      builder: (context, state) {
        if (state.initialising) return const Center(child: CircularProgressIndicator());

        final conversations = state.conversations;
        if (conversations.isEmpty) return Center(child: Text(context.l10n.messaging_ConversationsScreen_empty));

        final search = chatsSearchController.text.toLowerCase();
        List<(Chat, ChatMessage?, List<Contact>)> conversationsToShow;

        if (search.isEmpty) {
          conversationsToShow = conversations;
        } else {
          conversationsToShow = conversations.where((e) {
            final conversation = e.$1;
            final lastMessage = e.$2;
            final contacts = e.$3;
            final groupName = conversation.name?.toLowerCase();
            final contactNames =
                contacts.map((e) => '${e.aliasName} + ${e.firstName} + ${e.lastName}'.toLowerCase()).join(' ');
            final contactPhones = contacts.expand((e) => e.phones).map((e) => e.number).join(' ');
            final lastMessageText = lastMessage?.content ?? '';

            return groupName?.contains(search) == true ||
                contactNames.contains(search) ||
                contactPhones.contains(search) ||
                lastMessageText.contains(search);
          }).toList();
        }

        return Column(
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: chatsSearchController,
                      decoration: InputDecoration(
                        hintText: context.l10n.messaging_NewConversation_contactOrNumberSearch_hint,
                        fillColor: colorScheme.surface,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                      onChanged: (value) => setState(() {}),
                    ),
                  ),
                  if (chatsSearchController.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        chatsSearchController.clear();
                        FocusScope.of(context).unfocus();
                        setState(() {});
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: conversationsToShow.map((e) {
                  final conversation = e.$1;
                  final lastMessage = e.$2;
                  return ChatConversationsTile(
                    conversation: conversation,
                    lastMessage: lastMessage,
                    userId: userId,
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );

    final smses = BlocBuilder<SmsConversationsCubit, SmsConversationsState>(
      builder: (context, state) {
        if (state.initialising) return const Center(child: CircularProgressIndicator());

        final conversations = state.conversations;
        if (conversations.isEmpty) return Center(child: Text(context.l10n.messaging_ConversationsScreen_empty));

        final search = smsSearchController.text.toLowerCase();

        List<(SmsConversation, SmsMessage?)> conversationsToShow;
        if (search.isEmpty) {
          conversationsToShow = conversations;
        } else {
          conversationsToShow = conversations.where((e) {
            final conversation = e.$1;
            final phones = conversation.firstPhoneNumber.toLowerCase() + conversation.secondPhoneNumber.toLowerCase();
            final lastMessage = e.$2;
            final lastMessageText = lastMessage?.content ?? '';

            return phones.contains(search) || lastMessageText.contains(search);
          }).toList();
        }

        return Column(
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: smsSearchController,
                      decoration: InputDecoration(
                        hintText: context.l10n.messaging_NewConversation_contactOrNumberSearch_hint,
                        fillColor: colorScheme.surface,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                      onChanged: (value) => setState(() {}),
                    ),
                  ),
                  if (smsSearchController.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        smsSearchController.clear();
                        FocusScope.of(context).unfocus();
                        setState(() {});
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: conversationsToShow.map((e) {
                  final conversation = e.$1;
                  final lastMessage = e.$2;
                  return SmsConversationsTile(conversation: conversation, lastMessage: lastMessage, userId: userId);
                }).toList(),
              ),
            ),
          ],
        );
      },
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 0),
      switchInCurve: Curves.easeOutExpo,
      switchOutCurve: Curves.easeInExpo,
      child: widget.tabType == TabType.chat ? chats : smses,
      transitionBuilder: (child, animation) {
        final reverse = widget.tabType == TabType.sms;

        final begin = Offset(reverse ? 1.0 : -1.0, 0);
        const end = Offset(0, 0);

        return SlideTransition(position: animation.drive(Tween(begin: begin, end: end)), child: child);
      },
    );
  }
}
