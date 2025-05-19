import 'package:equatable/equatable.dart';

class SystemNotification extends Equatable {
  const SystemNotification({
    required this.title,
    required this.body,
    required this.dateTime,
    this.readAt,
  });

  final String title;
  final String body;
  final DateTime dateTime;
  final DateTime? readAt;

  @override
  List<Object?> get props => [title, body, dateTime, readAt];

  @override
  String toString() {
    return 'SystemNotification(title: $title, body: $body, dateTime: $dateTime, readAt: $readAt)';
  }

  SystemNotification copyWith({
    String? title,
    String? body,
    DateTime? dateTime,
    DateTime? readAt,
  }) {
    return SystemNotification(
      title: title ?? this.title,
      body: body ?? this.body,
      dateTime: dateTime ?? this.dateTime,
      readAt: readAt ?? this.readAt,
    );
  }
}
