import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/chats/chats.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

// TODO: get last message from list cubit state after refactoring

class ChatListItem extends StatefulWidget {
  const ChatListItem({required this.chat, required this.userId, super.key});

  final Chat chat;
  final String userId;

  @override
  State<ChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  late final chatsRepository = context.read<ChatsRepository>();
  StreamSubscription? updatesSub;

  ChatMessage? lastMessage;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await loadLastMessage();

    if (!mounted) return;

    updatesSub = chatsRepository.eventBus.listen((event) {
      if (event is ChatMessageUpdate && event.message.chatId == widget.chat.id) {
        final message = event.message;
        // Be sure to use >= to handle edit of the last message
        if (message.createdAt.microsecondsSinceEpoch >= (lastMessage?.createdAt.microsecondsSinceEpoch ?? 0)) {
          if (mounted) setState(() => lastMessage = message);
        }
      }
    });
  }

  Future loadLastMessage() async {
    final lastMessages = await chatsRepository.getMessageHistory(widget.chat.id, limit: 1);
    if (!mounted) return;
    if (lastMessages.isNotEmpty) setState(() => lastMessage = lastMessages.first);
  }

  @override
  void dispose() {
    updatesSub?.cancel();
    super.dispose();
  }

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
        color: Theme.of(context).cardColor,
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
      return CircleAvatar(
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ContactInfoBuilder(
              sourceType: ContactSourceType.external,
              sourceId: participant.userId,
              builder: (context, contact, {required bool loading}) {
                if (loading) return const SizedBox();

                const textStyle = TextStyle(overflow: TextOverflow.ellipsis);
                if (contact != null) {
                  var text = contact.name.split(' ').first;
                  if (text.length > 16) text = text.substring(0, 16);
                  return FadeIn(child: Text(text, style: textStyle));
                } else {
                  return FadeIn(child: Text(participant.userId, style: textStyle));
                }
              },
            ),
          ),
        ),
      );
    } else {
      var text = widget.chat.name?.split(' ').first ?? widget.chat.id.toString();
      if (text.length > 16) text = text.substring(0, 16);
      return CircleAvatar(
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text.toUpperCase(),
              softWrap: true,
            ),
          ),
        ),
      );
    }
  }

  Widget title() {
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
          const Icon(Icons.person, size: 12),
          const SizedBox(width: 4),
        ],
      );
    } else {
      final name = widget.chat.name ?? 'Chat ${widget.chat.id}';
      return Row(
        children: [
          Expanded(child: Text(name, style: const TextStyle(overflow: TextOverflow.ellipsis))),
          const SizedBox(width: 4),
          usersCount(),
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
    final lastMessage = this.lastMessage;

    return Row(
      children: [
        if (lastMessage != null)
          Expanded(
            child: ParticipantName(
              senderId: lastMessage.senderId,
              userId: widget.userId,
              style: textStyle,
              textMap: (name) => '$name: ${lastMessage.content}',
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
                color: Theme.of(context).primaryColor,
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
