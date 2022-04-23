import 'call_request.dart';

class AcceptRequest extends CallRequest {
  const AcceptRequest({
    required String callId,
    required this.jsep,
  }) : super(callId: callId);

  final Map<String, dynamic> jsep;

  @override
  List<Object?> get props => [
        ...super.props,
        jsep,
      ];

  static const request = 'accept';

  factory AcceptRequest.fromJson(Map<String, dynamic> json) {
    final requestValue = json['request'];
    if (requestValue != request) {
      throw ArgumentError.value(requestValue, "request", "Not equal $request");
    }

    return AcceptRequest(
      callId: json['call_id'],
      jsep: json['jsep'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'request': request,
      'call_id': callId,
      'jsep': jsep,
    };
  }
}
