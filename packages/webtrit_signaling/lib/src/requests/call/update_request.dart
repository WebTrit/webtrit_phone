import '../abstract_requests.dart';

class UpdateRequest extends CallRequest {
  const UpdateRequest({
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

  static const typeValue = 'update';

  factory UpdateRequest.fromJson(Map<String, dynamic> json) {
    final requestTypeValue = json[Request.typeKey];
    if (requestTypeValue != typeValue) {
      throw ArgumentError.value(requestTypeValue, Request.typeKey, 'Not equal $typeValue');
    }

    return UpdateRequest(
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
