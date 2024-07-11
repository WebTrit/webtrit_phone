import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:logging/logging.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/call/widgets/popup_menu.dart';
import 'package:webtrit_phone/features/chats/chats.dart';
import 'package:webtrit_phone/models/models.dart';

final _logger = Logger('MessageListView');

class MessageListView extends StatefulWidget {
  const MessageListView({
    required this.userId,
    required this.messages,
    required this.fetchingHistory,
    required this.outboxMessages,
    required this.outboxMessageEdits,
    required this.outboxMessageDeletes,
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
  final List<ChatOutboxMessageEntry> outboxMessages;
  final List<ChatOutboxMessageEditEntry> outboxMessageEdits;
  final List<ChatOutboxMessageDeleteEntry> outboxMessageDeletes;
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
  List<types.Message> messages = [];
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
    bool messagesChanged() => !listEquals(oldWidget.messages, widget.messages);
    bool outboxMessagesChanged() => !listEquals(oldWidget.outboxMessages, widget.outboxMessages);
    bool outboxMessageEditsChanged() => !listEquals(oldWidget.outboxMessageEdits, widget.outboxMessageEdits);
    bool outboxMessageDeletesChanged() => !listEquals(oldWidget.outboxMessageDeletes, widget.outboxMessageDeletes);
    if (outboxMessagesChanged() || outboxMessageEditsChanged() || outboxMessageDeletesChanged() || messagesChanged()) {
      mapMessages();
    }
  }

  void mapMessages() {
    _logger.fine('Mapping messages msgs: ${widget.messages.length} outbox: ${widget.outboxMessages.length}');

    Map<String, types.Message> msgMap = {};

    for (final entry in widget.outboxMessages.reversed) {
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
        previewData: previews[entry.content],
      );
      msgMap[entry.idKey] = textMessage;
    }

    for (final msg in widget.messages) {
      final editEntry = widget.outboxMessageEdits.firstWhereOrNull((element) => element.idKey == msg.idKey);
      final deleteEntry = widget.outboxMessageDeletes.firstWhereOrNull((element) => element.idKey == msg.idKey);
      final inOutbox = editEntry != null || deleteEntry != null;

      String text = msg.content;
      if (editEntry != null) text = editEntry.newContent;
      if (msg.deletedAt != null || deleteEntry != null) text = '[deleted]';

      final metadata = {
        'message': msg,
        'edited': msg.editedAt != null || editEntry != null,
        'deleted': msg.deletedAt != null || deleteEntry != null,
      };

      final textMessage = types.TextMessage(
        author: types.User(
          id: msg.senderId,
          firstName: msg.senderId,
        ),
        id: msg.idKey,
        remoteId: msg.id.toString(),
        text: text,
        showStatus: true,
        status: inOutbox ? types.Status.sending : types.Status.delivered,
        createdAt: msg.createdAt.millisecondsSinceEpoch,
        updatedAt: msg.updatedAt.millisecondsSinceEpoch,
        previewData: previews[text],
        metadata: metadata,
      );

      msgMap[msg.idKey] = textMessage;
    }

    messages = msgMap.values.toList();
  }

  void handlePreviewDataFetched(types.TextMessage message, types.PreviewData previewData) {
    if (previews[message.text] == null) {
      previews[message.text] = previewData;

      setState(() {
        final index = messages.indexWhere((element) => element.id == message.id);
        final updatedMessage = (messages[index] as types.TextMessage).copyWith(previewData: previewData);
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
      // bubbleBuilder: (child, {required message, required nextMessageInGroup}) {
      //   ChatMessage? realMessage;
      //   if (message.metadata != null && message.metadata!.containsKey('message')) {
      //     realMessage = message.metadata!['message'] as ChatMessage;
      //   }

      //   final isMine = realMessage == null || realMessage.senderId == widget.userId;

      //   const defaultBuubleRadius = Radius.circular(8);

      //   Radius buttomLeftRadius;
      //   if (!nextMessageInGroup) {
      //     buttomLeftRadius = isMine ? defaultBuubleRadius : const Radius.circular(0);
      //   } else {
      //     buttomLeftRadius = defaultBuubleRadius;
      //   }

      //   Radius buttomRightRadius;
      //   if (!nextMessageInGroup) {
      //     buttomRightRadius = isMine ? const Radius.circular(0) : defaultBuubleRadius;
      //   } else {
      //     buttomRightRadius = defaultBuubleRadius;
      //   }

      //   return Column(
      //     children: [
      //       Container(
      //         decoration: BoxDecoration(
      //           color: isMine ? Colors.deepPurple : Colors.amberAccent,
      //           borderRadius: BorderRadius.only(
      //             topLeft: defaultBuubleRadius,
      //             topRight: defaultBuubleRadius,
      //             bottomLeft: buttomLeftRadius,
      //             bottomRight: buttomRightRadius,
      //           ),
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.black.withOpacity(0.1),
      //               spreadRadius: 1,
      //               blurRadius: 2,
      //               offset: const Offset(0, 1),
      //             ),
      //           ],
      //         ),
      //         child: child,
      //       ),
      //       const Text('data')
      //     ],
      //   );
      // },
      textMessageBuilder: (message, {required messageWidth, required showName}) {
        ChatMessage? realMessage;
        if (message.metadata != null && message.metadata!.containsKey('message')) {
          realMessage = message.metadata!['message'] as ChatMessage;
        }

        final isEdited = message.metadata != null && message.metadata!['edited'] == true;

        final isSended = realMessage?.id != null;
        final isMine = realMessage == null || realMessage.senderId == widget.userId;

        return CallPopupMenuButton(
          items: [
            if (isSended)
              CallPopupMenuItem(
                text: 'Reply',
                icon: const Icon(Icons.reply),
                onTap: () => handleSetForReply(realMessage!),
              ),
            if (isSended)
              CallPopupMenuItem(
                text: 'Forward',
                icon: const Icon(Icons.forward),
                onTap: () => handleSetForForward(realMessage!),
              ),
            if (isMine && isSended)
              CallPopupMenuItem(
                text: 'Edit',
                icon: const Icon(Icons.edit),
                onTap: () => handleSetForEdit(realMessage!),
              ),
            if (isMine && isSended)
              CallPopupMenuItem(
                text: 'Delete',
                icon: const Icon(Icons.remove),
                onTap: () => handleDelete(realMessage!),
              ),
          ],
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: TextMessage(
                  emojiEnlargementBehavior: EmojiEnlargementBehavior.never,
                  hideBackgroundOnEmojiMessages: false,
                  message: message,
                  showName: showName,
                  usePreviewData: true,
                  onPreviewDataFetched: handlePreviewDataFetched,
                ),
              ),
              if (isEdited)
                const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(Icons.edit, size: 16, color: Colors.grey),
                ),
            ],
          ),
        );
      },
    );
  }
}
