import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/models/models.dart';

enum SmsSendingStatus { waiting, sent, failed, delivered }

class SmsMessage extends Equatable {
  final int id;
  final String idKey;
  final String? externalId;
  final int conversationId;
  final String fromPhoneNumber;
  final String toPhoneNumber;
  final SmsSendingStatus sendingStatus;
  final String content;
  final List<MessageAttachment> attachments;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const SmsMessage({
    required this.id,
    required this.idKey,
    required this.externalId,
    required this.conversationId,
    required this.fromPhoneNumber,
    required this.toPhoneNumber,
    required this.sendingStatus,
    required this.content,
    required this.attachments,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  @override
  List<Object?> get props => [
        id,
        idKey,
        externalId,
        conversationId,
        fromPhoneNumber,
        toPhoneNumber,
        sendingStatus,
        content,
        attachments,
        createdAt,
        updatedAt,
        deletedAt,
      ];

  @override
  bool get stringify => true;
}

extension SmsMessageListExtension<T extends SmsMessage> on List<T> {
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
