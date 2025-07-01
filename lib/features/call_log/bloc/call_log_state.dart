part of 'call_log_bloc.dart';

@freezed
class CallLogState with _$CallLogState {
  const factory CallLogState({
    required String number,
    Contact? contact,
    List<CallLogEntry>? callLog,
  }) = _CallLogState;

  @override
  toString() {
    return 'CallLogState {number: $number, contact: $contact, callLog: ${callLog?.length ?? 0}}';
  }
}
