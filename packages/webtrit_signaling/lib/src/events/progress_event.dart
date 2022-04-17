import 'call_event.dart';

class ProgressEvent extends CallEvent {
  const ProgressEvent({
    required int line,
    required String callId,
    required this.callee,
    this.isFocus,
    this.jsep,
  }) : super(
          line: line,
          callId: callId,
        );

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
