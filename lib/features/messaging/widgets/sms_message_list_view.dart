import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/models/models.dart';

import 'sms_message_view.dart';

class SmsMessageListView extends StatefulWidget {
  const SmsMessageListView({
    required this.userNumber,
    required this.messages,
    required this.fetchingHistory,
    required this.outboxMessages,
    required this.historyEndReached,
    required this.onSendMessage,
    required this.onFetchHistory,
    super.key,
  });

  final String? userNumber;
  final List<SmsMessage> messages;
  final List<SmsOutboxMessageEntry> outboxMessages;
  final bool fetchingHistory;
  final bool historyEndReached;
  final Function(String content) onSendMessage;
  final Future Function() onFetchHistory;

  @override
  State<SmsMessageListView> createState() => _SmsMessageListViewState();
}

class _SmsMessageListViewState extends State<SmsMessageListView> {
  late final inputController = TextEditingController();
  late final scrollController = ScrollController();

  List<Widget> elements = [];

  @override
  void initState() {
    super.initState();
    mapElements();
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final position = scrollController.position.pixels;

      final scrollRemaining = maxScroll - position;
      const hystoryFetchScrollThreshold = 500.0;

      final shouldFetch = scrollRemaining < hystoryFetchScrollThreshold;
      final canFetch = !widget.historyEndReached && !widget.fetchingHistory;

      if (shouldFetch && canFetch) widget.onFetchHistory();
    });
  }

  @override
  void didUpdateWidget(SmsMessageListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool messagesChanged() => !listEquals(oldWidget.messages, widget.messages);
    bool outboxMessagesChanged() => !listEquals(oldWidget.outboxMessages, widget.outboxMessages);

    final shouldRemap = outboxMessagesChanged() || messagesChanged();
    if (shouldRemap) mapElements();
  }

  mapElements() {
    elements = [];

    for (final entry in widget.outboxMessages.reversed) {
      elements.add(
        SmsMessageView(
          userNumber: widget.userNumber,
          outboxMessage: entry,
        ),
      );
    }

    for (var i = 0; i <= widget.messages.length - 1; i++) {
      final message = widget.messages[i];
      final newEntry = widget.outboxMessages.firstWhereOrNull((element) => element.idKey == message.idKey);

      if (newEntry != null) continue;

      final isLast = i == 0;
      final nextMessage = isLast ? null : widget.messages[i - 1];

      var lastMsgOfTheDay = false;

      if (nextMessage != null) {
        final nextMsgDate = nextMessage.createdAt;
        final msgDate = message.createdAt;
        lastMsgOfTheDay = nextMsgDate.day != msgDate.day;
      }

      if (lastMsgOfTheDay) {
        elements.add(
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Center(
              child: Text(
                message.createdAt.toDayOfMonth,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ),
        );
      }

      elements.add(
        SmsMessageView(
          userNumber: widget.userNumber,
          message: message,
          key: ObjectKey(message),
        ),
      );
    }
  }

  void handleSend() {
    final content = inputController.text.trim();
    if (content.isEmpty) return;

    widget.onSendMessage(content);

    inputController.text = '';
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(child: list()),
      field(),
    ]);
  }

  Widget list() {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.75),
            Colors.transparent,
            Colors.transparent,
            Colors.black.withOpacity(0.75),
          ],
          stops: const [0.0, 0.025, 0.975, 1.0],
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: ListView(
        controller: scrollController,
        reverse: true,
        cacheExtent: 500,
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          ...elements,
          historyFetchIndicator(),
        ],
      ),
    );
  }

  Widget historyFetchIndicator() {
    if (widget.fetchingHistory) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return const SizedBox();
  }

  Widget field() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withOpacity(0.1),
            spreadRadius: 4,
            blurRadius: 8,
            offset: const Offset(2, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: inputController,
              onFieldSubmitted: (_) => handleSend(),
              onChanged: (value) => context.read<ChatTypingCubit>().sendTyping(),
              decoration: const InputDecoration(hintText: 'Type a message', border: InputBorder.none),
            ),
          ),
          GestureDetector(
            child: Icon(Icons.send, size: 24, color: colorScheme.secondary),
            onTap: () => handleSend(),
          ),
        ],
      ),
    );
  }
}
