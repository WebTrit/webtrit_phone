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
}

enum ChatType { dialog, group }
