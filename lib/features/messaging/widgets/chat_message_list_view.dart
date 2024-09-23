import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

import 'chat_message_view.dart';

class ChatMessageListView extends StatefulWidget {
  const ChatMessageListView({
    required this.userId,
    required this.messages,
    required this.fetchingHistory,
    required this.outboxMessages,
    required this.outboxMessageEdits,
    required this.outboxMessageDeletes,
    required this.readCursors,
    required this.historyEndReached,
    required this.onSendMessage,
    required this.onSendReply,
    required this.onSendForward,
    required this.onSendEdit,
    required this.onDelete,
    required this.userReadedUntilUpdate,
    required this.onFetchHistory,
    super.key,
  });

  final String userId;
  final List<ChatMessage> messages;
  final List<ChatOutboxMessageEntry> outboxMessages;
  final List<ChatOutboxMessageEditEntry> outboxMessageEdits;
  final List<ChatOutboxMessageDeleteEntry> outboxMessageDeletes;
  final List<ChatMessageReadCursor> readCursors;
  final bool fetchingHistory;
  final bool historyEndReached;
  final Function(String content) onSendMessage;
  final Function(String content, ChatMessage refMessage) onSendReply;
  final Function(String content, ChatMessage refMessage) onSendForward;
  final Function(String content, ChatMessage refMessage) onSendEdit;
  final Function(ChatMessage refMessage) onDelete;
  final Function(DateTime until) userReadedUntilUpdate;
  final Future Function() onFetchHistory;

  @override
  State<ChatMessageListView> createState() => _ChatMessageListViewState();
}

class _ChatMessageListViewState extends State<ChatMessageListView> {
  late final messageForwardCubit = context.read<MessageForwardCubit>();
  late final inputController = TextEditingController();
  late final scrollController = ScrollController();

  List<Widget> elements = [];
  ChatMessage? editingMessage;
  ChatMessage? replyingMessage;

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
  void didUpdateWidget(ChatMessageListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool messagesChanged() => !listEquals(oldWidget.messages, widget.messages);
    bool outboxMessagesChanged() => !listEquals(oldWidget.outboxMessages, widget.outboxMessages);
    bool outboxMessageEditsChanged() => !listEquals(oldWidget.outboxMessageEdits, widget.outboxMessageEdits);
    bool outboxMessageDeletesChanged() => !listEquals(oldWidget.outboxMessageDeletes, widget.outboxMessageDeletes);
    bool readCursorsChanged() => !listEquals(oldWidget.readCursors, widget.readCursors);

    final shouldRemap = outboxMessagesChanged() ||
        outboxMessageEditsChanged() ||
        outboxMessageDeletesChanged() ||
        readCursorsChanged() ||
        messagesChanged();
    if (shouldRemap) mapElements();
  }

  mapElements() {
    final userReadedUntil = widget.readCursors.userReadedUntil(widget.userId);
    final membersReadedUntil = widget.readCursors.participantsReadedUntil(widget.userId);

    elements = [];

    for (final entry in widget.outboxMessages.reversed) {
      elements.add(
        ChatMessageView(
          userId: widget.userId,
          outboxMessage: entry,
          handleSetForReply: handleSetForReply,
          handleSetForForward: handleSetForForward,
          handleSetForEdit: handleSetForEdit,
          handleDelete: handleDelete,
        ),
      );
    }

    for (var i = 0; i <= widget.messages.length - 1; i++) {
      final message = widget.messages[i];
      final newEntry = widget.outboxMessages.firstWhereOrNull((element) => element.idKey == message.idKey);
      final editEntry = widget.outboxMessageEdits.firstWhereOrNull((element) => element.idKey == message.idKey);
      final deleteEntry = widget.outboxMessageDeletes.firstWhereOrNull((element) => element.idKey == message.idKey);

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
        ChatMessageView(
          userId: widget.userId,
          message: message,
          outboxEditEntry: editEntry,
          outboxDeleteEntry: deleteEntry,
          userReadedUntil: userReadedUntil,
          membersReadedUntil: membersReadedUntil,
          handleSetForReply: handleSetForReply,
          handleSetForForward: handleSetForForward,
          handleSetForEdit: handleSetForEdit,
          handleDelete: handleDelete,
          onRendered: () {
            final mine = message.senderId == widget.userId;
            if (mine) return;

            final userReadedUntil = widget.readCursors.userReadedUntil(widget.userId);
            final reachedUnreaded = userReadedUntil == null || message.createdAt.isAfter(userReadedUntil);
            if (reachedUnreaded) widget.userReadedUntilUpdate(message.createdAt);
          },
          key: ObjectKey(message),
        ),
      );
    }
  }

  void handleSend() {
    final messageForForward = messageForwardCubit.state;
    final content = inputController.text.trim();
    if (content.isEmpty) return;

    if (messageForForward != null) {
      widget.onSendForward(content, messageForForward);
      messageForwardCubit.clear();
    } else if (replyingMessage != null) {
      widget.onSendReply(content, replyingMessage!);
      setState(() => replyingMessage = null);
    } else if (editingMessage != null) {
      widget.onSendEdit(content, editingMessage!);
      setState(() => editingMessage = null);
    } else {
      widget.onSendMessage(content);
    }

    inputController.text = '';
    FocusScope.of(context).unfocus();
  }

  void handleSetForReply(ChatMessage message) {
    messageForwardCubit.clear();
    setState(() => editingMessage = null);
    setState(() => replyingMessage = message);
  }

  void handleSetForForward(ChatMessage message) {
    setState(() => editingMessage = null);
    setState(() => replyingMessage = null);
    context.router.navigate(const MessagingRouterPageRoute(children: [ConversationsScreenPageRoute()])).then((_) {
      messageForwardCubit.setForForward(message);
    });
  }

  void handleSetForEdit(ChatMessage message) {
    messageForwardCubit.clear();
    setState(() => replyingMessage = null);
    setState(() => editingMessage = message);
    inputController.text = message.content;
  }

  void handleDelete(ChatMessage message) {
    widget.onDelete(message);
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
          typingIndicator(),
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

  Widget typingIndicator() {
    return BlocBuilder<ChatTypingCubit, TypingState>(
      builder: (context, state) {
        final typing = state.isNotEmpty;
        final typingUsers = state.map((e) => e.name).join(', ');

        if (typing) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const TypingIconDriver(),
                Flexible(
                  child: Text(
                    '$typingUsers is typing...',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget field() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<MessageForwardCubit, ChatMessage?>(
      builder: (context, state) {
        final messageForForward = state;

        return Column(
          children: [
            if (messageForForward != null)
              ExchangeBar(
                text: messageForForward.content,
                icon: Icons.forward,
                onCancel: messageForwardCubit.clear,
                onConfirm: () {
                  widget.onSendForward(messageForForward.content, messageForForward);
                  messageForwardCubit.clear();
                },
              ),
            if (replyingMessage != null)
              ExchangeBar(
                text: replyingMessage!.content,
                icon: Icons.reply,
                onCancel: () => setState(() => replyingMessage = null),
              ),
            if (editingMessage != null)
              ExchangeBar(
                text: editingMessage!.content,
                icon: Icons.edit_note,
                onCancel: () {
                  setState(() => editingMessage = null);
                  inputController.text = '';
                  FocusScope.of(context).unfocus();
                },
              ),
            if (messageForForward == null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: colorScheme.onSurface.withOpacity(0.1),
                        spreadRadius: 4,
                        blurRadius: 8,
                        offset: const Offset(2, 4))
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: inputController,
                        onFieldSubmitted: (_) => handleSend(),
                        onChanged: (value) => context.read<ChatTypingCubit>().sendTyping(),
                        decoration: InputDecoration(
                          hintText: context.l10n.chats_MessageListView_field_hint,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Icon(Icons.send, size: 24, color: colorScheme.secondary),
                      onTap: () => handleSend(),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
