// ignore_for_file: unused_import

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

// TODO: localizations

class SmsConversationsTile extends StatefulWidget {
  const SmsConversationsTile({required this.conversation, required this.lastMessage, required this.userId, super.key});

  final SmsConversation conversation;
  final SmsMessage? lastMessage;
  final String userId;

  @override
  State<SmsConversationsTile> createState() => _SmsConversationsTileState();
}

class _SmsConversationsTileState extends State<SmsConversationsTile> {
  onTap() {
    context.router.navigate(MessagingRouterPageRoute(
      children: [
        const ConversationsScreenPageRoute(),
        SmsConversationScreenPageRoute(
          firstNumber: widget.conversation.firstPhoneNumber,
          secondNumber: widget.conversation.secondPhoneNumber,
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: UserSmsNumbersBuilder(builder: (context, List<String> numbers, {required loading}) {
        final firstNumber = widget.conversation.firstPhoneNumber;
        final secondNumber = widget.conversation.secondPhoneNumber;
        String? userNumber;
        userNumber = numbers.firstWhereOrNull((e) => e == firstNumber || e == secondNumber);
        String? recipientNumber;
        if (userNumber != null) recipientNumber = firstNumber == userNumber ? secondNumber : firstNumber;

        return ListTile(
          leading: leading(recipientNumber),
          title: title(recipientNumber),
          subtitle: subtitle(userNumber),
          onTap: onTap,
        );
      }),
    );
  }

  Widget leading(String? recipientNumber) {
    final text = recipientNumber?.substring(recipientNumber.length - 2) ?? '';
    return LeadingAvatar(username: text, radius: 24);
  }

  Widget title(String? recipientNumber) {
    final lastMessage = widget.lastMessage;

    return Row(
      children: [
        Expanded(child: Text(recipientNumber ?? '', style: const TextStyle(overflow: TextOverflow.ellipsis))),
        const SizedBox(width: 4),
        if (lastMessage != null) Text(lastMessage.createdAt.timeOrDate, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget subtitle(String? userNumber) {
    const textStyle = TextStyle(overflow: TextOverflow.ellipsis, fontSize: 12);
    final lastMessage = widget.lastMessage;

    return Row(
      children: [
        if (lastMessage != null)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lastMessage.fromPhoneNumber == userNumber ? 'you' : lastMessage.fromPhoneNumber,
                  style: textStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  lastMessage.content,
                  style: textStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        else
          Expanded(
            child: FadeIn(
              child: Text(context.l10n.chats_ChatListItem_empty, style: textStyle),
            ),
          ),
      ],
    );
  }
}
