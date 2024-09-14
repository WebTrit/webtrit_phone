part of 'conversation_cubit.dart';

/// recipientId should be removed as soon as possible when backend will be ready
/// to avoid unsecurity bullshit from the backend side
typedef UsersCreds = ({String firstNumber, String secondNumber, String? recipientId});

/// Base class for the states of the conversation cubit.
abstract base class ConversationState {
  const ConversationState();

  /// The id of the participant in the conversation
  UsersCreds get creds;

  factory ConversationState.init(UsersCreds creds) => CVSInit(creds);
  factory ConversationState.error(UsersCreds creds, Object error) => CVSError(creds, error);
  factory ConversationState.left(UsersCreds creds) => CVSLeft(creds);
  factory ConversationState.ready(UsersCreds creds, {SmsConversation? conversation}) {
    return CVSReady(creds, conversation: conversation);
  }
}

/// Represents the state of the conversation cubit when preparing the conversation.
/// E.g fetching the chat id, messages, etc.
final class CVSInit extends ConversationState with EquatableMixin {
  const CVSInit(this.creds);

  @override
  final UsersCreds creds;

  @override
  List<Object> get props => [creds];
}

/// Represents the error state of the conversation during the initialization.
final class CVSError extends ConversationState with EquatableMixin {
  const CVSError(this.creds, this.error);

  @override
  final UsersCreds creds;

  final Object error;

  @override
  List<Object> get props => [creds, error];
}

/// Represents the state of the conversation after user leaved/removed.
final class CVSLeft extends ConversationState with EquatableMixin {
  const CVSLeft(this.creds);

  @override
  final UsersCreds creds;

  @override
  List<Object> get props => [creds];
}

/// Represents the state of the conversation cubit when the conversation is ready.
final class CVSReady extends ConversationState with EquatableMixin {
  const CVSReady(
    this.creds, {
    this.conversation,
    this.messages = const [],
    this.outboxMessages = const [],
    this.fetchingHistory = false,
    this.historyEndReached = false,
    this.busy = false,
  });

  @override
  final UsersCreds creds;
  final SmsConversation? conversation;
  final List<SmsMessage> messages;
  final List<SmsOutboxMessageEntry> outboxMessages;

  final bool fetchingHistory;
  final bool historyEndReached;
  final bool busy;

  @override
  List<Object> get props => [
        creds,
        conversation ?? 0,
        messages,
        outboxMessages,
        fetchingHistory,
        historyEndReached,
        busy,
      ];

  copyWith({
    UsersCreds? creds,
    SmsConversation? conversation,
    List<SmsMessage>? messages,
    List<SmsOutboxMessageEntry>? outboxMessages,
    bool? fetchingHistory,
    bool? historyEndReached,
    bool? busy,
  }) {
    return CVSReady(
      creds ?? this.creds,
      conversation: conversation ?? this.conversation,
      messages: messages ?? this.messages,
      outboxMessages: outboxMessages ?? this.outboxMessages,
      fetchingHistory: fetchingHistory ?? this.fetchingHistory,
      historyEndReached: historyEndReached ?? this.historyEndReached,
      busy: busy ?? this.busy,
    );
  }
}
