part of 'chat_conversations_cubit.dart';

class ChatConversationsState with EquatableMixin {
  final List<(Chat, ChatMessage?)> conversations;
  final bool initialising;

  ChatConversationsState(this.conversations, this.initialising);

  factory ChatConversationsState.initial() => ChatConversationsState([], true);

  @override
  List<Object> get props => [conversations, initialising];

  ChatConversationsState copyWith({List<(Chat, ChatMessage?)>? conversations, bool? initialising}) {
    return ChatConversationsState(conversations ?? this.conversations, initialising ?? this.initialising);
  }
}
