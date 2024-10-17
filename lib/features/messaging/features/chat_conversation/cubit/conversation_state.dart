part of 'conversation_cubit.dart';

typedef ChatCredentials = ({
  /// ID of known chat conversationn, can be null for virtual dialog conversation
  /// e.g. chat is not created explicitly, but will created by sending first message
  int? chatId,

  /// ID of user, if its dialog conversation with
  String? participantId,
});

/// Base class for the states of the conversation cubit.
sealed class ConversationState with EquatableMixin {
  const ConversationState(this.credentials);
  final ChatCredentials credentials;

  factory ConversationState.init(ChatCredentials credentials) => CVSInit(credentials);
  factory ConversationState.left(ChatCredentials credentials) => CVSLeft(credentials);
  factory ConversationState.error(ChatCredentials credentials, Object error) {
    return CVSError(credentials, error);
  }
  factory ConversationState.ready(ChatCredentials credentials, {Chat? chat}) {
    return CVSReady(credentials, chat: chat);
  }

  @override
  List<Object> get props => [credentials];
}

/// Represents the state of the conversation cubit when preparing the conversation.
/// E.g fetching the chat id, messages, etc.
final class CVSInit extends ConversationState {
  const CVSInit(super.credentials);
}

/// Represents the state of the conversation after user leaved/removed.
final class CVSLeft extends ConversationState {
  const CVSLeft(super.credentials);
}

/// Represents the error state of the conversation during the initialization.
final class CVSError extends ConversationState {
  const CVSError(super.credentials, this.error);

  final Object error;

  @override
  List<Object> get props => [credentials, error];
}

/// Represents the state of the conversation cubit when the conversation is ready.
final class CVSReady extends ConversationState {
  const CVSReady(
    super.credentials, {
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
        credentials,
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
    ChatCredentials? credentials,
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
      credentials ?? this.credentials,
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
