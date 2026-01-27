part of 'chat_conversations_cubit.dart';

class ChatConversationsState with EquatableMixin {
  final List<ChatWithMessageAndMemebers> conversations;
  final List<ChatWithMessageAndMemebers> conversationsToShow;
  final bool initialising;

  ChatConversationsState(this.conversations, this.conversationsToShow, this.initialising);

  factory ChatConversationsState.initial() => ChatConversationsState([], [], true);

  @override
  List<Object?> get props => [conversations, conversationsToShow, initialising];

  ChatConversationsState copyWith({
    List<ChatWithMessageAndMemebers>? conversations,
    List<ChatWithMessageAndMemebers>? conversationsToShow,
    bool? initialising,
  }) {
    return ChatConversationsState(
      conversations ?? this.conversations,
      conversationsToShow ?? this.conversationsToShow,
      initialising ?? this.initialising,
    );
  }
}

typedef ChatWithMessageAndMemebers = ({Chat chat, ChatMessage? message, List<Contact> contacts});
