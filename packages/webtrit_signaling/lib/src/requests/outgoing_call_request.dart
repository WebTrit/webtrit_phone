import 'call_request.dart';

class OutgoingCallRequest extends CallRequest {
  const OutgoingCallRequest({
    required String callId,
    required this.number,
    required this.jsep,
  }) : super(callId: callId);

  final String number;
  final Map<String, dynamic> jsep;

  @override
  List<Object?> get props => [
        ...super.props,
        number,
        jsep,
      ];

  static const request = 'outgoing_call';

  factory OutgoingCallRequest.fromJson(Map<String, dynamic> json) {
    final requestValue = json['request'];
    if (requestValue != request) {
      throw ArgumentError.value(requestValue, "request", "Not equal $request");
    }

    return OutgoingCallRequest(
      callId: json['call_id'],
      number: json['number'],
      jsep: json['jsep'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'request': request,
      'call_id': callId,
      'number': number,
      'jsep': jsep,
    };
  }
}
