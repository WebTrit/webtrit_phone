import 'package:freezed_annotation/freezed_annotation.dart';

part 'cdr.freezed.dart';

part 'cdr.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CdrRecord with _$CdrRecord {
  const CdrRecord({
    required this.callId,
    required this.callee,
    required this.caller,
    required this.connectTime,
    required this.direction,
    required this.disconnectReason,
    required this.disconnectTime,
    required this.duration,
    this.recordingId,
    required this.status,
  });

  @override
  final String callId;

  @override
  final String callee;

  @override
  final String caller;

  @override
  final DateTime connectTime;

  @override
  final String direction;

  @override
  final String disconnectReason;

  @override
  final DateTime disconnectTime;

  @override
  final int duration;

  @override
  final dynamic recordingId;

  @override
  final String status;

  factory CdrRecord.fromJson(Map<String, Object?> json) =>
      _$CdrRecordFromJson(json);

  Map<String, Object?> toJson() => _$CdrRecordToJson(this);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CdrHistoryResponse with _$CdrHistoryResponse {
  const CdrHistoryResponse({required this.items});

  @override
  final List<CdrRecord> items;

  factory CdrHistoryResponse.fromJson(Map<String, Object?> json) =>
      _$CdrHistoryResponseFromJson(json);

  Map<String, Object?> toJson() => _$CdrHistoryResponseToJson(this);
}
