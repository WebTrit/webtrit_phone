import 'package:equatable/equatable.dart';

class SystemNotification extends Equatable {
  const SystemNotification({
    required this.id,
    required this.title,
    required this.content,
    required this.seen,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final String content;
  final bool seen;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [id, title, content, seen, createdAt, updatedAt];

  @override
  String toString() {
    return 'SystemNotification(id: $id, title: $title, content: $content, seen: $seen, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  SystemNotification copyWith({
    int? id,
    String? title,
    String? content,
    bool? seen,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SystemNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      seen: seen ?? this.seen,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
