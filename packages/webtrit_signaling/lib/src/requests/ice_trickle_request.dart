import 'line_request.dart';

class IceTrickleRequest extends LineRequest {
  const IceTrickleRequest({
    required String transaction,
    required int line,
    this.candidate,
  }) : super(transaction: transaction, line: line);

  final Map<String, dynamic>? candidate;

  @override
  List<Object?> get props => [
        ...super.props,
        candidate,
      ];

  static const request = 'ice_trickle';

  factory IceTrickleRequest.fromJson(Map<String, dynamic> json) {
    final requestValue = json['request'];
    if (requestValue != request) {
      throw ArgumentError.value(requestValue, "request", "Not equal $request");
    }

    return IceTrickleRequest(
      transaction: json['transaction'],
      line: json['line'],
      candidate: json['candidate'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'request': request,
      'transaction': transaction,
      'line': line,
      'candidate': candidate,
    };
  }
}
