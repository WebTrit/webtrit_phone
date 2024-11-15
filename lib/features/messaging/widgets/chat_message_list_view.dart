import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

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
  late final chatsForwardingCubit = context.read<ChatsForwardingCubit>();
  late final inputController = TextEditingController();
  late final scrollController = ScrollController();

  List<_ChatMessageListViewEntry> viewEntries = [];
  DateTime? computeTime;
  ChatMessage? editingMessage;
  ChatMessage? replyingMessage;

  bool scrolledAway = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final position = scrollController.position.pixels;
      final scrollRemaining = maxScroll - position;

      const hystoryFetchScrollThreshold = 500.0;
      final shouldFetch = scrollRemaining < hystoryFetchScrollThreshold;
      final canFetch = !widget.historyEndReached && !widget.fetchingHistory;
      if (shouldFetch && canFetch) widget.onFetchHistory();

      const scrolledThreshold = 1000;
      final scrolledAway = position > scrolledThreshold;
      if (this.scrolledAway != scrolledAway) setState(() => this.scrolledAway = scrolledAway);
    });
    computeViewEntries();
  }

  @override
  void didUpdateWidget(ChatMessageListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    computeViewEntries();
  }

  computeViewEntries() async {
    _ComputeParams params = (
      userId: widget.userId,
      messages: widget.messages,
      outboxMessages: widget.outboxMessages,
      outboxMessageEdits: widget.outboxMessageEdits,
      outboxMessageDeletes: widget.outboxMessageDeletes,
      readCursors: widget.readCursors,
      dueTime: DateTime.now(),
    );

    final result = await compute(_computeList, params);
    if (!mounted) return;
    if (computeTime != null && result.dueTime.isBefore(computeTime!)) return;
    setState(() {
      viewEntries = result.entries;
      computeTime = result.dueTime;
    });
  }

  void scrollToBottom() {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 600), curve: Curves.easeInOutExpo);
  }

  void handleSend() {
    final messageForForward = chatsForwardingCubit.state;
    final content = inputController.text.trim();
    if (content.isEmpty) return;

    if (messageForForward != null) {
      widget.onSendForward(content, messageForForward);
      chatsForwardingCubit.clear();
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
    scrollToBottom();
  }

  void handleSetForReply(ChatMessage message) {
    chatsForwardingCubit.clear();
    setState(() => editingMessage = null);
    setState(() => replyingMessage = message);
  }

  void handleSetForForward(ChatMessage message) async {
    setState(() => editingMessage = null);
    setState(() => replyingMessage = null);
    final cubitRef = chatsForwardingCubit;
    context.router.navigate(const MainScreenPageRoute(children: [ConversationsScreenPageRoute()]));
    await Future.delayed(const Duration(milliseconds: 300));
    cubitRef.setForForward(message);
  }

  void handleSetForEdit(ChatMessage message) {
    chatsForwardingCubit.clear();
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
      Expanded(child: MessagingStateWrapper(child: list())),
      field(),
    ]);
  }

  Widget list() {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.transparent,
            Colors.transparent,
            Colors.black,
          ],
          stops: [0.0, 0.025, 0.975, 1.0],
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: ScrollToBottomOverlay(
        scrolledAway: scrolledAway,
        onScrollToBottom: scrollToBottom,
        child: ListView.builder(
          controller: scrollController,
          reverse: true,
          cacheExtent: 500,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: viewEntries.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) return typingIndicator();
            if (index == viewEntries.length + 1) return historyFetchIndicator();

            final entry = viewEntries[index - 1];

            if (entry is _MessageViewEntry) {
              return FadeIn(
                child: ChatMessageView(
                  key: Key(entry.message?.idKey ?? entry.outboxMessage!.idKey),
                  userId: widget.userId,
                  message: entry.message,
                  outboxMessage: entry.outboxMessage,
                  outboxEditEntry: entry.outboxEditEntry,
                  outboxDeleteEntry: entry.outboxDeleteEntry,
                  userReadedUntil: entry.userReadedUntil,
                  membersReadedUntil: entry.membersReadedUntil,
                  handleSetForReply: handleSetForReply,
                  handleSetForForward: handleSetForForward,
                  handleSetForEdit: handleSetForEdit,
                  handleDelete: handleDelete,
                  onRendered: () {
                    final message = entry.message;
                    if (message == null) return;

                    final mine = message.senderId == widget.userId;
                    if (mine) return;

                    final userReadedUntil = widget.readCursors.userReadedUntil(widget.userId);
                    final reachedUnreaded = userReadedUntil == null || message.createdAt.isAfter(userReadedUntil);
                    if (reachedUnreaded) widget.userReadedUntilUpdate(message.createdAt);
                  },
                ),
              );
            }

            if (entry is _DateViewEntry) {
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Center(
                  child: Text(
                    entry.date.toDayOfMonth,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
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
        final typingUsers = state;
        final anybodyTyping = typingUsers.isNotEmpty;

        const textStyle = TextStyle(fontSize: 12, color: Colors.grey);

        return AnimatedCrossFade(
          duration: const Duration(milliseconds: 600),
          sizeCurve: Curves.elasticOut,
          firstChild: const SizedBox(),
          secondChild: Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 4,
              children: [
                const TypingIconDriver(),
                for (final id in typingUsers) ...[
                  ContactInfoBuilder(
                      sourceType: ContactSourceType.external,
                      sourceId: id,
                      builder: (context, contact, {required bool loading}) {
                        if (contact == null) return const SizedBox();
                        return Text(contact.displayTitle, style: textStyle);
                      }),
                ],
                Text(context.l10n.messaging_MessageListView_typingTrail, style: textStyle),
              ],
            ),
          ),
          crossFadeState: anybodyTyping ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        );
      },
    );
  }

  Widget field() {
    return BlocBuilder<ChatsForwardingCubit, ChatMessage?>(
      builder: (context, state) {
        final messageForForward = state;

        Widget? exchangeWidget;
        if (messageForForward != null) {
          exchangeWidget = ExchangeBar(
            text: messageForForward.content,
            icon: Icons.forward,
            onCancel: chatsForwardingCubit.clear,
            onConfirm: () {
              widget.onSendForward(messageForForward.content, messageForForward);
              chatsForwardingCubit.clear();
            },
          );
        }

        if (replyingMessage != null) {
          exchangeWidget = ExchangeBar(
            text: replyingMessage!.content,
            icon: Icons.reply,
            onCancel: () {
              setState(() => replyingMessage = null);
              FocusScope.of(context).unfocus();
            },
          );
        }

        if (editingMessage != null) {
          exchangeWidget = ExchangeBar(
            text: editingMessage!.content,
            icon: Icons.edit_note,
            onCancel: () {
              setState(() => editingMessage = null);
              inputController.text = '';
              FocusScope.of(context).unfocus();
            },
          );
        }

        return Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation.drive(CurveTween(curve: Curves.linear)),
                  child: SizeTransition(sizeFactor: animation, child: child),
                );
              },
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeOut,
              child: exchangeWidget ?? const SizedBox(),
            ),
            if (messageForForward == null)
              MessageTextField(
                controller: inputController,
                onSend: handleSend,
                onChanged: (value) => context.read<ChatTypingCubit>().sendTyping(),
              )
          ],
        );
      },
    );
  }
}

sealed class _ChatMessageListViewEntry {}

final class _MessageViewEntry extends _ChatMessageListViewEntry {
  final ChatMessage? message;
  final ChatOutboxMessageEntry? outboxMessage;
  final ChatOutboxMessageEditEntry? outboxEditEntry;
  final ChatOutboxMessageDeleteEntry? outboxDeleteEntry;
  final DateTime? userReadedUntil;
  final DateTime? membersReadedUntil;

  _MessageViewEntry({
    this.message,
    this.outboxMessage,
    this.outboxEditEntry,
    this.outboxDeleteEntry,
    this.userReadedUntil,
    this.membersReadedUntil,
  });
}

final class _DateViewEntry extends _ChatMessageListViewEntry {
  final DateTime date;

  _DateViewEntry(this.date);
}

typedef _ComputeParams = ({
  String userId,
  List<ChatMessage> messages,
  List<ChatOutboxMessageEntry> outboxMessages,
  List<ChatOutboxMessageEditEntry> outboxMessageEdits,
  List<ChatOutboxMessageDeleteEntry> outboxMessageDeletes,
  List<ChatMessageReadCursor> readCursors,
  DateTime dueTime,
});

typedef _ComputeResult = ({
  List<_ChatMessageListViewEntry> entries,
  DateTime dueTime,
});

_ComputeResult _computeList(_ComputeParams params) {
  final userId = params.userId;
  final messages = params.messages;
  final outboxMessages = params.outboxMessages;
  final outboxMessageEdits = params.outboxMessageEdits;
  final outboxMessageDeletes = params.outboxMessageDeletes;
  final readCursors = params.readCursors;
  final dueTime = params.dueTime;

  final userReadedUntil = readCursors.userReadedUntil(userId);
  final membersReadedUntil = readCursors.participantsReadedUntil(userId);

  final entries = <_ChatMessageListViewEntry>[];

  for (final entry in outboxMessages.reversed) {
    entries.add(_MessageViewEntry(outboxMessage: entry));
  }

  for (var i = 0; i <= messages.length - 1; i++) {
    final message = messages[i];
    final newEntry = outboxMessages.firstWhereOrNull((element) => element.idKey == message.idKey);
    final editEntry = outboxMessageEdits.firstWhereOrNull((element) => element.idKey == message.idKey);
    final deleteEntry = outboxMessageDeletes.firstWhereOrNull((element) => element.idKey == message.idKey);

    if (newEntry != null) continue;

    final isLast = i == 0;
    final nextMessage = isLast ? null : messages[i - 1];

    var lastMsgOfTheDay = false;

    if (nextMessage != null) {
      final nextMsgDate = nextMessage.createdAt;
      final msgDate = message.createdAt;
      lastMsgOfTheDay = nextMsgDate.day != msgDate.day;
    }

    if (lastMsgOfTheDay) {
      entries.add(_DateViewEntry(message.createdAt));
    }

    entries.add(_MessageViewEntry(
      message: message,
      outboxEditEntry: editEntry,
      outboxDeleteEntry: deleteEntry,
      userReadedUntil: userReadedUntil,
      membersReadedUntil: membersReadedUntil,
    ));
  }

  return (entries: entries, dueTime: dueTime);
}
