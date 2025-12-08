import '../abstract_requests.dart';

class OutgoingCallRequest extends CallRequest {
  const OutgoingCallRequest({
    required super.transaction,
    required super.line,
    required super.callId,
    required this.number,
    required this.jsep,
    this.referId,
    this.replaces,
    this.from,
  });

  final String number;
  final Map<String, dynamic> jsep;
  final String? referId;
  final String? replaces;
  final String? from;

  @override
  List<Object?> get props => [...super.props, number, jsep, referId, replaces, from];

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
      referId: json['refer_id'],
      replaces: json['replaces'],
      from: json['from'],
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
      'refer_id': referId,
      'replaces': replaces,
      'from': from,
      'jsep': jsep,
    };
  }
}
