import '../abstract_requests.dart';

class HangupRequest extends CallRequest {
  const HangupRequest({
    required super.transaction,
    required super.line,
    required super.callId,
  });

  static const typeValue = 'hangup';

  factory HangupRequest.fromJson(Map<String, dynamic> json) {
    final requestTypeValue = json[Request.typeKey];
    if (requestTypeValue != typeValue) {
      throw ArgumentError.value(
          requestTypeValue, Request.typeKey, 'Not equal $typeValue');
    }

    return HangupRequest(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      Request.typeKey: typeValue,
      'transaction': transaction,
      'line': line,
      'call_id': callId,
    };
  }
}
