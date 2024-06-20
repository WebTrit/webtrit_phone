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
    this.outboxQueue = const [],
    this.fetchingHistory = false,
    this.historyEndReached = false,
  });

  @override
  final String participantId;
  final List<ChatMessage> messages;
  final List<ChatQueueEntry> outboxQueue;

  final bool fetchingHistory;
  final bool historyEndReached;

  @override
  List<Object> get props => [participantId, messages, outboxQueue, fetchingHistory, historyEndReached];

  copyWith({
    String? participantId,
    List<ChatMessage>? messages,
    List<ChatQueueEntry>? outboxQueue,
    bool? fetchingHistory,
    bool? historyEndReached,
  }) {
    return CVSReady(
      participantId ?? this.participantId,
      messages: messages ?? this.messages,
      outboxQueue: outboxQueue ?? this.outboxQueue,
      fetchingHistory: fetchingHistory ?? this.fetchingHistory,
      historyEndReached: historyEndReached ?? this.historyEndReached,
    );
  }
}
