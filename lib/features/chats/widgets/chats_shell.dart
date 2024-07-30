import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class ChatsShell extends StatefulWidget {
  const ChatsShell({required this.child, super.key});

  final Widget child;

  @override
  State<ChatsShell> createState() => _ChatsShellState();
}

class _ChatsShellState extends State<ChatsShell> {
  late final ChatNotificationsService chatNotificationsService;

  @override
  void initState() {
    chatNotificationsService = ChatNotificationsService(
      context.read<ChatsRepository>(),
      context.read<ContactsRepository>(),
      context.read<MainScreenRouteStateRepository>(),
      openChatList: onOpenChatList,
      openChat: onOpenChat,
      openConversation: onOpenConversation,
    );

    // Wait for userId to be available to initialize chat notifications
    // Todo: remove this when userId is available during main auth flow
    final chatsBloc = context.read<ChatsBloc>();
    Future.doWhile(() async {
      if (!mounted) return false;

      final userId = chatsBloc.state.userId;
      if (userId != null) {
        chatNotificationsService.init(userId);
        return false;
      }

      await Future.delayed(const Duration(milliseconds: 100));
      return true;
    });

    super.initState();
  }

  @override
  void dispose() {
    chatNotificationsService.dispose();
    super.dispose();
  }

  onOpenConversation(participantId) {
    context.router.root.navigate(
      ChatsRouterPageRoute(
        children: [const ChatListScreenPageRoute(), ConversationScreenPageRoute(participantId: participantId)],
      ),
    );
  }

  onOpenChat(chatId) {
    context.router.root.navigate(
      ChatsRouterPageRoute(
        children: [const ChatListScreenPageRoute(), GroupScreenPageRoute(chatId: chatId)],
      ),
    );
  }

  onOpenChatList() {
    context.router.root.navigate(const ChatsRouterPageRoute());
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
