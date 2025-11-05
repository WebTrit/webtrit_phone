import '../abstract_requests.dart';

class DeclineRequest extends CallRequest {
  const DeclineRequest({required super.transaction, required super.line, required super.callId, this.referId});

  static const typeValue = 'decline';
  final String? referId;

  factory DeclineRequest.fromJson(Map<String, dynamic> json) {
    final requestTypeValue = json[Request.typeKey];
    if (requestTypeValue != typeValue) {
      throw ArgumentError.value(requestTypeValue, Request.typeKey, 'Not equal $typeValue');
    }

    return DeclineRequest(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      referId: json['refer_id'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      Request.typeKey: typeValue,
      'transaction': transaction,
      'line': line,
      'call_id': callId,
      'refer_id': referId,
    };
  }
}
