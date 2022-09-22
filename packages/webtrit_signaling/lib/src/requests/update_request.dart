import 'call_request.dart';

class UpdateRequest extends CallRequest {
  const UpdateRequest({
    required int line,
    required String callId,
    required this.jsep,
  }) : super(line: line, callId: callId);

  final Map<String, dynamic> jsep;

  @override
  List<Object?> get props => [
        ...super.props,
        jsep,
      ];

  static const request = 'update';

  factory UpdateRequest.fromJson(Map<String, dynamic> json) {
    final requestValue = json['request'];
    if (requestValue != request) {
      throw ArgumentError.value(requestValue, "request", "Not equal $request");
    }

    return UpdateRequest(
      line: json['line'],
      callId: json['call_id'],
      jsep: json['jsep'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'request': request,
      'line': line,
      'call_id': callId,
      'jsep': jsep,
    };
  }
}
