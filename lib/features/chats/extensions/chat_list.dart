import 'package:webtrit_phone/models/chat.dart';

extension ChatListIterableExtension<T extends Chat> on Iterable<T> {
  T findById(int id) => firstWhere((element) => element.id == id);

  List<T> mergeWith(T chat) {
    final chats = toList();
    final index = chats.indexWhere((element) => element.id == chat.id);
    if (index == -1) {
      chats.add(chat);
    } else {
      chats[index] = chat;
    }
    return chats;
  }
}
