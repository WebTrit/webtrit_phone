import 'line_request.dart';

class HangupRequest extends LineRequest {
  const HangupRequest({
    required int line,
  }) : super(line: line);

  static const request = 'hangup';

  factory HangupRequest.fromJson(Map<String, dynamic> json) {
    final requestValue = json['request'];
    if (requestValue != request) {
      throw ArgumentError.value(requestValue, "request", "Not equal $request");
    }

    return HangupRequest(
      line: json['line'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'request': request,
      'line': line,
    };
  }
}
