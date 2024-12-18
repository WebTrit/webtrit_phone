import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class ConversationsList extends StatefulWidget {
  const ConversationsList({required this.selectedTab, super.key});

  final TabType? selectedTab;

  @override
  State<ConversationsList> createState() => _ConversationsListState();
}

class _ConversationsListState extends State<ConversationsList> {
  late final userId = context.read<AppBloc>().state.userId!;

  final chatsSearchController = TextEditingController();
  final smsSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    late final chats = BlocBuilder<ChatConversationsCubit, ChatConversationsState>(
      builder: (context, state) {
        if (state.initialising) return const Center(child: CircularProgressIndicator());

        final conversations = state.conversations;
        if (conversations.isEmpty) return Center(child: Text(context.l10n.messaging_ConversationsScreen_empty));

        final search = chatsSearchController.text.toLowerCase();
        List<ChatWithMessageAndMemebers> conversationsToShow;

        if (search.isEmpty) {
          conversationsToShow = conversations;
        } else {
          conversationsToShow = conversations.where((e) {
            var (:chat, :message, :contacts) = e;

            final groupName = chat.name?.toLowerCase();
            final contactNames = contacts
                .where((e) => e.isCurrentUser == false)
                .map((e) => '${e.aliasName} + ${e.firstName} + ${e.lastName}'.toLowerCase())
                .join(' ');
            final contactPhones = contacts.expand((e) => e.phones).map((e) => e.number).join(' ');
            final lastMessageText = message?.content ?? '';

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
                        hintText: context.l10n.messaging_ConversationsScreen_chatsSearch_hint,
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
                  SizedBox(
                    height: 40,
                    child: AnimatedCrossFade(
                      duration: const Duration(milliseconds: 600),
                      firstCurve: Curves.easeIn,
                      secondCurve: Curves.easeIn,
                      sizeCurve: Curves.elasticOut,
                      firstChild: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          chatsSearchController.clear();
                          FocusScope.of(context).unfocus();
                          setState(() {});
                        },
                      ),
                      secondChild: const SizedBox(),
                      crossFadeState:
                          chatsSearchController.text.isNotEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: conversationsToShow.map((e) {
                  final (:chat, :message, contacts: _) = e;
                  return FadeIn(
                    child: ChatConversationsTile(
                      conversation: chat,
                      lastMessage: message,
                      userId: userId,
                      key: ValueKey(e),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );

    late final smses = BlocBuilder<SmsConversationsCubit, SmsConversationsState>(
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
            final (conversation, lastMessage) = e;
            final phones = conversation.firstPhoneNumber.toLowerCase() + conversation.secondPhoneNumber.toLowerCase();
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
                        hintText: context.l10n.messaging_ConversationsScreen_smssSearch_hint,
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
                  SizedBox(
                    height: 40,
                    child: AnimatedCrossFade(
                      duration: const Duration(milliseconds: 600),
                      firstCurve: Curves.easeIn,
                      secondCurve: Curves.easeIn,
                      sizeCurve: Curves.elasticOut,
                      firstChild: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          smsSearchController.clear();
                          FocusScope.of(context).unfocus();
                          setState(() {});
                        },
                      ),
                      secondChild: const SizedBox(),
                      crossFadeState:
                          smsSearchController.text.isNotEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    ),
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
                  return FadeIn(
                    child: SmsConversationsTile(
                      conversation: conversation,
                      lastMessage: lastMessage,
                      userId: userId,
                      key: ValueKey(e),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );

    late final unsupported = Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(
          context.l10n.messaging_ConversationsScreen_unsupported,
          textAlign: TextAlign.center,
        ),
      ),
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 0),
      switchInCurve: Curves.easeOutExpo,
      switchOutCurve: Curves.easeInExpo,
      child: switch (widget.selectedTab) {
        TabType.chat => chats,
        TabType.sms => smses,
        _ => unsupported,
      },
      transitionBuilder: (child, animation) {
        final reverse = widget.selectedTab == TabType.sms;

        final begin = Offset(reverse ? 1.0 : -1.0, 0);
        const end = Offset(0, 0);

        return SlideTransition(position: animation.drive(Tween(begin: begin, end: end)), child: child);
      },
    );
  }
}
