import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

enum TabType { chat, sms }

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key, this.title});
  final Widget? title;

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  late final messagingBloc = context.read<MessagingBloc>();
  late final chatsRepository = context.read<ChatsRepository>();
  late final smsRepository = context.read<SmsRepository>();
  late final contactsRepository = context.read<ContactsRepository>();
  late final notificationsBloc = context.read<NotificationsBloc>();

  final chatsEnabled = EnvironmentConfig.CHAT_FEATURE_ENABLE;
  final smsEnabled = EnvironmentConfig.SMS_FEATURE_ENABLE;

  late TabType tabType = chatsEnabled ? TabType.chat : TabType.sms;

  onFloatingButton() {
    if (tabType == TabType.chat) {
      onNewChatConversation();
    }
    if (tabType == TabType.sms) {
      onNewSmsConversation();
    }
  }

  onNewChatConversation() async {
    showModalBottomSheet(
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => ChatConversationBuilderCubit(
          messagingBloc.state.client,
          chatsRepository,
          contactsRepository,
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
        child: BottomSheet(enableDrag: false, onClosing: () {}, builder: (_) => const ChatConversationBuilderView()),
      ),
    );
  }

  onNewSmsConversation() async {
    showModalBottomSheet(
      useRootNavigator: true,
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
        child: BottomSheet(enableDrag: false, onClosing: () {}, builder: (_) => const SmsConversationBuilderView()),
      ),
    );
  }

  openDialog(Contact contact) {
    if (!mounted) return;
    context.router.navigate(ChatConversationScreenPageRoute(participantId: contact.sourceId));
  }

  openGroup(int id) {
    if (!mounted) return;
    context.router.navigate(ChatConversationScreenPageRoute(chatId: id));
  }

  openSmsDialog(String userNumber, String recipientNumber, String? recipientId) async {
    if (!mounted) return;
    context.router.navigate(
      SmsConversationScreenPageRoute(
        firstNumber: userNumber,
        secondNumber: recipientNumber,
        recipientId: recipientId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: MainAppBar(title: widget.title),
      body: MessagingStateWrapper(
        child: Column(
          children: [
            const SizedBox(height: 10),
            if (chatsEnabled && smsEnabled) ...[
              TabButtonsBar(tabType, onChange: (t) => setState(() => tabType = t)),
              const SizedBox(height: 10),
            ],
            Expanded(child: ConversationsList(tabType: tabType)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme.primary,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
        onPressed: onFloatingButton,
        child: Icon(Icons.add, color: colorScheme.onPrimary),
      ),
    );
  }
}
