import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
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
  late final contactsRepository = context.read<ContactsRepository>();
  late final smsRepository = context.read<SmsRepository>();

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
    final result = await showModalBottomSheet(
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => BottomSheet(
        enableDrag: false,
        onClosing: () {},
        builder: (context) => NewChatConversation(contactsRepository: contactsRepository),
      ),
    );

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    // If the user selected a contact, navigate to the new conversation screen
    if (result is Contact) {
      context.router.navigate(MessagingRouterPageRoute(
        children: [
          const ConversationsScreenPageRoute(),
          ConversationScreenPageRoute(participantId: result.sourceId),
        ],
      ));
    }

    // If the user selected the group option, navigate to the group builder screen
    if (result == kGroupResult) {
      showModalBottomSheet(
        useRootNavigator: true,
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => BottomSheet(
          enableDrag: false,
          onClosing: () {},
          builder: (context) => NewGroupConversation(
            contactsRepository: contactsRepository,
            messagingBloc: messagingBloc,
          ),
        ),
      );
    }
  }

  onNewSmsConversation() async {
    final result = await showModalBottomSheet(
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => BottomSheet(
        enableDrag: false,
        onClosing: () {},
        builder: (context) => NewSmsConversation(contactsRepository: contactsRepository),
      ),
    );

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    // If the user selected a phone number, navigate to the sms screen
    if (result is (String, String?)) {
      final (number, recipientId) = result;
      final userNumbers = await smsRepository.getUserSmsNumbers();

      if (!mounted) return;

      if (userNumbers.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(context.l10n.messaging_ConversationsScreen_noNumberAlert_title),
            content: Text(context.l10n.messaging_ConversationsScreen_noNumberAlert_text),
            actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
          ),
        );
        return;
      }
      String userNumber;
      if (userNumbers.length > 1) {
        final result = await showModalBottomSheet(
          context: context,
          builder: (context) => Column(
            children: [
              ListTile(
                title: Text(
                  context.l10n.messaging_ConversationsScreen_selectNumberSheet_title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ...userNumbers.map((number) {
                return ListTile(
                  title: Text(number),
                  onTap: () => Navigator.of(context).pop(number),
                );
              }),
            ],
          ),
        );

        if (result == null) return;
        userNumber = result;
      } else {
        userNumber = userNumbers.first;
      }

      if (!mounted) return;

      context.router.navigate(MessagingRouterPageRoute(
        children: [
          const ConversationsScreenPageRoute(),
          SmsConversationScreenPageRoute(firstNumber: userNumber, secondNumber: number, recipientId: recipientId),
        ],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: MainAppBar(title: widget.title),
      body: Column(
        children: [
          if (chatsEnabled && smsEnabled) ...[
            const SizedBox(height: 10),
            tabButtons(colorScheme),
            const SizedBox(height: 10),
            Expanded(child: ConversationsList(tabType: tabType)),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme.primary,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
        onPressed: onFloatingButton,
        child: Icon(Icons.add, color: colorScheme.onPrimary),
      ),
    );
  }

  Widget tabButtons(ColorScheme colorScheme) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primary,
        border: Border.all(color: colorScheme.secondaryFixedDim),
        borderRadius: BorderRadius.circular(9),
      ),
      child: BlocBuilder<UnreadCountCubit, UnreadCountState>(
        builder: (context, state) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                decoration: BoxDecoration(
                  color: tabType == TabType.chat ? colorScheme.primary : colorScheme.surfaceBright,
                  borderRadius: BorderRadius.circular(8),
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => setState(() => tabType = TabType.chat),
                    child: SizedBox(
                      width: _computeTabTittleWidth(context) + 40,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context.l10n.messaging_ConversationsScreen_messages_title,
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: tabType == TabType.chat ? colorScheme.onPrimary : colorScheme.onSurface,
                            ),
                          ),
                          if (state.chatsWithUnreadCount > 0) ...[
                            const SizedBox(width: 4),
                            Container(
                              width: 14,
                              height: 14,
                              padding: const EdgeInsets.symmetric(horizontal: 1),
                              decoration: BoxDecoration(
                                color: tabType == TabType.chat ? colorScheme.onPrimary : colorScheme.onSurface,
                                shape: BoxShape.circle,
                              ),
                              child: FittedBox(
                                child: Text(
                                  state.chatsWithUnreadCount.toString(),
                                  style: TextStyle(
                                    color: tabType == TabType.chat ? colorScheme.onSurface : colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                decoration: BoxDecoration(
                  color: tabType == TabType.sms ? colorScheme.primary : colorScheme.surfaceBright,
                  borderRadius: BorderRadius.circular(8),
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => setState(() => tabType = TabType.sms),
                    child: SizedBox(
                      width: _computeTabTittleWidth(context) + 40,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context.l10n.messaging_ConversationsScreen_smses_title,
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: tabType == TabType.sms ? colorScheme.onPrimary : colorScheme.onSurface,
                            ),
                          ),
                          if (state.smsConversationsWithUnreadCount > 0) ...[
                            const SizedBox(width: 4),
                            Container(
                              width: 14,
                              height: 14,
                              padding: const EdgeInsets.symmetric(horizontal: 1),
                              decoration: BoxDecoration(
                                color: tabType == TabType.sms ? colorScheme.onPrimary : colorScheme.onSurface,
                                shape: BoxShape.circle,
                              ),
                              child: FittedBox(
                                child: Text(
                                  state.smsConversationsWithUnreadCount.toString(),
                                  style: TextStyle(
                                    color: tabType == TabType.sms ? colorScheme.onSurface : colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

double _computeTabTittleWidth(BuildContext context) {
  final theme = Theme.of(context);
  final chatsText = context.l10n.messaging_ConversationsScreen_messages_title;
  final smsText = context.l10n.messaging_ConversationsScreen_smses_title;
  final longerText = chatsText.length > smsText.length ? chatsText : smsText;

  final painter = TextPainter(
    text: TextSpan(text: longerText, style: theme.textTheme.bodyMedium!),
    textDirection: TextDirection.ltr,
  )..layout();

  return painter.width;
}
