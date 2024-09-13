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
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: leading(),
        title: title(),
        subtitle: subtitle(),
        onTap: onTap,
      ),
    );
  }

  Widget leading() {
    return const LeadingAvatar(
      username: 'SMS',
      radius: 24,
    );
  }

  Widget title() {
    final lastMessage = widget.lastMessage;
    final firstPhoneNumber = widget.conversation.firstPhoneNumber;
    final secondPhoneNumber = widget.conversation.secondPhoneNumber;

    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(firstPhoneNumber, style: const TextStyle(overflow: TextOverflow.ellipsis)),
              Text(secondPhoneNumber, style: const TextStyle(overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
        const SizedBox(width: 4),
        if (lastMessage != null) Text(lastMessage.createdAt.timeOrDate, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget subtitle() {
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
                  lastMessage.fromPhoneNumber,
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
