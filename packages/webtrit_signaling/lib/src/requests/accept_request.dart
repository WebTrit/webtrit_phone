import 'call_request.dart';
import 'request.dart';

class AcceptRequest extends CallRequest {
  const AcceptRequest({
    required String transaction,
    required int line,
    required String callId,
    required this.jsep,
  }) : super(transaction: transaction, line: line, callId: callId);

  final Map<String, dynamic> jsep;

  @override
  List<Object?> get props => [
        ...super.props,
        jsep,
      ];

  static const typeValue = 'accept';

  factory AcceptRequest.fromJson(Map<String, dynamic> json) {
    final requestTypeValue = json[Request.typeKey];
    if (requestTypeValue != typeValue) {
      throw ArgumentError.value(requestTypeValue, Request.typeKey, 'Not equal $typeValue');
    }

    return AcceptRequest(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      jsep: json['jsep'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      Request.typeKey: typeValue,
      'transaction': transaction,
      'line': line,
      'call_id': callId,
      'jsep': jsep,
    };
  }
}
