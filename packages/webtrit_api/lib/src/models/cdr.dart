import 'package:freezed_annotation/freezed_annotation.dart';

part 'cdr.freezed.dart';

part 'cdr.g.dart';

@freezed
class CdrRecord with _$CdrRecord {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CdrRecord({
    required String callId,
    required String callee,
    required String caller,
    required DateTime connectTime,
    required String direction,
    required String disconnectReason,
    required DateTime disconnectTime,
    required int duration,
    // TODO: fix once backend side, sometimes it's int, sometimes it's string
    dynamic recordingId,
    required String status,
  }) = _CdrRecord;

  factory CdrRecord.fromJson(Map<String, Object?> json) => _$CdrRecordFromJson(json);
}

@freezed
class CdrHistoryResponse with _$CdrHistoryResponse {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CdrHistoryResponse({required List<CdrRecord> items}) = _CdrHistoryResponse;
  factory CdrHistoryResponse.fromJson(Map<String, Object?> json) => _$CdrHistoryResponseFromJson(json);
}
