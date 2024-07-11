part of 'group_cubit.dart';

/// Base class for the states of the group cubit.
abstract base class GroupState {
  const GroupState();
  int get chatId;

  factory GroupState.init(int chatId) => GroupStateInit(chatId);
  factory GroupState.error(int chatId, Object error) => GroupStateError(chatId, error);
  factory GroupState.ready(int chatId, Chat chat, {List<ChatMessage> messages = const []}) {
    return GroupStateReady(chatId, chat, messages: messages);
  }
}

/// Represents the state of the group cubit when preparing the group.
/// E.g fetching the chat id, messages, etc.
final class GroupStateInit extends GroupState with EquatableMixin {
  const GroupStateInit(this.chatId);

  @override
  final int chatId;

  @override
  List<Object> get props => [chatId];
}

/// Represents the error state of the group during the initialization.
final class GroupStateError extends GroupState with EquatableMixin {
  const GroupStateError(this.chatId, this.error);

  @override
  final int chatId;

  final Object error;

  @override
  List<Object> get props => [chatId, error];
}

/// Represents the state of the group cubit when the group is ready.
final class GroupStateReady extends GroupState with EquatableMixin {
  const GroupStateReady(
    this.chatId,
    this.chat, {
    this.messages = const [],
    this.outboxMessages = const [],
    this.outboxMessageEdits = const [],
    this.outboxMessageDeletes = const [],
    this.fetchingHistory = false,
    this.historyEndReached = false,
  });

  @override
  final int chatId;
  final Chat chat;

  final List<ChatMessage> messages;
  final List<ChatOutboxMessageEntry> outboxMessages;
  final List<ChatOutboxMessageEditEntry> outboxMessageEdits;
  final List<ChatOutboxMessageDeleteEntry> outboxMessageDeletes;

  final bool fetchingHistory;
  final bool historyEndReached;

  @override
  List<Object> get props => [
        chatId,
        chat,
        messages,
        outboxMessages,
        outboxMessageEdits,
        outboxMessageDeletes,
        fetchingHistory,
        historyEndReached,
      ];

  copyWith({
    int? chatId,
    Chat? chat,
    List<ChatMessage>? messages,
    List<ChatOutboxMessageEntry>? outboxMessages,
    List<ChatOutboxMessageEditEntry>? outboxMessageEdits,
    List<ChatOutboxMessageDeleteEntry>? outboxMessageDeletes,
    bool? fetchingHistory,
    bool? historyEndReached,
  }) {
    return GroupStateReady(
      chatId ?? this.chatId,
      chat ?? this.chat,
      messages: messages ?? this.messages,
      outboxMessages: outboxMessages ?? this.outboxMessages,
      outboxMessageEdits: outboxMessageEdits ?? this.outboxMessageEdits,
      outboxMessageDeletes: outboxMessageDeletes ?? this.outboxMessageDeletes,
      fetchingHistory: fetchingHistory ?? this.fetchingHistory,
      historyEndReached: historyEndReached ?? this.historyEndReached,
    );
  }
}
