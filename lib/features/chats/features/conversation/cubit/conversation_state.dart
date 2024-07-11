part of 'conversation_cubit.dart';

/// Base class for the states of the conversation cubit.
abstract base class ConversationState {
  const ConversationState();

  /// The id of the participant in the conversation
  String get participantId;

  factory ConversationState.init(String participantId) => CVSInit(participantId);
  factory ConversationState.error(String participantId, Object error) => CVSError(participantId, error);
  factory ConversationState.ready(String participantId, {List<ChatMessage> messages = const []}) {
    return CVSReady(participantId, messages: messages);
  }
}

/// Represents the state of the conversation cubit when preparing the conversation.
/// E.g fetching the chat id, messages, etc.
final class CVSInit extends ConversationState with EquatableMixin {
  const CVSInit(this.participantId);

  @override
  final String participantId;

  @override
  List<Object> get props => [participantId];
}

/// Represents the error state of the conversation during the initialization.
final class CVSError extends ConversationState with EquatableMixin {
  const CVSError(this.participantId, this.error);

  @override
  final String participantId;

  final Object error;

  @override
  List<Object> get props => [participantId, error];
}

/// Represents the state of the conversation cubit when the conversation is ready.
final class CVSReady extends ConversationState with EquatableMixin {
  const CVSReady(
    this.participantId, {
    this.messages = const [],
    this.outboxMessages = const [],
    this.outboxMessageEdits = const [],
    this.outboxMessageDeletes = const [],
    this.fetchingHistory = false,
    this.historyEndReached = false,
  });

  @override
  final String participantId;
  final List<ChatMessage> messages;
  final List<ChatOutboxMessageEntry> outboxMessages;
  final List<ChatOutboxMessageEditEntry> outboxMessageEdits;
  final List<ChatOutboxMessageDeleteEntry> outboxMessageDeletes;

  final bool fetchingHistory;
  final bool historyEndReached;

  @override
  List<Object> get props => [
        participantId,
        messages,
        outboxMessages,
        outboxMessageEdits,
        outboxMessageDeletes,
        fetchingHistory,
        historyEndReached,
      ];

  copyWith({
    String? participantId,
    List<ChatMessage>? messages,
    List<ChatOutboxMessageEntry>? outboxMessages,
    List<ChatOutboxMessageEditEntry>? outboxMessageEdits,
    List<ChatOutboxMessageDeleteEntry>? outboxMessageDeletes,
    bool? fetchingHistory,
    bool? historyEndReached,
  }) {
    return CVSReady(
      participantId ?? this.participantId,
      messages: messages ?? this.messages,
      outboxMessages: outboxMessages ?? this.outboxMessages,
      outboxMessageEdits: outboxMessageEdits ?? this.outboxMessageEdits,
      outboxMessageDeletes: outboxMessageDeletes ?? this.outboxMessageDeletes,
      fetchingHistory: fetchingHistory ?? this.fetchingHistory,
      historyEndReached: historyEndReached ?? this.historyEndReached,
    );
  }
}
