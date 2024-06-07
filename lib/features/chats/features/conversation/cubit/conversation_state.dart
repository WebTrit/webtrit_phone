part of 'conversation_cubit.dart';

/// Base class for the states of the conversation cubit.
abstract base class ConversationState {
  const ConversationState();

  /// The id of the participant in the conversation
  String get participantId;
}

/// Represents the state of the conversation cubit when preparing the conversation.
final class CVSPreparing extends ConversationState with EquatableMixin {
  const CVSPreparing(this.participantId);

  @override
  final String participantId;

  @override
  List<Object> get props => [participantId];
}

/// Represents the state of the conversation cubit when an error occurred.
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
  const CVSReady(this.participantId);

  @override
  final String participantId;

  @override
  List<Object> get props => [participantId];
}
