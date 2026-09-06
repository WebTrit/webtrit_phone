import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class ChatConversationsTile extends StatefulWidget {
  const ChatConversationsTile({required this.conversation, required this.lastMessage, required this.userId, super.key});

  final Chat conversation;
  final ChatMessage? lastMessage;
  final String userId;

  @override
  State<ChatConversationsTile> createState() => _ChatConversationsTileState();
}

class _ChatConversationsTileState extends State<ChatConversationsTile> {
  void onTap() {
    if (widget.conversation.type == ChatType.direct) {
      final userId = widget.userId;
      final participant = widget.conversation.members.firstWhere((m) => m.userId != userId);
      context.router.navigate(ChatConversationScreenPageRoute(participantId: participant.userId));
    } else {
      context.router.navigate(ChatConversationScreenPageRoute(chatId: widget.conversation.id));
    }
  }

  Future<bool> onDismiss(_) async {
    final conversation = widget.conversation;
    // The same swipe means two different things: the owner of a group and
    // anyone in a direct chat delete the conversation, everyone else only
    // leaves. The question has to say which one is about to happen.
    final leaving = conversation.type != ChatType.direct && !conversation.members.isGroupOwner(widget.userId);

    final confirmed = await ConfirmDialog.showDangerous(
      context,
      title: leaving
          ? context.l10n.messaging_LeaveGroupDialog_title
          : context.l10n.messaging_DeleteConversationDialog_title,
      content: leaving
          ? context.l10n.messaging_LeaveGroupDialog_content
          : context.l10n.messaging_DeleteConversationDialog_content,
    );
    if (confirmed != true) return false;
    if (!mounted) return false;

    final cubit = context.read<ChatConversationsCubit>();
    return leaving ? cubit.leaveGroup(conversation.id) : cubit.deleteConversation(conversation.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: Theme.of(context).cardColor.withValues(alpha: 0.1),
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
          child: switch (widget.conversation.type) {
            ChatType.direct => directContent(),
            ChatType.group => groupContent(),
          },
        ),
      ),
    );
  }

  Widget directContent() {
    final userId = widget.userId;
    final participant = widget.conversation.members.firstWhere((m) => m.userId != userId);
    final lastMessage = widget.lastMessage;

    return ContactInfoBuilder(
      source: ContactSourceId(ContactSourceType.external, participant.userId),
      builder: (context, contact) {
        final hybridPresenceSupport = PresenceViewParams.of(context).hybridPresenceSupport;
        final text = switch (contact) {
          null => context.l10n.messaging_ParticipantName_unknown,
          _ => switch (hybridPresenceSupport) {
            true => '${contact.displayTitle} ${contact.presenceInfo.primaryStatusIcon ?? ''}',
            false => contact.displayTitle,
          },
        };
        return ListTile(
          leading: LeadingAvatar(
            username: contact?.displayTitle,
            thumbnail: contact?.thumbnail,
            thumbnailUrl: contact?.thumbnailUrl,
            radius: 20,
            badge: AvatarStatusBadge.maybe(
              registered: contact?.registered,
              presenceInfo: contact?.presenceInfo,
              dialogInfo: contact?.dialogInfo,
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(text, style: const TextStyle(overflow: TextOverflow.ellipsis)),
              ),
              const SizedBox(width: 4),
              if (lastMessage != null) Text(lastMessage.createdAt.timeOrDate, style: const TextStyle(fontSize: 12)),
            ],
          ),
          subtitle: subtitle(),
          onTap: onTap,
        );
      },
    );
  }

  Widget groupContent() {
    final lastMessage = widget.lastMessage;
    return ListTile(
      leading: GroupAvatar(name: widget.conversation.name ?? widget.conversation.id.toString(), size: 20),
      title: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    widget.conversation.name ?? 'Chat ${widget.conversation.id}',
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                const SizedBox(width: 4),
                usersCount(),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (lastMessage != null) Text(lastMessage.createdAt.timeOrDate, style: const TextStyle(fontSize: 12)),
        ],
      ),
      subtitle: subtitle(),
      onTap: onTap,
    );
  }

  Widget usersCount() {
    final membersCount = widget.conversation.members.length;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.people, size: 12),
        const SizedBox(width: 4),
        Text('$membersCount', style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget subtitle() {
    final theme = Theme.of(context);
    final textStyle = TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 12,
      color: theme.textTheme.bodyMedium?.color,
      fontFamily: theme.textTheme.bodyMedium?.fontFamily,
    );
    final lastMessage = widget.lastMessage;

    return Row(
      children: [
        if (lastMessage != null)
          Expanded(
            child: Row(
              children: [
                if (widget.conversation.type == ChatType.group)
                  ParticipantName(
                    senderId: lastMessage.senderId,
                    userId: widget.userId,
                    style: textStyle,
                    textMap: (name) => '$name: ',
                  ),
                if (lastMessage.deletedAt != null)
                  Text(context.l10n.messaging_MessageView_deleted, style: textStyle, overflow: TextOverflow.ellipsis)
                else
                  Flexible(
                    child: ParsedText(
                      parse: TextMatchers.matchers(textStyle, theme.strongQuoteDecoration(true)),
                      regexOptions: const RegexOptions(multiLine: true, dotAll: true, caseSensitive: false),
                      style: textStyle,
                      text: lastMessage.content,
                      textWidthBasis: TextWidthBasis.longestLine,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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

            // The badge is silent by itself; the count is said here, on the
            // last thing the tile draws, so it lands after the name of the
            // conversation rather than inside it.
            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Semantics(
                label: context.l10n.common_SemanticsValue_unreadCount(count),
                child: CountBadge(count: count),
              ),
            );
          },
        ),
      ],
    );
  }
}
