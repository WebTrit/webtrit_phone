part of 'call_log_bloc.dart';

@freezed
class CallLogState with _$CallLogState {
  const CallLogState({required this.number, this.contact, this.callLog});

  @override
  final String number;

  @override
  final Contact? contact;

  @override
  final List<CallLogEntry>? callLog;

  @override
  toString() {
    return 'CallLogState {number: $number, contact: $contact, callLog: ${callLog?.length ?? 0}}';
  }
}
