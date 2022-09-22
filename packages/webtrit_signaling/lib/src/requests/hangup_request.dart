import 'call_request.dart';

class HangupRequest extends CallRequest {
  const HangupRequest({
    required int line,
    required String callId,
  }) : super(line: line, callId: callId);

  static const request = 'hangup';

  factory HangupRequest.fromJson(Map<String, dynamic> json) {
    final requestValue = json['request'];
    if (requestValue != request) {
      throw ArgumentError.value(requestValue, "request", "Not equal $request");
    }

    return HangupRequest(
      line: json['line'],
      callId: json['call_id'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'request': request,
      'line': line,
      'call_id': callId,
    };
  }
}
