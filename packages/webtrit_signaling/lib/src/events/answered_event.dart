import 'call_event.dart';

class AnsweredEvent extends CallEvent {
  AnsweredEvent({
    required String callId,
    required this.callee,
    this.isFocus,
    this.jsep,
  }) : super(callId: callId);

  final String callee;
  final bool? isFocus;
  final Map<String, dynamic>? jsep;

  @override
  List<Object?> get props => [
        ...super.props,
        callee,
        isFocus,
        jsep,
      ];
}
