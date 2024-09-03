part of 'chat_list_cubit.dart';

class ChatListState with EquatableMixin {
  final List<(Chat, ChatMessage?)> chats;
  final bool initialising;

  ChatListState({required this.chats, required this.initialising});

  factory ChatListState.initial() => ChatListState(chats: [], initialising: true);

  @override
  List<Object> get props => [chats, initialising];

  ChatListState copyWith({
    List<(Chat, ChatMessage?)>? chats,
    bool? initialising,
  }) {
    return ChatListState(
      chats: chats ?? this.chats,
      initialising: initialising ?? this.initialising,
    );
  }
}
