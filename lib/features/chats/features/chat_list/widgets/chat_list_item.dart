import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/chats/widgets/widgets.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class ChatListItem extends StatefulWidget {
  const ChatListItem({required this.chat, required this.userId, super.key});

  final Chat chat;
  final String userId;

  @override
  State<ChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  late final chatsRepository = context.read<ChatsRepository>();

  ChatMessage? lastMessage;
  StreamSubscription? _lastMsgSub;

  int unreadMsgsCount = 0;
  StreamSubscription? _unreadMsgsSub;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final lastMessages = await chatsRepository.getMessageHistory(widget.chat.id, limit: 1);
    if (!mounted) return;
    if (lastMessages.isNotEmpty) setState(() => lastMessage = lastMessages.first);

    _lastMsgSub = chatsRepository.eventBus
        .whereType<ChatMessageUpdate>()
        .where((event) => event.message.chatId == widget.chat.id)
        .listen((event) {
      // Be sure to use >= to handle edit of the last message
      if (event.message.createdAt.microsecondsSinceEpoch >= (lastMessage?.createdAt.microsecondsSinceEpoch ?? 0)) {
        setState(() => lastMessage = event.message);
      }
    });

    _unreadMsgsSub = chatsRepository.unreadMessagesCount(widget.chat.id, widget.userId).listen((count) {
      if (count != unreadMsgsCount) {
        setState(() => unreadMsgsCount = count);
      }
    });
  }

  @override
  void dispose() {
    _lastMsgSub?.cancel();
    _unreadMsgsSub?.cancel();
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
              builder: (context, contact) {
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
              builder: (context, contact) {
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
        if (lastMessage != null) ...[
          Flexible(
            child: ParticipantName(
              senderId: lastMessage.senderId,
              userId: widget.userId,
              style: textStyle,
              textMap: (t) => '$t: ',
            ),
          ),
          Expanded(child: FadeIn(child: Text(lastMessage.content, style: textStyle)))
        ],
        if (lastMessage == null) Expanded(child: Text(context.l10n.chats_ChatListItem_empty, style: textStyle)),
        if (unreadMsgsCount > 0) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$unreadMsgsCount',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ]
      ],
    );
  }
}
