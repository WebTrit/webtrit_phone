import 'call_request.dart';

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

  static const request = 'transfer';

  factory TransferRequest.fromJson(Map<String, dynamic> json) {
    final requestValue = json['request'];
    if (requestValue != request) {
      throw ArgumentError.value(requestValue, "request", "Not equal $request");
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
      'request': request,
      'transaction': transaction,
      'line': line,
      'call_id': callId,
      'number': number,
      if (replaceCallId != null) 'replace_call_id': replaceCallId,
    };
  }
}
