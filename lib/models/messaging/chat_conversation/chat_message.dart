import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final int id;
  final String idKey;
  final String senderId;
  final int chatId;
  final int? replyToId;
  final int? forwardFromId;
  final String? authorId;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? editedAt;
  final DateTime? deletedAt;

  const ChatMessage({
    required this.id,
    required this.idKey,
    required this.senderId,
    required this.chatId,
    required this.replyToId,
    required this.forwardFromId,
    required this.authorId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.editedAt,
    required this.deletedAt,
  });

  @override
  List<Object?> get props => [
    id,
    idKey,
    senderId,
    chatId,
    replyToId,
    forwardFromId,
    authorId,
    content,
    createdAt,
    updatedAt,
    editedAt,
    deletedAt,
  ];

  @override
  String toString() {
    return 'ChatMessage(id: $id, idKey: $idKey, senderId: $senderId, chatId: $chatId, replyToId: $replyToId, forwardFromId: $forwardFromId, authorId: $authorId, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, editedAt: $editedAt, deletedAt: $deletedAt)';
  }
}

extension MessagesListExtension<T extends ChatMessage> on List<T> {
  T findById(int id) => firstWhere((element) => element.id == id);

  List<T> mergeWith(T message) {
    final newList = List<T>.from(this);

    final index = newList.indexWhere((element) => element.id == message.id);
    if (index == -1) {
      newList.add(message);
    } else {
      newList[index] = message;
    }
    return newList;
  }

  /// Merge the real-time message update(new,edit,viewed) with the list of messages in a view
  List<T> mergeUpdateWith(T message) {
    final newList = List<T>.from(this);

    // If empty list, return the message
    if (newList.isEmpty) return [message];

    // If the message is an update, replace the old message in the list
    final index = newList.indexWhere((m) => m.id == message.id);
    if (index != -1) {
      newList[index] = message;
      return newList;
    }

    // If the message is a new message, add it to the head of the list
    if (message.createdAt.isAfter(newList.first.createdAt)) {
      return [message, ...newList];
    }

    // If the message is an update for a message that is not included in the list,
    // skip it if the message is older than the last message in the list (views,edits,replies of non-fetched history)
    // otherwise, add and sort the list
    if (message.createdAt.isAfter(newList.last.createdAt)) {
      newList.add(message);
      newList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return newList;
    }

    return this;
  }
}
