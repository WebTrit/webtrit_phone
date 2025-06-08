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

  isConversationBetween(String firstNumber, String secondNumber) {
    return (firstPhoneNumber == firstNumber && secondPhoneNumber == secondNumber) ||
        (firstPhoneNumber == secondNumber && secondPhoneNumber == firstNumber);
  }

  @override
  List<Object?> get props => [id, firstPhoneNumber, secondPhoneNumber, createdAt, updatedAt];

  @override
  String toString() {
    return 'SmsConversation(id: $id, firstPhoneNumber: $firstPhoneNumber, secondPhoneNumber: $secondPhoneNumber, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
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
