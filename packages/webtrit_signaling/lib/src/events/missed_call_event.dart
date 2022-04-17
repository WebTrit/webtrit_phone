import 'call_event.dart';

class MissedCallEvent extends CallEvent {
  const MissedCallEvent({
    required int line,
    required String callId,
    required this.callee,
    required this.caller,
    this.callerDisplayName,
  }) : super(
          line: line,
          callId: callId,
        );

  final String callee;
  final String caller;
  final String? callerDisplayName;

  @override
  List<Object?> get props => [
        ...super.props,
        callee,
        caller,
        callerDisplayName,
      ];
}
