import 'call_request.dart';

class HangupRequest extends CallRequest {
  const HangupRequest({
    required String callId,
  }) : super(callId: callId);

  static const request = 'hangup';

  factory HangupRequest.fromJson(Map<String, dynamic> json) {
    final requestValue = json['request'];
    if (requestValue != request) {
      throw ArgumentError.value(requestValue, "request", "Not equal $request");
    }

    return HangupRequest(
      callId: json['call_id'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'request': request,
      'call_id': callId,
    };
  }
}
