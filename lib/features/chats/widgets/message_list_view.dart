import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:logging/logging.dart';
import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
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
    required this.readCursors,
    required this.historyEndReached,
    required this.onSendMessage,
    required this.onSendReply,
    required this.onSendForward,
    required this.onSendEdit,
    required this.onDelete,
    required this.userReadedUntilUpdate,
    required this.onFetchHistory,
    required this.hasSmsFeature,
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
  final Function(String content, bool useSms) onSendMessage;
  final Function(String content, ChatMessage refMessage) onSendReply;
  final Function(String content, ChatMessage refMessage) onSendForward;
  final Function(String content, ChatMessage refMessage) onSendEdit;
  final Function(ChatMessage refMessage) onDelete;
  final Function(DateTime until) userReadedUntilUpdate;
  final Future Function() onFetchHistory;
  final bool hasSmsFeature;

  @override
  State<MessageListView> createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  late final messageForwardCubit = context.read<MessageForwardCubit>();
  late final user = types.User(id: widget.userId);
  List<types.Message> messages = [];
  ChatMessage? editingMessage;
  ChatMessage? replyingMessage;
  bool useSms = false;

  final inputController = TextEditingController();

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
    bool readCursorsChanged() => !listEquals(oldWidget.readCursors, widget.readCursors);

    final shouldRemap = outboxMessagesChanged() ||
        outboxMessageEditsChanged() ||
        outboxMessageDeletesChanged() ||
        readCursorsChanged() ||
        messagesChanged();
    if (shouldRemap) mapMessages();
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
      );
      msgMap[entry.idKey] = textMessage;
    }

    final participantsReadedUntil = widget.readCursors.participantsReadedUntil(widget.userId);

    for (final msg in widget.messages) {
      final editEntry = widget.outboxMessageEdits.firstWhereOrNull((element) => element.idKey == msg.idKey);
      final deleteEntry = widget.outboxMessageDeletes.firstWhereOrNull((element) => element.idKey == msg.idKey);
      final inOutbox = editEntry != null || deleteEntry != null;

      final seen = participantsReadedUntil != null && !msg.createdAt.isAfter(participantsReadedUntil);

      String text = msg.content;
      if (editEntry != null) text = editEntry.newContent;
      if (msg.deletedAt != null || deleteEntry != null) text = '[deleted]';

      final metadata = {
        'message': msg,
        'edited': msg.editedAt != null || editEntry != null,
        'deleted': msg.deletedAt != null || deleteEntry != null,
      };

      types.Status status;
      if (inOutbox) {
        // If message has changes in outbox that no sended yet
        status = types.Status.sending;
      } else {
        // Else show status based on message state
        if (seen) {
          status = types.Status.seen;
        } else {
          status = types.Status.delivered;
        }
      }

      final textMessage = types.TextMessage(
        author: types.User(id: msg.senderId, firstName: msg.senderId),
        id: msg.idKey,
        remoteId: msg.id.toString(),
        text: text,
        showStatus: true,
        status: status,
        createdAt: msg.createdAt.millisecondsSinceEpoch,
        updatedAt: msg.updatedAt.millisecondsSinceEpoch,
        metadata: metadata,
      );

      msgMap[msg.idKey] = textMessage;
    }

    messages = msgMap.values.toList();
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
      inputController.text = '';
    } else {
      widget.onSendMessage(message.text, widget.hasSmsFeature ? useSms : false);
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
    context.router.navigate(const ChatsRouterPageRoute(children: [ChatListScreenPageRoute()])).then((_) {
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<ChatTypingCubit, TypingState>(
      builder: (context, typingState) {
        final typingUsers = typingState.map((typing) => types.User(id: typing.userId, firstName: typing.name)).toList();

        return FlyerChat(
          messages: messages,
          onSendPressed: handleSend,
          user: user,
          showUserNames: true,
          showUserAvatars: true,
          onEndReached: widget.onFetchHistory,
          isLastPage: widget.historyEndReached,
          emojiEnlargementBehavior: EmojiEnlargementBehavior.never,
          typingIndicatorOptions: TypingIndicatorOptions(
            typingUsers: typingUsers,
            animationSpeed: const Duration(seconds: 1),
            typingMode: TypingIndicatorMode.name,
          ),
          onMessageVisibilityChanged: (uiMessage, visible) {
            if (!visible) return;

            ChatMessage? chatMessage = uiMessage.chatMessage;
            if (chatMessage == null) return;

            final mine = chatMessage.senderId == widget.userId;
            if (mine) return;

            final userReadedUntil = widget.readCursors.userReadedUntil(widget.userId);
            final reachedUnreaded = userReadedUntil == null || chatMessage.createdAt.isAfter(userReadedUntil);
            if (reachedUnreaded) widget.userReadedUntilUpdate(chatMessage.createdAt);
          },
          avatarBuilder: (author) {
            String name = author.firstName ?? 'N/A';
            final numberFromName = int.tryParse(name);
            if (numberFromName != null && name.length > 3) {
              name = name.substring(name.length - 3);
            }
            return Padding(
              padding: const EdgeInsets.all(4),
              child: CircleAvatar(
                maxRadius: 16,
                backgroundColor: colorScheme.tertiary,
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ParticipantName(
                      senderId: author.id,
                      userId: widget.userId,
                      textMap: (name) {
                        var text = name.split(' ').first;
                        if (text.length > 16) text = text.substring(0, 16);
                        return text;
                      },
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          },
          theme: DefaultChatTheme(
            inputBackgroundColor: Colors.white,
            inputTextColor: Colors.black,
            primaryColor: colorScheme.primary,
            secondaryColor: colorScheme.secondary,
            sentMessageBodyTextStyle: const TextStyle(color: Colors.white),
            receivedMessageBodyTextStyle: const TextStyle(color: Colors.white),
            receivedMessageLinkTitleTextStyle: const TextStyle(color: Colors.white),
            receivedMessageLinkDescriptionTextStyle: const TextStyle(color: Colors.white),
            inputMargin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            inputPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            messageInsetsVertical: 0,
            messageInsetsHorizontal: 0,
            inputContainerDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(color: theme.cardColor, spreadRadius: 4, blurRadius: 8, offset: const Offset(2, 4))
              ],
            ),
          ),
          customBottomWidget: BlocBuilder<MessageForwardCubit, ChatMessage?>(
            builder: (context, messageForForward) {
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
                    Row(
                      children: [
                        Expanded(
                          child: Input(
                            onSendPressed: handleSend,
                            options: InputOptions(
                              textEditingController: inputController,
                              onTextChanged: (_) => context.read<ChatTypingCubit>().sendTyping(),
                            ),
                          ),
                        ),
                        if (widget.hasSmsFeature &&
                            replyingMessage == null &&
                            editingMessage == null &&
                            messageForForward == null)
                          Column(
                            children: [
                              SizedBox(
                                height: 24,
                                child: Checkbox(
                                  value: useSms,
                                  onChanged: (v) => setState(() => useSms = v ?? false),
                                ),
                              ),
                              const Text('SMS', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                      ],
                    ),
                ],
              );
            },
          ),
          textMessageBuilder: (message, {required messageWidth, required showName}) => MessageView(
            userId: widget.userId,
            message: message,
            messageWidth: messageWidth,
            showName: showName,
            handleSetForReply: handleSetForReply,
            handleSetForForward: handleSetForForward,
            handleSetForEdit: handleSetForEdit,
            handleDelete: handleDelete,
          ),
        );
      },
    );
  }
}
