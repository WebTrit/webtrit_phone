import 'line_request.dart';

class UnholdRequest extends LineRequest {
  const UnholdRequest({
    required int line,
  }) : super(line: line);

  static const request = 'unhold';

  factory UnholdRequest.fromJson(Map<String, dynamic> json) {
    final requestValue = json['request'];
    if (requestValue != request) {
      throw ArgumentError.value(requestValue, "request", "Not equal $request");
    }

    return UnholdRequest(
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
