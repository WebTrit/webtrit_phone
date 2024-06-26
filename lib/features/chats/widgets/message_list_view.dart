import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_chat_ui/flutter_chat_ui.dart' hide TextMessage;
import 'package:flutter_chat_types/flutter_chat_types.dart' show PartialText, PreviewData, Status, TextMessage, User;
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';

final _logger = Logger('MessageListView');

class MessageListView extends StatefulWidget {
  const MessageListView({
    required this.userId,
    required this.messages,
    required this.fetchingHistory,
    required this.outboxQueue,
    required this.historyEndReached,
    required this.onSend,
    required this.onFetchHistory,
    super.key,
  });

  final String userId;
  final List<ChatMessage> messages;
  final List<ChatQueueEntry> outboxQueue;
  final bool fetchingHistory;
  final bool historyEndReached;
  final Function(String content) onSend;
  final Future Function() onFetchHistory;

  @override
  State<MessageListView> createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  late final user = User(id: widget.userId);
  final Map<String, PreviewData> previews = {};
  List<TextMessage> messages = [];

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

    Map<String, TextMessage> msgMap = {};

    for (final entry in widget.outboxQueue.reversed) {
      if (entry.type == ChatQueueEntryType.create) {
        var textMessage = TextMessage(
          author: User(
            id: widget.userId,
            firstName: widget.userId,
          ),
          id: entry.idKey,
          text: entry.content,
          showStatus: true,
          status: Status.sending,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          previewData: previews[entry.idKey.toString()],
        );
        msgMap[entry.idKey] = textMessage;
      }
    }

    for (final msg in widget.messages) {
      final textMessage = TextMessage(
        author: User(
          id: msg.senderId,
          firstName: msg.senderId,
        ),
        id: msg.idKey,
        text: msg.content,
        showStatus: true,
        status: Status.delivered,
        createdAt: msg.createdAt.millisecondsSinceEpoch,
        previewData: previews[msg.id.toString()],
      );

      msgMap[msg.idKey] = textMessage;
    }

    messages = msgMap.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FlyerChat(
      messages: messages,
      onSendPressed: _handleSendPressed,
      user: user,
      // showUserNames: true,
      showUserAvatars: true,
      onEndReached: widget.onFetchHistory,
      isLastPage: widget.historyEndReached,
      onPreviewDataFetched: _handlePreviewDataFetched,
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
    );
  }

  void _handleSendPressed(PartialText message) {
    widget.onSend(message.text);
  }

  void _handlePreviewDataFetched(TextMessage message, PreviewData previewData) {
    if (previews[message.id] == null) {
      previews[message.id] = previewData;

      setState(() {
        final index = messages.indexWhere((element) => element.id == message.id);
        final updatedMessage = (messages[index]).copyWith(previewData: previewData) as TextMessage;
        if (index != -1) messages[index] = updatedMessage;
      });
    }
  }
}
