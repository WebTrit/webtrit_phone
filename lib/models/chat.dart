// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

import 'chat_member.dart';

class Chat extends Equatable {
  final int id;
  final ChatType type;
  final String? name;
  final String creatorId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<ChatMember> members;

  const Chat({
    required this.id,
    required this.type,
    required this.name,
    required this.creatorId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.members,
  });

  @override
  List<Object?> get props => [id, type, name, creatorId, createdAt, updatedAt, deletedAt, members];

  @override
  bool get stringify => true;

  Chat copyWith({
    int? id,
    ChatType? type,
    String? name,
    String? creatorId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<ChatMember>? members,
  }) {
    return Chat(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type.name,
      'name': name,
      'creator_id': creatorId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'members': members.map((x) => x.toMap()).toList(),
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'] as int,
      type: ChatType.values.byName(map['type']),
      name: map['name'] != null ? map['name'] as String : null,
      creatorId: map['creator_id'] as String,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      deletedAt: map['deleted_at'] != null ? DateTime.parse(map['deleted_at']) : null,
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

enum ChatType { dialog, group }
