// ignore_for_file: unused_import

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/leading_avatar.dart';

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
    context.router.navigate(
      SmsConversationScreenPageRoute(
        firstNumber: widget.conversation.firstPhoneNumber,
        secondNumber: widget.conversation.secondPhoneNumber,
      ),
    );
  }

  Future<bool> onDismiss(_) async {
    final conformation = await showDialog(context: context, builder: (_) => const ConfirmDialog());
    if (conformation != true) return false;
    if (!mounted) return false;
    return context.read<SmsConversationsCubit>().deleteConversation(widget.conversation.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: UserSmsNumbersBuilder(builder: (context, List<String> numbers, {required loading}) {
          final firstNumber = widget.conversation.firstPhoneNumber;
          final secondNumber = widget.conversation.secondPhoneNumber;
          String? userNumber;
          userNumber = numbers.firstWhereOrNull((e) => e == firstNumber || e == secondNumber);
          String? recipientNumber;
          if (userNumber != null) recipientNumber = firstNumber == userNumber ? secondNumber : firstNumber;

          return Dismissible(
            key: ValueKey(widget.conversation),
            direction: DismissDirection.endToStart,
            crossAxisEndOffset: 0.5,
            dismissThresholds: const {DismissDirection.endToStart: 0.6},
            background: Container(
              color: Colors.red,
              transform: Matrix4.translationValues(MediaQuery.of(context).size.width * 0.4, 0, 0),
              child: const Icon(Icons.delete_forever, color: Colors.white),
            ),
            confirmDismiss: onDismiss,
            child: ListTile(
              leading: leading(recipientNumber),
              title: title(recipientNumber),
              subtitle: subtitle(userNumber),
              onTap: onTap,
            ),
          );
        }),
      ),
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
                  lastMessage.fromPhoneNumber == userNumber
                      ? context.l10n.messaging_Conversations_tile_you
                      : lastMessage.fromPhoneNumber,
                  style: textStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                if (lastMessage.deletedAt != null)
                  Text(
                    context.l10n.messaging_MessageView_deleted,
                    style: textStyle,
                    overflow: TextOverflow.ellipsis,
                  )
                else
                  Text(
                    lastMessage.content,
                    style: textStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          )
        else
          Expanded(child: Text(context.l10n.messaging_Conversations_tile_empty, style: textStyle)),
        BlocBuilder<UnreadCountCubit, UnreadCountState>(
          builder: (context, state) {
            final count = state.unreadCountForSmsConversation(widget.conversation.id);
            if (count == 0) return const SizedBox();

            return Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$count',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            );
          },
        ),
      ],
    );
  }
}
