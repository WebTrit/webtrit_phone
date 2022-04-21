import 'line_request.dart';

class TransferRequest extends LineRequest {
  const TransferRequest({
    required int line,
    required this.number,
    this.replaceCallId,
  }) : super(line: line);

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
      line: json['line'],
      number: json['number'],
      replaceCallId: json['replace_call_id'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final replaceCallId = this.replaceCallId;
    return {
      'request': request,
      'line': line,
      'number': number,
      if (replaceCallId != null) 'replace_call_id': replaceCallId,
    };
  }
}
