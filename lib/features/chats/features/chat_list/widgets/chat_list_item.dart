import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/chats/chats.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class ChatListItem extends StatefulWidget {
  const ChatListItem({required this.chat, required this.lastMessage, required this.userId, super.key});

  final Chat chat;
  final ChatMessage? lastMessage;
  final String userId;

  @override
  State<ChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  onTap() {
    if (widget.chat.type == ChatType.dialog) {
      final userId = widget.userId;
      final participant = widget.chat.members.firstWhere((m) => m.userId != userId);
      context.router.navigate(ChatsRouterPageRoute(children: [
        const ChatListScreenPageRoute(),
        ConversationScreenPageRoute(participantId: participant.userId),
      ]));
    } else {
      context.router.navigate(ChatsRouterPageRoute(children: [
        const ChatListScreenPageRoute(),
        GroupScreenPageRoute(chatId: widget.chat.id),
      ]));
    }
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
    if (widget.chat.type == ChatType.dialog) {
      final userId = widget.userId;
      final participant = widget.chat.members.firstWhere((m) => m.userId != userId);
      return ContactInfoBuilder(
        sourceType: ContactSourceType.external,
        sourceId: participant.userId,
        builder: (context, contact, {required bool loading}) {
          return LeadingAvatar(
            username: contact?.name,
            thumbnail: contact?.thumbnail,
            thumbnailUrl: contact?.thumbnailUrl,
            registered: contact?.registered,
            radius: 24,
          );
        },
      );
    } else {
      var text = widget.chat.name?.split(' ').first ?? widget.chat.id.toString();
      if (text.length > 16) text = text.substring(0, 16);
      return LeadingAvatar(
        username: widget.chat.name ?? 'Chat ${widget.chat.id}',
        radius: 24,
      );
    }
  }

  Widget title() {
    final lastMessage = widget.lastMessage;

    if (widget.chat.type == ChatType.dialog) {
      final userId = widget.userId;
      final participant = widget.chat.members.firstWhere((m) => m.userId != userId);
      return Row(
        children: [
          Expanded(
            child: ContactInfoBuilder(
              sourceType: ContactSourceType.external,
              sourceId: participant.userId,
              builder: (context, contact, {required bool loading}) {
                if (loading) return const SizedBox();

                const textStyle = TextStyle(overflow: TextOverflow.ellipsis);
                if (contact != null) {
                  return FadeIn(child: Text(contact.name, style: textStyle));
                } else {
                  return FadeIn(child: Text(participant.userId, style: textStyle));
                }
              },
            ),
          ),
          const SizedBox(width: 4),
          if (lastMessage != null) Text(lastMessage.createdAt.timeOrDate, style: const TextStyle(fontSize: 12)),
        ],
      );
    } else {
      final name = widget.chat.name ?? 'Chat ${widget.chat.id}';
      return Row(
        children: [
          Expanded(child: Text(name, style: const TextStyle(overflow: TextOverflow.ellipsis))),
          const SizedBox(width: 4),
          if (lastMessage != null) Text(lastMessage.createdAt.timeOrDate, style: const TextStyle(fontSize: 12)),
        ],
      );
    }
  }

  Widget usersCount() {
    final membersCount = widget.chat.members.length;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.people, size: 12),
        const SizedBox(width: 4),
        Text('$membersCount', style: const TextStyle(fontSize: 12))
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
                ParticipantName(
                  senderId: lastMessage.senderId,
                  userId: widget.userId,
                  style: textStyle,
                  textMap: (name) => '$name:',
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
        BlocBuilder<UnreadCountCubit, UnreadCountState>(
          builder: (context, state) {
            final count = state.unreadCountForChat(widget.chat.id);
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
