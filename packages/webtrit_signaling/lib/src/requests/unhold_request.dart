import 'call_request.dart';

class UnholdRequest extends CallRequest {
  const UnholdRequest({
    required String callId,
  }) : super(callId: callId);

  static const request = 'unhold';

  factory UnholdRequest.fromJson(Map<String, dynamic> json) {
    final requestValue = json['request'];
    if (requestValue != request) {
      throw ArgumentError.value(requestValue, "request", "Not equal $request");
    }

    return UnholdRequest(
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
