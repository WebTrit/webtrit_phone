part of 'conversation_cubit.dart';

/// Base class for the states of the conversation cubit.
abstract base class ConversationState {
  const ConversationState();

  /// The id of the participant in the conversation
  String get participantId;

  factory ConversationState.init(String participantId) => CVSInit(participantId);
  factory ConversationState.error(String participantId, Object error) => CVSError(participantId, error);
  factory ConversationState.left(String participantId) => CVSLeft(participantId);
  factory ConversationState.ready(String participantId, {Chat? chat}) {
    return CVSReady(participantId, chat: chat);
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

/// Represents the state of the conversation after user leaved/removed.
final class CVSLeft extends ConversationState with EquatableMixin {
  const CVSLeft(this.participantId);

  @override
  final String participantId;

  @override
  List<Object> get props => [participantId];
}

/// Represents the state of the conversation cubit when the conversation is ready.
final class CVSReady extends ConversationState with EquatableMixin {
  const CVSReady(
    this.participantId, {
    this.chat,
    this.messages = const [],
    this.outboxMessages = const [],
    this.outboxMessageEdits = const [],
    this.outboxMessageDeletes = const [],
    this.readCursors = const [],
    this.fetchingHistory = false,
    this.historyEndReached = false,
    this.busy = false,
  });

  @override
  final String participantId;
  final Chat? chat;
  final List<ChatMessage> messages;
  final List<ChatOutboxMessageEntry> outboxMessages;
  final List<ChatOutboxMessageEditEntry> outboxMessageEdits;
  final List<ChatOutboxMessageDeleteEntry> outboxMessageDeletes;
  final List<ChatMessageReadCursor> readCursors;

  final bool fetchingHistory;
  final bool historyEndReached;
  final bool busy;

  @override
  List<Object> get props => [
        participantId,
        chat ?? 0,
        messages,
        outboxMessages,
        outboxMessageEdits,
        outboxMessageDeletes,
        readCursors,
        fetchingHistory,
        historyEndReached,
        busy,
      ];

  copyWith({
    String? participantId,
    Chat? chat,
    List<ChatMessage>? messages,
    List<ChatOutboxMessageEntry>? outboxMessages,
    List<ChatOutboxMessageEditEntry>? outboxMessageEdits,
    List<ChatOutboxMessageDeleteEntry>? outboxMessageDeletes,
    List<ChatMessageReadCursor>? readCursors,
    bool? fetchingHistory,
    bool? historyEndReached,
    bool? busy,
  }) {
    return CVSReady(
      participantId ?? this.participantId,
      chat: chat ?? this.chat,
      messages: messages ?? this.messages,
      outboxMessages: outboxMessages ?? this.outboxMessages,
      outboxMessageEdits: outboxMessageEdits ?? this.outboxMessageEdits,
      outboxMessageDeletes: outboxMessageDeletes ?? this.outboxMessageDeletes,
      readCursors: readCursors ?? this.readCursors,
      fetchingHistory: fetchingHistory ?? this.fetchingHistory,
      historyEndReached: historyEndReached ?? this.historyEndReached,
      busy: busy ?? this.busy,
    );
  }
}
