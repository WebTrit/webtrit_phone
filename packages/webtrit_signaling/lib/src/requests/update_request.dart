import 'line_request.dart';

class UpdateRequest extends LineRequest {
  const UpdateRequest({
    required int line,
    required this.jsep,
  }) : super(line: line);

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
      jsep: json['jsep'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'request': request,
      'line': line,
      'jsep': jsep,
    };
  }
}
