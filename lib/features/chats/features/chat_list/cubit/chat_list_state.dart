part of 'chat_list_cubit.dart';

class ChatListState {
  final List<String> chats;
  final bool initialising;

  ChatListState({required this.chats, required this.initialising});

  factory ChatListState.initial() => ChatListState(chats: [], initialising: true);
}
