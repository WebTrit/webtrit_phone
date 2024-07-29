import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:intl/intl.dart';
import 'package:quiver/collection.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class MessageView extends StatefulWidget {
  const MessageView({
    super.key,
    required this.userId,
    required this.message,
    required this.messageWidth,
    required this.showName,
    required this.handleSetForReply,
    required this.handleSetForForward,
    required this.handleSetForEdit,
    required this.handleDelete,
  });

  final String userId;
  final types.TextMessage message;
  final int messageWidth;
  final bool showName;

  final Function(ChatMessage refMessage) handleSetForReply;
  final Function(ChatMessage refMessage) handleSetForForward;
  final Function(ChatMessage refMessage) handleSetForEdit;
  final Function(ChatMessage refMessage) handleDelete;

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  late final chatsRepository = context.read<ChatsRepository>();
  late final client = context.read<ChatsBloc>().state.client;
  final widgetKey = GlobalKey();

  static final previewsCache = LruMap<int, types.PreviewData>(maximumSize: 500);

  void handlePreviewDataFetched(types.TextMessage message, types.PreviewData previewData) {
    setState(() => previewsCache[message.text.hashCode] = previewData);
  }

  types.TextMessage messageWithPreview(types.TextMessage message) {
    if (previewsCache.containsKey(message.text.hashCode)) {
      return message.copyWith(previewData: previewsCache[message.text.hashCode]) as types.TextMessage;
    }
    return message;
  }

  Future<ChatMessage?> fetchMessage(int msgId, int chatId) async {
    final msg = await chatsRepository.getMessageById(msgId);
    if (msg != null) return msg;

    final channel = client.getChatChannel(chatId);
    if (channel == null) return null;

    final req = await channel.push('message:get:$msgId', {}).future;
    if (req.isOk) {
      final msg = ChatMessage.fromMap(req.response);
      await chatsRepository.upsertMessage(msg, silent: true);
      return msg;
    }

    return null;
  }

  RelativeRect getRelativeRect(GlobalKey key) {
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    late Offset offset = const Offset(5, 0);
    return RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(offset, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero) + offset, ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    ChatMessage? realMessage;
    if (widget.message.metadata != null && widget.message.metadata!.containsKey('message')) {
      realMessage = widget.message.metadata!['message'] as ChatMessage;
    }

    final isEdited = widget.message.metadata != null && widget.message.metadata!['edited'] == true;
    final isDeleted = widget.message.metadata != null && widget.message.metadata!['deleted'] == true;
    final isSended = realMessage?.id != null;
    final isMine = realMessage == null || realMessage.senderId == widget.userId;
    final isForward = realMessage?.forwardFromId != null && realMessage?.authorId != null;
    final isReply = realMessage?.replyToId != null;
    final isViewed = realMessage?.viewedAt != null;

    final senderId = realMessage?.senderId ?? widget.userId;

    if (isDeleted) {}

    return GestureDetector(
      onLongPress: () {
        showMenu(
          context: context,
          position: getRelativeRect(widgetKey),
          items: [
            if (isSended && !isDeleted)
              MessageMenuItem(
                text: 'Reply',
                icon: const Icon(Icons.reply),
                onTap: () => widget.handleSetForReply(realMessage!),
              ),
            if (isSended && !isDeleted)
              MessageMenuItem(
                text: 'Forward',
                icon: const Icon(Icons.forward),
                onTap: () => widget.handleSetForForward(realMessage!),
              ),
            if (isMine && isSended && !isForward && !isDeleted)
              MessageMenuItem(
                text: 'Edit',
                icon: const Icon(Icons.edit),
                onTap: () => widget.handleSetForEdit(realMessage!),
              ),
            if (isMine && isSended && !isDeleted)
              MessageMenuItem(
                text: 'Delete',
                icon: const Icon(Icons.remove),
                onTap: () => widget.handleDelete(realMessage!),
              ),
          ],
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        key: widgetKey,
        color: !isViewed ? Colors.blueGrey.withOpacity(0.4) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isReply) ...[
              replyQuote(realMessage!),
              const SizedBox(height: 8),
            ],
            if (isForward) ...[
              forwardQuote(realMessage!),
              const SizedBox(height: 8),
              ParticipantName(senderId: senderId, userId: widget.userId),
              const Text('[forwarded]', style: TextStyle(color: Colors.white, fontSize: 12)),
            ],
            if (!isForward && !isDeleted)
              TextMessage(
                emojiEnlargementBehavior: EmojiEnlargementBehavior.single,
                hideBackgroundOnEmojiMessages: false,
                message: messageWithPreview(widget.message),
                showName: true,
                usePreviewData: true,
                onPreviewDataFetched: handlePreviewDataFetched,
                options: const TextMessageOptions(isTextSelectable: false),
                nameBuilder: (user) => ParticipantName(senderId: user.id, userId: widget.userId),
              ),
            if (isEdited && !isDeleted) ...[
              const Text('[edited]', style: TextStyle(color: Colors.white, fontSize: 12)),
            ],
            if (isMine && (realMessage?.viaSms ?? false) && !isDeleted) ...[
              const Text('[sms]', style: TextStyle(color: Colors.white, fontSize: 12)),
              if (realMessage?.smsOutState != null)
                Text('[${realMessage?.smsOutState?.name}]', style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
            if (isDeleted) ...[
              ParticipantName(senderId: senderId, userId: widget.userId),
              const Text('[deleted]', style: TextStyle(color: Colors.white, fontSize: 12)),
            ],
            if (realMessage?.viewedAt != null && isMine) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.remove_red_eye_outlined, color: Colors.blue[200], size: 10),
                  const SizedBox(width: 4),
                  if (realMessage?.viewedAt != null)
                    Text(
                      DateFormat('HH:mm').format(realMessage!.viewedAt!),
                      style: TextStyle(color: Colors.blue[200], fontSize: 10),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget replyQuote(ChatMessage realMessage) {
    return FutureBuilder(
        future: fetchMessage(realMessage.replyToId!, realMessage.chatId),
        builder: (context, snapshot) {
          final msg = snapshot.data;

          final textMessage = types.TextMessage(
            author: types.User(id: msg?.senderId ?? '-1', firstName: msg?.senderId ?? 'loading...'),
            id: msg?.idKey ?? '-1',
            remoteId: msg?.id.toString(),
            text: msg?.content ?? 'loading...',
            showStatus: false,
            createdAt: msg?.createdAt.millisecondsSinceEpoch,
          );

          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 32,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: TextMessage(
              emojiEnlargementBehavior: EmojiEnlargementBehavior.single,
              hideBackgroundOnEmojiMessages: false,
              message: messageWithPreview(textMessage),
              showName: true,
              usePreviewData: true,
              onPreviewDataFetched: handlePreviewDataFetched,
              options: const TextMessageOptions(isTextSelectable: false),
              nameBuilder: (user) => ParticipantName(senderId: user.id, userId: widget.userId),
            ),
          );
        });
  }

  Widget forwardQuote(ChatMessage msg) {
    final textMessage = types.TextMessage(
      author: types.User(id: msg.authorId!, firstName: msg.authorId),
      id: msg.idKey,
      remoteId: msg.id.toString(),
      text: msg.content,
      showStatus: false,
      createdAt: msg.createdAt.millisecondsSinceEpoch,
    );

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 32,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextMessage(
        emojiEnlargementBehavior: EmojiEnlargementBehavior.single,
        hideBackgroundOnEmojiMessages: false,
        message: messageWithPreview(textMessage),
        showName: true,
        usePreviewData: true,
        onPreviewDataFetched: handlePreviewDataFetched,
        options: const TextMessageOptions(isTextSelectable: false),
        nameBuilder: (user) => ParticipantName(senderId: user.id, userId: widget.userId),
      ),
    );
  }
}

class MessageMenuItem extends PopupMenuItem {
  MessageMenuItem({
    super.key,
    super.value,
    super.onTap,
    super.enabled = true,
    super.textStyle,
    required String text,
    required Widget icon,
  }) : super(
          child: Row(
            children: [
              Padding(padding: const EdgeInsets.all(8), child: icon),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: Text(text)),
            ],
          ),
          height: 0,
          padding: EdgeInsets.zero,
        );
}
