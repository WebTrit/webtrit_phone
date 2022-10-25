import '../abstract_requests.dart';

class TransferRequest extends CallRequest {
  const TransferRequest({
    required String transaction,
    required int line,
    required String callId,
    required this.number,
    this.replaceCallId,
  }) : super(transaction: transaction, line: line, callId: callId);

  final String number;
  final String? replaceCallId;

  @override
  List<Object?> get props => [
        ...super.props,
        number,
        replaceCallId,
      ];

  static const typeValue = 'transfer';

  factory TransferRequest.fromJson(Map<String, dynamic> json) {
    final requestTypeValue = json[Request.typeKey];
    if (requestTypeValue != typeValue) {
      throw ArgumentError.value(requestTypeValue, Request.typeKey, 'Not equal $typeValue');
    }

    return TransferRequest(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      number: json['number'],
      replaceCallId: json['replace_call_id'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final replaceCallId = this.replaceCallId;
    return {
      Request.typeKey: typeValue,
      'transaction': transaction,
      'line': line,
      'call_id': callId,
      'number': number,
      if (replaceCallId != null) 'replace_call_id': replaceCallId,
    };
  }
}
