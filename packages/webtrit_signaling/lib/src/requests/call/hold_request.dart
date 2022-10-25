import '../abstract_requests.dart';

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

  static const typeValue = 'hold';

  factory HoldRequest.fromJson(Map<String, dynamic> json) {
    final requestTypeValue = json[Request.typeKey];
    if (requestTypeValue != typeValue) {
      throw ArgumentError.value(requestTypeValue, Request.typeKey, 'Not equal $typeValue');
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
      Request.typeKey: typeValue,
      'transaction': transaction,
      'line': line,
      'call_id': callId,
      if (direction != null) 'direction': direction.name,
    };
  }
}
