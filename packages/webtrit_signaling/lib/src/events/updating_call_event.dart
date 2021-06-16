import 'call_event.dart';

class UpdatingCallEvent extends CallEvent {
  UpdatingCallEvent({
    required String callId,
    required this.callee,
    required this.caller,
    this.callerDisplayName,
    this.replaceCallId,
    this.isFocus,
    this.jsep,
  }) : super(callId: callId);

  final String callee;
  final String caller;
  final String? callerDisplayName;
  final String? replaceCallId;
  final bool? isFocus;
  final Map<String, dynamic>? jsep;

  @override
  List<Object?> get props => [
        ...super.props,
        callee,
        caller,
        callerDisplayName,
        replaceCallId,
        isFocus,
        jsep,
      ];
}
