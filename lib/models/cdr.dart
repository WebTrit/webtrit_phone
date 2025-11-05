import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/models/models.dart';

enum CdrStatus { accepted, declined, missed, error }

class CdrRecord extends Equatable {
  final String callId;
  final CallDirection direction;
  final CdrStatus status;
  final String callee;
  final String? calleeNumber;
  final String caller;
  final String? callerNumber;
  final DateTime connectTime;
  final DateTime disconnectTime;
  final String disconnectReason;
  final Duration duration;
  final dynamic recordingId;

  CdrRecord({
    required this.callId,
    required this.direction,
    required this.status,
    required this.callee,
    required this.calleeNumber,
    required this.caller,
    required this.callerNumber,
    required this.connectTime,
    required this.disconnectTime,
    required this.disconnectReason,
    required this.duration,
    this.recordingId,
  });

  /// The other party in the call, depending on the call direction
  late final String participant = direction == CallDirection.outgoing ? callee : caller;

  /// The other party's number in the call, depending on the call direction
  late final String? participantNumber = direction == CallDirection.outgoing ? calleeNumber : callerNumber;

  @override
  List<Object?> get props => [
    callId,
    direction,
    status,
    callee,
    calleeNumber,
    caller,
    callerNumber,
    connectTime,
    disconnectTime,
    disconnectReason,
    duration,
    recordingId,
  ];
  @override
  String toString() =>
      'CdrRecord(callId: $callId, direction: $direction, status: $status, callee: $callee, calleeNumber: $calleeNumber, caller: $caller, callerNumber: $callerNumber, connectTime: $connectTime, disconnectTime: $disconnectTime, disconnectReason: $disconnectReason, duration: $duration, recordingId: $recordingId)';
}

extension CdrRecordIterableExtension on Iterable<CdrRecord> {
  Iterable<CdrRecord> mergeWithUpdate(CdrRecord v) {
    final isNew = !any((n) => n.callId == v.callId);
    if (isNew) {
      return [v, ...this];
    } else {
      return map((n) => n.callId == v.callId ? v : n);
    }
  }

  Iterable<CdrRecord> mergeWithRemove(String callId) {
    return where((n) => n.callId != callId);
  }

  Iterable<CdrRecord> mergeWithHistory(Iterable<CdrRecord> history) {
    return [...this, ...history];
  }
}
