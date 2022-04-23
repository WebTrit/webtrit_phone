import 'call_request.dart';

class DeclineRequest extends CallRequest {
  const DeclineRequest({
    required String callId,
  }) : super(callId: callId);

  static const request = 'decline';

  factory DeclineRequest.fromJson(Map<String, dynamic> json) {
    final requestValue = json['request'];
    if (requestValue != request) {
      throw ArgumentError.value(requestValue, "request", "Not equal $request");
    }

    return DeclineRequest(
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
