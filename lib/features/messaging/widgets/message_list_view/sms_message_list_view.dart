import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'history_fetch_indicator.dart';
import 'message_text_field.dart';
import 'scroll_to_bottom.dart';
import 'typing_indicator.dart';
import '../message_view/sms_message_view.dart';

class SmsMessageListView extends StatefulWidget {
  const SmsMessageListView({
    required this.userId,
    required this.userNumber,
    required this.messages,
    required this.fetchingHistory,
    required this.outboxMessages,
    required this.outboxMessageDeletes,
    required this.readCursors,
    required this.historyEndReached,
    required this.onSendMessage,
    required this.onDelete,
    required this.userReadedUntilUpdate,
    required this.onFetchHistory,
    super.key,
  });
  final String userId;
  final String? userNumber;
  final List<SmsMessage> messages;
  final List<SmsOutboxMessageEntry> outboxMessages;
  final List<SmsOutboxMessageDeleteEntry> outboxMessageDeletes;
  final List<SmsMessageReadCursor> readCursors;
  final bool fetchingHistory;
  final bool historyEndReached;
  final Function(String content) onSendMessage;
  final Function(SmsMessage refMessage) onDelete;
  final Function(DateTime until) userReadedUntilUpdate;
  final Future Function() onFetchHistory;

  @override
  State<SmsMessageListView> createState() => _SmsMessageListViewState();
}

class _SmsMessageListViewState extends State<SmsMessageListView> {
  late final inputController = TextEditingController();
  late final scrollController = ScrollController();

  List<_SmsMessageListViewEntry> viewEntries = [];
  DateTime? computeTime;

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
  void didUpdateWidget(SmsMessageListView oldWidget) {
    super.didUpdateWidget(oldWidget);

    computeViewEntries();
  }

  computeViewEntries() async {
    _ComputeParams params = (
      userId: widget.userId,
      userNumber: widget.userNumber,
      messages: widget.messages,
      outboxMessages: widget.outboxMessages,
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
    final content = inputController.text.trim();
    if (content.isEmpty) return;

    widget.onSendMessage(content);

    inputController.text = '';
    scrollToBottom();
  }

  void handleDelete(SmsMessage message) {
    widget.onDelete(message);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      list(),
      const Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SafeArea(child: MessagingStateWrapper(child: SizedBox())),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: field(),
      ),
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
          stops: [0.0, 0.1, 0.95, 1.0],
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: ScrollToBottomOverlay(
        scrolledAway: scrolledAway,
        onScrollToBottom: scrollToBottom,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView.builder(
            controller: scrollController,
            reverse: true,
            cacheExtent: 500,
            padding: const EdgeInsets.only(top: 16, bottom: 64),
            itemCount: viewEntries.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return BlocBuilder<SmsTypingCubit, TypingNumbers>(
                  builder: (_, numbers) => TypingIndicator(userId: widget.userId, typingNumbers: numbers),
                );
              }
              if (index == viewEntries.length + 1) {
                return HistoryFetchIndicator(widget.fetchingHistory);
              }

              final entry = viewEntries[index - 1];

              if (entry is _MessageViewEntry) {
                return FadeIn(
                  child: SmsMessageView(
                    key: Key(entry.message?.idKey ?? entry.outboxEntry!.idKey),
                    userNumber: widget.userNumber,
                    message: entry.message,
                    outboxMessage: entry.outboxEntry,
                    outboxDeleteEntry: entry.outboxDeleteEntry,
                    userReadedUntil: entry.userReadedUntil,
                    membersReadedUntil: entry.membersReadedUntil,
                    handleDelete: handleDelete,
                    onRendered: () {
                      final message = entry.message;
                      if (message == null) return;

                      final mine = message.fromPhoneNumber == widget.userNumber;
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
      ),
    );
  }

  Widget field() {
    return MessageTextField(
      controller: inputController,
      onSend: handleSend,
      onChanged: (value) => context.read<SmsTypingCubit>().sendTyping(),
    );
  }
}

sealed class _SmsMessageListViewEntry {}

final class _MessageViewEntry extends _SmsMessageListViewEntry {
  final SmsMessage? message;
  final SmsOutboxMessageEntry? outboxEntry;
  final SmsOutboxMessageDeleteEntry? outboxDeleteEntry;
  final DateTime? userReadedUntil;
  final DateTime? membersReadedUntil;

  _MessageViewEntry({
    this.message,
    this.outboxEntry,
    this.outboxDeleteEntry,
    this.userReadedUntil,
    this.membersReadedUntil,
  });
}

final class _DateViewEntry extends _SmsMessageListViewEntry {
  final DateTime date;

  _DateViewEntry({required this.date});
}

typedef _ComputeParams = ({
  String userId,
  String? userNumber,
  List<SmsMessage> messages,
  List<SmsOutboxMessageEntry> outboxMessages,
  List<SmsOutboxMessageDeleteEntry> outboxMessageDeletes,
  List<SmsMessageReadCursor> readCursors,
  DateTime dueTime,
});

typedef _ComputeResult = ({
  List<_SmsMessageListViewEntry> entries,
  DateTime dueTime,
});

_ComputeResult _computeList(_ComputeParams params) {
  final userId = params.userId;
  final messages = params.messages;
  final outboxMessages = params.outboxMessages;
  final outboxMessageDeletes = params.outboxMessageDeletes;
  final readCursors = params.readCursors;
  final dueTime = params.dueTime;

  final userReadedUntil = readCursors.userReadedUntil(userId);
  final membersReadedUntil = readCursors.participantsReadedUntil(userId);

  final entries = <_SmsMessageListViewEntry>[];

  for (final entry in outboxMessages.reversed) {
    entries.add(_MessageViewEntry(outboxEntry: entry));
  }

  for (var i = 0; i <= messages.length - 1; i++) {
    final message = messages[i];
    final newEntry = outboxMessages.firstWhereOrNull((element) => element.idKey == message.idKey);
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
      entries.add(_DateViewEntry(date: message.createdAt));
    }

    entries.add(_MessageViewEntry(
      message: message,
      outboxDeleteEntry: deleteEntry,
      userReadedUntil: userReadedUntil,
      membersReadedUntil: membersReadedUntil,
    ));
  }
  return (entries: entries, dueTime: dueTime);
}
