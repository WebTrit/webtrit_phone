import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:logging/logging.dart';
import 'package:webtrit_phone/features/call/widgets/popup_menu.dart';
import 'package:webtrit_phone/features/chats/chats.dart';
import 'package:webtrit_phone/models/models.dart';

final _logger = Logger('MessageListView');

class MessageListView extends StatefulWidget {
  const MessageListView({
    required this.userId,
    required this.messages,
    required this.fetchingHistory,
    required this.outboxQueue,
    required this.historyEndReached,
    required this.onSendMessage,
    required this.onSendReply,
    required this.onSendForward,
    required this.onSendEdit,
    required this.onDelete,
    required this.onFetchHistory,
    super.key,
  });

  final String userId;
  final List<ChatMessage> messages;
  final List<ChatQueueEntry> outboxQueue;
  final bool fetchingHistory;
  final bool historyEndReached;
  final Function(String content) onSendMessage;
  final Function(String content, ChatMessage refMessage) onSendReply;
  final Function(String content, ChatMessage refMessage) onSendForward;
  final Function(String content, ChatMessage refMessage) onSendEdit;
  final Function(ChatMessage refMessage) onDelete;
  final Future Function() onFetchHistory;

  @override
  State<MessageListView> createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  late final messageForwardCubit = context.read<MessageForwardCubit>();
  late final user = types.User(id: widget.userId);
  final Map<String, types.PreviewData> previews = {};
  List<types.TextMessage> messages = [];
  ChatMessage? editingMessage;
  ChatMessage? replyingMessage;

  @override
  void initState() {
    super.initState();
    mapMessages();
  }

  @override
  void didUpdateWidget(MessageListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool messagesChanged = !listEquals(oldWidget.messages, widget.messages);
    bool outboxQueueChanged = !listEquals(oldWidget.outboxQueue, widget.outboxQueue);
    if (messagesChanged || outboxQueueChanged) mapMessages();
  }

  void mapMessages() {
    _logger.fine('Mapping messages msgs: ${widget.messages.length} outbox: ${widget.outboxQueue.length}');

    Map<String, types.TextMessage> msgMap = {};

    for (final entry in widget.outboxQueue.reversed) {
      if (entry.type == ChatQueueEntryType.create) {
        var textMessage = types.TextMessage(
          author: types.User(
            id: widget.userId,
            firstName: widget.userId,
          ),
          id: entry.idKey,
          text: entry.content,
          showStatus: true,
          status: types.Status.sending,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          previewData: previews[entry.idKey.toString()],
        );
        msgMap[entry.idKey] = textMessage;
      }
    }

    for (final msg in widget.messages) {
      final textMessage = types.TextMessage(
          author: types.User(
            id: msg.senderId,
            firstName: msg.senderId,
          ),
          id: msg.idKey,
          remoteId: msg.id.toString(),
          text: msg.content,
          showStatus: true,
          status: types.Status.delivered,
          createdAt: msg.createdAt.millisecondsSinceEpoch,
          previewData: previews[msg.id.toString()],
          metadata: {'message': msg});

      msgMap[msg.idKey] = textMessage;
    }

    messages = msgMap.values.toList();
  }

  void handlePreviewDataFetched(types.TextMessage message, types.PreviewData previewData) {
    if (previews[message.id] == null) {
      previews[message.id] = previewData;

      setState(() {
        final index = messages.indexWhere((element) => element.id == message.id);
        final updatedMessage = (messages[index]).copyWith(previewData: previewData) as types.TextMessage;
        if (index != -1) messages[index] = updatedMessage;
      });
    }
  }

  void handleSend(types.PartialText message) {
    final messageForForward = messageForwardCubit.state;

    if (messageForForward != null) {
      widget.onSendForward(message.text, messageForForward);
      messageForwardCubit.clear();
    } else if (replyingMessage != null) {
      widget.onSendReply(message.text, replyingMessage!);
      setState(() => replyingMessage = null);
    } else if (editingMessage != null) {
      widget.onSendEdit(message.text, editingMessage!);
      setState(() => editingMessage = null);
    } else {
      widget.onSendMessage(message.text);
    }
  }

  void handleSetForReply(ChatMessage message) {
    messageForwardCubit.clear();
    setState(() => editingMessage = null);
    setState(() => replyingMessage = message);
  }

  void handleSetForForward(ChatMessage message) {
    setState(() => editingMessage = null);
    setState(() => replyingMessage = null);
    messageForwardCubit.setForForward(message);
  }

  void handleSetForEdit(ChatMessage message) {
    messageForwardCubit.clear();
    setState(() => replyingMessage = null);
    setState(() => editingMessage = message);
  }

  void handleDelete(ChatMessage message) {
    widget.onDelete(message);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FlyerChat(
      messages: messages,
      onSendPressed: handleSend,
      user: user,
      showUserNames: true,
      showUserAvatars: true,
      onEndReached: widget.onFetchHistory,
      isLastPage: widget.historyEndReached,
      onPreviewDataFetched: handlePreviewDataFetched,
      theme: DefaultChatTheme(
        inputBackgroundColor: Colors.white,
        inputTextColor: Colors.black,
        primaryColor: theme.primaryColor,
        secondaryColor: theme.secondaryHeaderColor,
        inputMargin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        inputPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        inputContainerDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: theme.cardColor,
              spreadRadius: 4,
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
      ),
      customBottomWidget: BlocBuilder<MessageForwardCubit, ChatMessage?>(
        builder: (context, messageForReply) {
          return Column(
            children: [
              if (messageForReply != null) const Text('Forward'),
              if (messageForReply != null) Text(messageForReply.content),
              if (replyingMessage != null) const Text('Reply'),
              if (replyingMessage != null) Text(replyingMessage!.content),
              if (editingMessage != null) const Text('Edit'),
              if (editingMessage != null) Text(editingMessage!.content),
              Input(onSendPressed: handleSend),
            ],
          );
        },
      ),
      textMessageBuilder: (m, {required messageWidth, required showName}) {
        ChatMessage? message;
        if (m.metadata != null && m.metadata!.containsKey('message')) {
          message = m.metadata!['message'] as ChatMessage;
        }

        final isSended = message?.id != null;
        final isMine = message?.senderId == widget.userId;

        return CallPopupMenuButton(
          items: [
            if (isSended)
              CallPopupMenuItem(
                text: 'Reply',
                icon: const Icon(Icons.reply),
                onTap: () => handleSetForReply(message!),
              ),
            if (isSended)
              CallPopupMenuItem(
                text: 'Forward',
                icon: const Icon(Icons.forward),
                onTap: () => handleSetForForward(message!),
              ),
            if (isMine && isSended)
              CallPopupMenuItem(
                text: 'Edit',
                icon: const Icon(Icons.edit),
                onTap: () => handleSetForEdit(message!),
              ),
            if (isMine && isSended)
              CallPopupMenuItem(
                text: 'Delete',
                icon: const Icon(Icons.remove),
                onTap: () => handleDelete(message!),
              ),
          ],
          child: TextMessage(
            emojiEnlargementBehavior: EmojiEnlargementBehavior.never,
            hideBackgroundOnEmojiMessages: false,
            message: m,
            showName: showName,
            usePreviewData: true,
          ),
        );
      },
    );
  }
}
