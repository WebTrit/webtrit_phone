part of 'conversation_cubit.dart';

/// Base class for the states of the conversation cubit.
abstract base class ConversationState {
  const ConversationState();

  /// The id of the participant in the conversation
  String get participantId;
}

/// Represents the state of the conversation cubit when preparing the conversation.
final class CvnPreparing extends ConversationState with EquatableMixin {
  const CvnPreparing(this.participantId);

  @override
  final String participantId;

  @override
  List<Object> get props => [participantId];
}

/// Represents the state of the conversation cubit when an error occurred.
final class CvnError extends ConversationState with EquatableMixin {
  const CvnError(this.participantId, this.error);

  @override
  final String participantId;

  final Object error;

  @override
  List<Object> get props => [participantId, error];
}

/// Represents the state of the conversation cubit when the conversation is ready.
final class CvnReady extends ConversationState with EquatableMixin {
  const CvnReady(this.participantId, this.channel);

  @override
  final String participantId;

  final Channel channel;

  @override
  List<Object> get props => [participantId, channel];
}
