import 'dart:convert';
import 'package:equatable/equatable.dart';

enum SmsSendingStatus { waiting, sent, failed, delivered }

class SmsMessage extends Equatable {
  final int id;
  final String idKey;
  final String externalId;
  final int conversationId;
  final String fromPhoneNumber;
  final String toPhoneNumber;
  final SmsSendingStatus sendingStatus;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SmsMessage({
    required this.id,
    required this.idKey,
    required this.externalId,
    required this.conversationId,
    required this.fromPhoneNumber,
    required this.toPhoneNumber,
    required this.sendingStatus,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
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
        createdAt,
        updatedAt,
      ];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idempotency_key': idKey,
      'external_id': externalId,
      'sms_conversation_id': conversationId,
      'from_phone_number': fromPhoneNumber,
      'to_phone_number': toPhoneNumber,
      'sending_status': sendingStatus.name,
      'content': content,
      'inserted_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory SmsMessage.fromMap(Map<String, dynamic> map) {
    return SmsMessage(
      id: map['id'] as int,
      idKey: map['idempotency_key'] as String,
      externalId: map['external_id'] as String,
      conversationId: map['sms_conversation_id'] as int,
      fromPhoneNumber: map['from_phone_number'] as String,
      toPhoneNumber: map['to_phone_number'] as String,
      sendingStatus: SmsSendingStatus.values.byName(map['sending_status'] as String),
      content: map['content'] as String,
      createdAt: DateTime.parse(map['inserted_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory SmsMessage.fromJson(String source) => SmsMessage.fromMap(json.decode(source) as Map<String, dynamic>);
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
