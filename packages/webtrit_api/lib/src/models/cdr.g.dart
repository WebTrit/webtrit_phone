// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cdr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CdrRecord _$CdrRecordFromJson(Map<String, dynamic> json) => CdrRecord(
      callId: json['call_id'] as String,
      callee: json['callee'] as String,
      caller: json['caller'] as String,
      connectTime: DateTime.parse(json['connect_time'] as String),
      direction: json['direction'] as String,
      disconnectReason: json['disconnect_reason'] as String,
      disconnectTime: DateTime.parse(json['disconnect_time'] as String),
      duration: (json['duration'] as num).toInt(),
      recordingId: json['recording_id'],
      status: json['status'] as String,
    );

Map<String, dynamic> _$CdrRecordToJson(CdrRecord instance) => <String, dynamic>{
      'call_id': instance.callId,
      'callee': instance.callee,
      'caller': instance.caller,
      'connect_time': instance.connectTime.toIso8601String(),
      'direction': instance.direction,
      'disconnect_reason': instance.disconnectReason,
      'disconnect_time': instance.disconnectTime.toIso8601String(),
      'duration': instance.duration,
      'recording_id': instance.recordingId,
      'status': instance.status,
    };

CdrHistoryResponse _$CdrHistoryResponseFromJson(Map<String, dynamic> json) =>
    CdrHistoryResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => CdrRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CdrHistoryResponseToJson(CdrHistoryResponse instance) =>
    <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
