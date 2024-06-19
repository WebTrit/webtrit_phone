import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/chat/components/chats_event.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class ChatListItem extends StatefulWidget {
  const ChatListItem({required this.chat, required this.userId, super.key});

  final Chat chat;
  final String? userId;

  @override
  State<ChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  late final localChatRepository = context.read<LocalChatRepository>();

  ChatMessage? lastMessage;
  late final StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final lastMessages = await localChatRepository.getLastMessages(widget.chat.id, limit: 1);
    if (!mounted) return;
    if (lastMessages.isNotEmpty) setState(() => lastMessage = lastMessages.first);

    _sub = localChatRepository.eventBus
        .whereType<ChatMessageUpdate>()
        .where((event) => event.message.chatId == widget.chat.id)
        .listen((event) {
      // Be sure to use >= to handle edit of the last message
      if (event.message.createdAt.microsecondsSinceEpoch >= (lastMessage?.createdAt.microsecondsSinceEpoch ?? 0)) {
        setState(() => lastMessage = event.message);
      }
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  // onTap() {
  //   context.router.navigate(ChatsRouterPageRoute(children: [
  //     const ChatListScreenPageRoute(),
  //     ConversationScreenPageRoute(participantId: recent.number),
  //   ]));
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        title: title(),
        subtitle: subtitle(),
        trailing: trail(),
        onTap: () {
          if (widget.chat.type == ChatType.dialog) {
            final userId = widget.userId;
            final participant = widget.chat.members.firstWhere((m) => m.userId != userId);
            context.router.navigate(ChatsRouterPageRoute(children: [
              const ChatListScreenPageRoute(),
              ConversationScreenPageRoute(participantId: participant.userId),
            ]));
          } else {
            // TODO: group screen
          }
        },
      ),
    );
  }

  Widget title() {
    if (widget.chat.type == ChatType.dialog) {
      final userId = widget.userId;
      final participant = widget.chat.members.firstWhere((m) => m.userId != userId);
      return Text(participant.userId, style: const TextStyle(overflow: TextOverflow.ellipsis));
    } else {
      final name = widget.chat.name ?? 'Chat ${widget.chat.id}';
      return Text(name, style: const TextStyle(overflow: TextOverflow.ellipsis));
    }
  }

  Widget trail() {
    final membersCount = widget.chat.members.length;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [const Icon(Icons.people, size: 16), const SizedBox(width: 8), Text('$membersCount')],
    );
  }

  Widget subtitle() {
    String text = '';
    if (lastMessage != null) {
      bool isOwn = lastMessage!.senderId == widget.userId;
      if (isOwn) {
        text = 'You: ${lastMessage!.content}';
      } else {
        text = '${lastMessage!.senderId}: ${lastMessage!.content}';
      }
    } else {
      text = 'No messages yet';
    }
    return Text(text, style: const TextStyle(overflow: TextOverflow.ellipsis));
  }
}
