import 'dart:convert';
import 'package:equatable/equatable.dart';

import 'chat_member.dart';

class Chat extends Equatable {
  final int id;
  final ChatType type;
  final String? name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ChatMember> members;

  const Chat({
    required this.id,
    required this.type,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.members,
  });

  bool isDialogWith(String participantId) {
    return type == ChatType.direct && members.any((member) => member.userId == participantId);
  }

  @override
  List<Object?> get props => [id, type, name, createdAt, updatedAt, members];

  @override
  bool get stringify => true;

  Chat copyWith({
    int? id,
    ChatType? type,
    String? name,
    String? creatorId,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<ChatMember>? members,
  }) {
    return Chat(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type.name,
      'name': name,
      'inserted_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'members': members.map((x) => x.toMap()).toList(),
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    // Backward compatibility for the old 'dialog' type
    // TODO: Remove someday
    if (map['type'] == 'dialog') map['type'] = 'direct';

    return Chat(
      id: map['id'] as int,
      type: ChatType.values.byName(map['type']),
      name: map['name'] != null ? map['name'] as String : null,
      createdAt: DateTime.parse(map['inserted_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      members: List<ChatMember>.from(
        (map['members'] as List<dynamic>).map<ChatMember>(
          (x) => ChatMember.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum ChatType { direct, group }

extension ChatListExtension<T extends Chat> on List<T> {
  T findById(int id) => firstWhere((element) => element.id == id);

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
