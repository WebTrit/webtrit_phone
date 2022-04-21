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

  static const request = 'call';

  factory CallRequest.fromJson(Map<String, dynamic> json) {
    final requestValue = json['request'];
    if (requestValue != request) {
      throw ArgumentError.value(requestValue, "request", "Not equal $request");
    }

    return CallRequest(
      line: json['line'],
      callId: json['call_id'],
      number: json['number'],
      jsep: json['jsep'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final callId = this.callId;
    return {
      'request': request,
      'line': line,
      if (callId != null) 'call_id': callId,
      'number': number,
      'jsep': jsep,
    };
  }
}
