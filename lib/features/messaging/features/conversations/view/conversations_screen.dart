import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

enum TabType { chat, sms }

sealed class TabsState {
  const TabsState(this.groupChatsEnabled);
  final bool groupChatsEnabled;
  TabType get loogingAtTab;
}

final class SingleTabState extends TabsState {
  const SingleTabState(this.tab, super.groupChatsEnabled);

  final TabType tab;

  @override
  TabType get loogingAtTab => tab;
}

final class DualTabState extends TabsState {
  const DualTabState(this.selectedTab, super.groupChatsEnabled);

  final TabType selectedTab;

  @override
  TabType get loogingAtTab => selectedTab;

  DualTabState copyWith({TabType? selectedTab}) {
    return DualTabState(selectedTab ?? this.selectedTab, groupChatsEnabled);
  }
}

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key, required this.title, required this.initialTabsState});

  final Widget title;
  final TabsState initialTabsState;

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> with SingleTickerProviderStateMixin {
  late final messagingBloc = context.read<MessagingBloc>();
  late final chatsRepository = context.read<ChatsRepository>();
  late final smsRepository = context.read<SmsRepository>();
  late final contactsRepository = context.read<ContactsRepository>();
  late final notificationsBloc = context.read<NotificationsBloc>();

  late TabsState tabsState = widget.initialTabsState;

  Future<void> onNewChatConversation() async {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => ChatConversationBuilderCubit(
          messagingBloc.state.client,
          chatsRepository,
          contactsRepository,
          chatConversationBuilderConfig: ChatConversationBuilderConfig(enableGroupChats: tabsState.groupChatsEnabled),
          openDialog: (contact) async {
            Navigator.of(context).pop();
            await Future.delayed(const Duration(milliseconds: 300));
            openDialog(contact);
          },
          openGroup: (id) async {
            Navigator.of(context).pop();
            await Future.delayed(const Duration(milliseconds: 300));
            openGroup(id);
          },
          submitNotification: (n) {
            notificationsBloc.add(NotificationsSubmitted(n));
          },
        ),
        child: const ChatConversationBuilderView(),
      ),
    );
  }

  Future<void> onNewSmsConversation() async {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => SmsConversationBuilderCubit(
          smsRepository,
          contactsRepository,
          openSmsDialog: (userNumber, recipientNumber, recipientId) async {
            Navigator.of(context).pop();
            await Future.delayed(const Duration(milliseconds: 300));
            openSmsDialog(userNumber, recipientNumber, recipientId);
          },
        ),
        child: const SmsConversationBuilderView(),
      ),
    );
  }

  void openDialog(Contact contact) {
    if (!mounted) return;
    context.router.navigate(ChatConversationScreenPageRoute(participantId: contact.sourceId));
  }

  void openGroup(int id) {
    if (!mounted) return;
    context.router.navigate(ChatConversationScreenPageRoute(chatId: id));
  }

  Future<void> openSmsDialog(String userNumber, String recipientNumber, String? recipientId) async {
    if (!mounted) return;
    context.router.navigate(
      SmsConversationScreenPageRoute(firstNumber: userNumber, secondNumber: recipientNumber, recipientId: recipientId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final tabsStateIt = tabsState;

    return Unfocuser(
      child: Scaffold(
        appBar: MainAppBar(
          title: widget.title,
          context: context,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(
              kMainAppBarBottomSearchHeight + (tabsStateIt is DualTabState ? kMainAppBarBottomTabHeight : 0.0),
            ),
            child: Column(
              children: [
                if (tabsStateIt is DualTabState) ...[
                  TabButtons(
                    selectedTab: tabsStateIt.selectedTab,
                    onTabSelected: (tab) => setState(() => tabsState = tabsStateIt.copyWith(selectedTab: tab)),
                  ),
                  SizedBox(height: 8),
                ],
                IgnoreUnfocuser(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kMainAppBarBottomPaddingGap),
                    child: ClearedTextField(
                      onChanged: (value) {
                        context.readOrNull<ChatConversationsCubit>()?.updateSearch(value);
                        context.readOrNull<SmsConversationsCubit>()?.updateSearch(value);
                      },
                      onSubmitted: (value) => {},
                      iconConstraints: const BoxConstraints.expand(
                        width: kMainAppBarBottomSearchHeight - kMainAppBarBottomPaddingGap,
                        height: kMainAppBarBottomSearchHeight - kMainAppBarBottomPaddingGap,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
        body: MessagingStateWrapper(child: ConversationsList(selectedTab: tabsState.loogingAtTab)),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              backgroundColor: colorScheme.primary,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
              onPressed: switch (tabsState.loogingAtTab) {
                TabType.chat => onNewChatConversation,
                TabType.sms => onNewSmsConversation,
              },
              child: Icon(Icons.add, color: colorScheme.onPrimary),
            );
          },
        ),
      ),
    );
  }
}
