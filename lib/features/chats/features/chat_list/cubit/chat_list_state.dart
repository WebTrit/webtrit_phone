part of 'chat_list_cubit.dart';

class ChatListState with EquatableMixin {
  final List<(Chat, ChatMessage?)> chats;
  final List<(Chat, ChatMessage?)> smsChats;
  final bool initialising;

  ChatListState(this.chats, this.smsChats, this.initialising);

  factory ChatListState.initial() => ChatListState([], [], true);

  @override
  List<Object> get props => [chats, initialising];

  ChatListState copyWith({
    List<(Chat, ChatMessage?)>? chats,
    List<(Chat, ChatMessage?)>? smsChats,
    bool? initialising,
  }) {
    return ChatListState(
      chats ?? this.chats,
      smsChats ?? this.smsChats,
      initialising ?? this.initialising,
    );
  }
}
