import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'conversations_screen_style.dart';
import 'conversations_screen_styles.dart';

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
  const ConversationsScreen({super.key, required this.title, required this.initialTabsState, this.style});

  final Widget title;
  final TabsState initialTabsState;
  final ConversationsScreenStyle? style;

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> with SingleTickerProviderStateMixin {
  late final messagingBloc = context.read<MessagingBloc>();
  late final chatsRepository = context.read<ChatsRepository>();
  late final smsRepository = context.read<SmsRepository>();
  late final contactsRepository = context.read<ContactsRepository>();
  late final notificationsBloc = context.read<NotificationsBloc>();

  late TabController _tabController;
  late final List<TabType> _tabs;

  @override
  void initState() {
    super.initState();
    final initialTabsState = widget.initialTabsState;

    _tabs = switch (initialTabsState) {
      SingleTabState s => [s.tab],
      DualTabState _ => [TabType.chat, TabType.sms],
    };

    final initialIndex = _tabs.indexOf(initialTabsState.loogingAtTab);

    _tabController = TabController(
      initialIndex: initialIndex == -1 ? 0 : initialIndex,
      length: _tabs.length,
      vsync: this,
    );
    _tabController.addListener(_tabControllerListener);
  }

  @override
  void dispose() {
    _tabController.removeListener(_tabControllerListener);
    _tabController.dispose();
    super.dispose();
  }

  void _tabControllerListener() {
    if (!_tabController.indexIsChanging) {
      setState(() {});
    }
  }

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
          chatConversationBuilderConfig: ChatConversationBuilderConfig(
            enableGroupChats: widget.initialTabsState.groupChatsEnabled,
          ),
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
    final themeData = Theme.of(context);
    final effectiveStyle = widget.style ?? themeData.extension<ConversationsScreenStyles>()?.primary;
    final background = effectiveStyle?.background;
    final isComplexBackground = background?.isComplex ?? false;

    final colorScheme = themeData.colorScheme;
    final mediaQueryData = MediaQuery.of(context);

    final tabBar = _tabs.length <= 1
        ? null
        : Padding(
            padding: const EdgeInsets.only(bottom: kMainAppBarBottomPaddingGap),
            child: BlocBuilder<UnreadCountCubit, UnreadCountState>(
              builder: (context, unreadCountState) {
                return ExtTabBar(
                  controller: _tabController,
                  width: mediaQueryData.size.width * 0.75,
                  height: kMainAppBarBottomTabHeight - kMainAppBarBottomPaddingGap,
                  tabs: _tabs.map((tabType) {
                    final title = switch (tabType) {
                      TabType.chat => context.l10n.messaging_ConversationsScreen_messages_title,
                      TabType.sms => context.l10n.messaging_ConversationsScreen_smses_title,
                    };
                    final count = switch (tabType) {
                      TabType.chat => unreadCountState.chatsWithUnreadCount,
                      TabType.sms => unreadCountState.smsConversationsWithUnreadCount,
                    };
                    final isActive = _tabController.index == _tabs.indexOf(tabType);

                    return Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(title),
                          if (count > 0) ...[
                            const SizedBox(width: 4),
                            UnreadBadge(count: count, isActive: isActive, colorScheme: colorScheme),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          );

    final search = Padding(
      padding: const EdgeInsets.only(
        left: kMainAppBarBottomPaddingGap,
        right: kMainAppBarBottomPaddingGap,
        bottom: kMainAppBarBottomPaddingGap,
      ),
      child: IgnoreUnfocuser(
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
    );

    return Unfocuser(
      child: ThemedScaffold(
        background: effectiveStyle?.background,
        contentThemeOverride: effectiveStyle?.contentThemeOverride ?? ThemeMode.system,
        applyToAppBar: effectiveStyle?.applyToAppBar ?? true,
        appBar: MainAppBar(
          title: widget.title,
          context: context,
          backgroundColor: isComplexBackground ? Colors.transparent : null,
          elevation: isComplexBackground ? 0 : null,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(
              (tabBar != null ? kMainAppBarBottomTabHeight : 0) + kMainAppBarBottomSearchHeight,
            ),
            child: Column(children: [if (tabBar != null) tabBar, search]),
          ),
        ),
        body: MessagingStateWrapper(
          child: TabBarView(
            controller: _tabController,
            children: [for (final tab in _tabs) ConversationsList(selectedTab: tab)],
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              backgroundColor: colorScheme.primary,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
              onPressed: switch (_tabs[_tabController.index]) {
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
