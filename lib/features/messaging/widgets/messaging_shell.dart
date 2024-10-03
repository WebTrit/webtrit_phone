import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class MessagingShell extends StatefulWidget {
  const MessagingShell({required this.child, super.key});

  final Widget child;

  @override
  State<MessagingShell> createState() => _MessagingShellState();
}

class _MessagingShellState extends State<MessagingShell> {
  late final MessagingNotificationsService notificationsService;

  @override
  void initState() {
    super.initState();
    const chatsEnabled = EnvironmentConfig.CHAT_FEATURE_ENABLE;
    const smsEnabled = EnvironmentConfig.SMS_FEATURE_ENABLE;
    if (!chatsEnabled && !smsEnabled) return;

    notificationsService = MessagingNotificationsService(
      context.read<AppBloc>().state.userId!,
      context.read<ChatsRepository>(),
      context.read<SmsRepository>(),
      context.read<ContactsRepository>(),
      context.read<RemoteNotificationRepository>(),
      context.read<LocalNotificationRepository>(),
      context.read<MainScreenRouteStateRepository>(),
      context.read<MainShellRouteStateRepository>(),
      onOpenChatList,
      onOpenChat,
      onOpenConversation,
      onOpenSmsConversation,
    );

    notificationsService.init();
  }

  @override
  void dispose() {
    notificationsService.dispose();
    super.dispose();
  }

  onOpenConversation(participantId) {
    context.router.root.navigate(ConversationScreenPageRoute(participantId: participantId));
  }

  onOpenChat(chatId) {
    context.router.root.navigate(GroupScreenPageRoute(chatId: chatId));
  }

  onOpenSmsConversation(firstNumber, secondNumber) {
    context.router.root.navigate(SmsConversationScreenPageRoute(firstNumber: firstNumber, secondNumber: secondNumber));
  }

  onOpenChatList() {
    context.router.root.navigate(const MessagingRouterPageRoute());
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
