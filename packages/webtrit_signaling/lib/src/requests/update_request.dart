import 'call_request.dart';

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

  static const request = 'update';

  factory UpdateRequest.fromJson(Map<String, dynamic> json) {
    final requestValue = json['request'];
    if (requestValue != request) {
      throw ArgumentError.value(requestValue, "request", "Not equal $request");
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
      'request': request,
      'transaction': transaction,
      'line': line,
      'call_id': callId,
      'jsep': jsep,
    };
  }
}
