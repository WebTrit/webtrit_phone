import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_chat_ui/flutter_chat_ui.dart' hide TextMessage;
import 'package:flutter_chat_types/flutter_chat_types.dart' show PartialText, PreviewData, Status, TextMessage, User;

import 'package:webtrit_phone/models/models.dart';

class MessageListView extends StatefulWidget {
  const MessageListView({
    required this.userId,
    required this.messages,
    required this.fetchingHistory,
    required this.historyEndReached,
    required this.onSend,
    super.key,
  });

  final String userId;
  final List<ChatMessage> messages;
  final bool fetchingHistory;
  final bool historyEndReached;
  final Function(String content) onSend;

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
    if (!listEquals(oldWidget.messages, widget.messages)) mapMessages();
  }

  void mapMessages() {
    messages = widget.messages.map((msg) {
      return TextMessage(
        author: User(
          id: msg.senderId,
          firstName: msg.senderId,
        ),
        id: msg.id.toString(),
        text: msg.content,
        showStatus: true,
        status: Status.delivered,
        createdAt: msg.createdAt.millisecondsSinceEpoch,
        previewData: previews[msg.id.toString()],
      );
    }).toList();
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
      onEndReached: () async {
        print('onEndReached');
      },
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
    setState(() => previews[message.id] = previewData);
  }
}
