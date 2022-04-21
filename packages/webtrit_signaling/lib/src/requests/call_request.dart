import 'line_request.dart';

class CallRequest extends LineRequest {
  const CallRequest({
    required int line,
    this.callId,
    required this.number,
    required this.jsep,
  }) : super(line: line);

  final String? callId;
  final String number;
  final Map<String, dynamic> jsep;

  @override
  List<Object?> get props => [
        ...super.props,
        callId,
        number,
        jsep,
      ];
}
