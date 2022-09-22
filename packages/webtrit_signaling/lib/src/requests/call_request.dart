import 'line_request.dart';

abstract class CallRequest extends LineRequest {
  const CallRequest({
    required int line,
    required this.callId,
  }) : super(line: line);

  final String callId;

  @override
  List<Object?> get props => [
        ...super.props,
        callId,
      ];
}
