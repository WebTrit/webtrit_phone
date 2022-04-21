import 'line_request.dart';

class DeclineRequest extends LineRequest {
  const DeclineRequest({
    required int line,
  }) : super(line: line);

  static const request = 'decline';

  factory DeclineRequest.fromJson(Map<String, dynamic> json) {
    final requestValue = json['request'];
    if (requestValue != request) {
      throw ArgumentError.value(requestValue, "request", "Not equal $request");
    }

    return DeclineRequest(
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
