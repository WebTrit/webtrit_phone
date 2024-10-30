import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/leading_avatar.dart';

class ChatConversationsTile extends StatefulWidget {
  const ChatConversationsTile({required this.conversation, required this.lastMessage, required this.userId, super.key});

  final Chat conversation;
  final ChatMessage? lastMessage;
  final String userId;

  @override
  State<ChatConversationsTile> createState() => _ChatConversationsTileState();
}

class _ChatConversationsTileState extends State<ChatConversationsTile> {
  onTap() {
    if (widget.conversation.type == ChatType.direct) {
      final userId = widget.userId;
      final participant = widget.conversation.members.firstWhere((m) => m.userId != userId);
      context.router.navigate(ChatConversationScreenPageRoute(participantId: participant.userId));
    } else {
      context.router.navigate(ChatConversationScreenPageRoute(chatId: widget.conversation.id));
    }
  }

  Future<bool> onDismiss(_) async {
    final conformation = await showDialog(context: context, builder: (_) => const ConfirmDialog());
    if (conformation != true) return false;
    if (!mounted) return false;

    final conversation = widget.conversation;
    if (conversation.type == ChatType.direct) {
      return context.read<ChatConversationsCubit>().deleteConversation(conversation.id);
    } else {
      if (conversation.members.isGroupOwner(widget.userId)) {
        return context.read<ChatConversationsCubit>().deleteConversation(conversation.id);
      } else {
        return context.read<ChatConversationsCubit>().leaveGroup(conversation.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: Dismissible(
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
            leading: leading(),
            title: title(),
            subtitle: subtitle(),
            onTap: onTap,
          ),
        ),
      ),
    );
  }

  Widget leading() {
    if (widget.conversation.type == ChatType.direct) {
      final userId = widget.userId;
      final participant = widget.conversation.members.firstWhere((m) => m.userId != userId);
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
      var text = widget.conversation.name ?? widget.conversation.id.toString();
      return GroupAvatar(name: text);
    }
  }

  Widget title() {
    final lastMessage = widget.lastMessage;

    if (widget.conversation.type == ChatType.direct) {
      final userId = widget.userId;
      final participant = widget.conversation.members.firstWhere((m) => m.userId != userId);
      return Row(
        children: [
          Expanded(
            child: ParticipantName(
              senderId: participant.userId,
              userId: userId,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
          const SizedBox(width: 4),
          if (lastMessage != null) Text(lastMessage.createdAt.timeOrDate, style: const TextStyle(fontSize: 12)),
        ],
      );
    } else {
      final name = widget.conversation.name ?? 'Chat ${widget.conversation.id}';
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
    final membersCount = widget.conversation.members.length;
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
          Expanded(child: Text(context.l10n.messaging_Conversations_tile_empty, style: textStyle)),
        BlocBuilder<UnreadCountCubit, UnreadCountState>(
          builder: (context, state) {
            final count = state.unreadCountForChatConversation(widget.conversation.id);
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
