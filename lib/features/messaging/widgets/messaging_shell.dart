import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class MessagingShell extends StatefulWidget {
  const MessagingShell({required this.child, super.key});

  final Widget child;

  @override
  State<MessagingShell> createState() => _MessagingShellState();
}

class _MessagingShellState extends State<MessagingShell> {
  late final messagingBloc = context.read<MessagingBloc>();
  late final messagingFeature = FeatureAccess().messagingFeature;

  MessagingNotificationsService? notificationsService;

  @override
  void initState() {
    super.initState();

    /// Init messaging feature watcher
    Future.doWhile(() async {
      syncMessaging();
      if (!mounted) return false;
      return await Future.delayed(const Duration(seconds: 5), () => true);
    });
  }

  /// Sync messaging services with the feature configuration state
  /// user for enabling/disabling messaging services on the fly if remote confing changes
  /// init messaging socket connection and notifications service if messaging is enabled
  /// dispose messaging socket connection and notifications service if messaging is disabled
  syncMessaging() {
    final messagingEnabled = messagingFeature.anyMessagingEnabled;

    if (messagingEnabled == true) {
      final connectionStatus = messagingBloc.state.status;
      if (connectionStatus == ConnectionStatus.initial) messagingBloc.add(const Connect());

      notificationsService ??= MessagingNotificationsService(
        context.read<AppBloc>().state.userId!,
        context.read<ChatsRepository>(),
        context.read<SmsRepository>(),
        context.read<ContactsRepository>(),
        context.read<RemoteNotificationRepository>(),
        context.read<LocalNotificationRepository>(),
        context.read<ActiveMessageNotificationsRepository>(),
        context.read<MainScreenRouteStateRepository>(),
        context.read<MainShellRouteStateRepository>(),
        onOpenChatList,
        onOpenChat,
        onOpenConversation,
        onOpenSmsConversation,
      )..init();
    }

    if (messagingEnabled == false) {
      final connectionStatus = messagingBloc.state.status;
      if (connectionStatus != ConnectionStatus.initial) messagingBloc.add(const Disconnect());

      notificationsService?.dispose();
      notificationsService = null;
    }
  }

  @override
  void dispose() {
    notificationsService?.dispose();
    super.dispose();
  }

  onOpenConversation(participantId) {
    context.router.navigate(ChatConversationScreenPageRoute(participantId: participantId));
  }

  onOpenChat(chatId) {
    context.router.navigate(ChatConversationScreenPageRoute(chatId: chatId));
  }

  onOpenSmsConversation(firstNumber, secondNumber) {
    context.router.navigate(SmsConversationScreenPageRoute(firstNumber: firstNumber, secondNumber: secondNumber));
  }

  onOpenChatList() {
    context.router.navigate(const MainScreenPageRoute(children: [ConversationsScreenPageRoute()]));
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
