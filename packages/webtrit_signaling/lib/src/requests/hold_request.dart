import 'call_request.dart';

enum HoldDirection {
  sendonly,
  recvonly,
  inactive,
}

class HoldRequest extends CallRequest {
  const HoldRequest({
    required String transaction,
    required int line,
    required String callId,
    this.direction,
  }) : super(transaction: transaction, line: line, callId: callId);

  final HoldDirection? direction;

  @override
  List<Object?> get props => [
        ...super.props,
        direction,
      ];

  static const request = 'hold';

  factory HoldRequest.fromJson(Map<String, dynamic> json) {
    final requestValue = json['request'];
    if (requestValue != request) {
      throw ArgumentError.value(requestValue, "request", "Not equal $request");
    }

    HoldDirection? direction;
    final directionValue = json['direction'];
    if (directionValue != null) {
      direction = HoldDirection.values.byName(directionValue);
    }

    return HoldRequest(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      direction: direction,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final direction = this.direction;
    return {
      'request': request,
      'transaction': transaction,
      'line': line,
      'call_id': callId,
      if (direction != null) 'direction': direction.name,
    };
  }
}
