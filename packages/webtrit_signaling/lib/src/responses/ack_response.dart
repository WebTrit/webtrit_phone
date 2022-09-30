import 'response.dart';

class AckResponse extends Response {
  const AckResponse({
    String? transaction,
    int? line,
    String? callId,
  }) : super(transaction: transaction, line: line, callId: callId);

  static const typeValue = 'ack';

  factory AckResponse.fromJson(Map<String, dynamic> json) {
    final responseTypeValue = json[Response.typeKey];
    if (responseTypeValue != typeValue) {
      throw ArgumentError.value(responseTypeValue, Response.typeKey, 'Not equal $typeValue');
    }

    return AckResponse(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
    );
  }
}
