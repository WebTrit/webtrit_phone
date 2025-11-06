import '../abstract_requests.dart';

class AcceptRequest extends CallRequest {
  const AcceptRequest({required super.transaction, required super.line, required super.callId, required this.jsep});

  final Map<String, dynamic> jsep;

  @override
  List<Object?> get props => [...super.props, jsep];

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
    return {Request.typeKey: typeValue, 'transaction': transaction, 'line': line, 'call_id': callId, 'jsep': jsep};
  }
}
