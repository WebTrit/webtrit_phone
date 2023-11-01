import '../abstract_requests.dart';

class OutgoingCallRequest extends CallRequest {
  const OutgoingCallRequest({
    required super.transaction,
    required super.line,
    required super.callId,
    required this.number,
    required this.jsep,
  });

  final String number;
  final Map<String, dynamic> jsep;

  @override
  List<Object?> get props => [
        ...super.props,
        number,
        jsep,
      ];

  static const typeValue = 'outgoing_call';

  factory OutgoingCallRequest.fromJson(Map<String, dynamic> json) {
    final requestTypeValue = json[Request.typeKey];
    if (requestTypeValue != typeValue) {
      throw ArgumentError.value(requestTypeValue, Request.typeKey, 'Not equal $typeValue');
    }

    return OutgoingCallRequest(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      number: json['number'],
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
      'number': number,
      'jsep': jsep,
    };
  }
}
