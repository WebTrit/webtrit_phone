import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class SmsConversation extends Equatable {
  final int id;
  final String firstPhoneNumber;
  final String secondPhoneNumber;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SmsConversation({
    required this.id,
    required this.firstPhoneNumber,
    required this.secondPhoneNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, firstPhoneNumber, secondPhoneNumber, createdAt, updatedAt];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'first_phone_number': firstPhoneNumber,
      'second_phone_number': secondPhoneNumber,
      'inserted_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory SmsConversation.fromMap(Map<String, dynamic> map) {
    return SmsConversation(
      id: map['id'] as int,
      firstPhoneNumber: map['first_phone_number'] as String,
      secondPhoneNumber: map['second_phone_number'] as String,
      createdAt: DateTime.parse(map['inserted_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SmsConversation.fromJson(String source) =>
      SmsConversation.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension SmsConversationListExtension<T extends SmsConversation> on List<T> {
  T? findById(int id) => firstWhereOrNull((element) => element.id == id);

  T? findByPhoneNubmer(String number) {
    return firstWhereOrNull((e) => e.firstPhoneNumber == number || e.secondPhoneNumber == number);
  }

  List<T> copyMerge(T chat) {
    final newList = List<T>.from(this);

    final index = newList.indexWhere((element) => element.id == chat.id);
    if (index == -1) {
      newList.add(chat);
    } else {
      newList[index] = chat;
    }
    return newList;
  }

  List<T> copyRemove(int chatId) {
    return where((chat) => chat.id != chatId).toList();
  }
}
