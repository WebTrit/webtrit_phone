import 'package:equatable/equatable.dart';

import 'favorite.dart';

enum FavoriteOutboxActionType { upsert, delete }

class FavoriteOutboxAction extends Equatable {
  const FavoriteOutboxAction({
    required this.action,
    required this.number,
    required this.sourceType,
    this.sourceId,
    this.label,
    this.position,
    this.sendAttempts = 0,
    this.timestampUsec,
  });

  final FavoriteOutboxActionType action;
  final String number;
  final FavoriteSourceType sourceType;
  final String? sourceId;
  final String? label;
  final int? position;
  final int sendAttempts;
  final int? timestampUsec;

  FavoriteOutboxAction copyWith({
    FavoriteOutboxActionType? action,
    String? number,
    FavoriteSourceType? sourceType,
    String? sourceId,
    String? label,
    int? position,
    int? sendAttempts,
    int? timestampUsec,
  }) {
    return FavoriteOutboxAction(
      action: action ?? this.action,
      number: number ?? this.number,
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      label: label ?? this.label,
      position: position ?? this.position,
      sendAttempts: sendAttempts ?? this.sendAttempts,
      timestampUsec: timestampUsec ?? this.timestampUsec,
    );
  }

  @override
  List<Object?> get props => [action, number, sourceType, sourceId, label, position, sendAttempts, timestampUsec];
}
