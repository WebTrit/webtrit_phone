import 'line_request.dart';

class TrickleRequest extends LineRequest {
  const TrickleRequest({
    required int line,
    this.candidate,
  }) : super(line: line);

  final Map<String, dynamic>? candidate;

  @override
  List<Object?> get props => [
        ...super.props,
        candidate,
      ];

  static const request = 'trickle';

  factory TrickleRequest.fromJson(Map<String, dynamic> json) {
    final requestValue = json['request'];
    if (requestValue != request) {
      throw ArgumentError.value(requestValue, "request", "Not equal $request");
    }

    return TrickleRequest(
      line: json['line'],
      candidate: json['candidate'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'request': request,
      'line': line,
      'candidate': candidate,
    };
  }
}
