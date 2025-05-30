import 'package:equatable/equatable.dart';

enum SystemNotificationType { announcement, promotion, security, system }

class SystemNotification extends Equatable {
  const SystemNotification({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.seen,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final String content;
  final SystemNotificationType type;
  final bool seen;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [id, title, content, type, seen, createdAt, updatedAt];

  @override
  String toString() {
    return 'SystemNotification(id: $id, title: $title, content: $content, type: $type, seen: $seen, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  SystemNotification copyWith({
    int? id,
    String? title,
    String? content,
    SystemNotificationType? type,
    bool? seen,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SystemNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      type: type ?? this.type,
      seen: seen ?? this.seen,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
