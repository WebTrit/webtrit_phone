import '../abstract_requests.dart';

class IceTrickleRequest extends LineRequest {
  const IceTrickleRequest({required super.transaction, required super.line, this.candidate});

  final Map<String, dynamic>? candidate;

  @override
  List<Object?> get props => [...super.props, candidate];

  static const typeValue = 'ice_trickle';

  factory IceTrickleRequest.fromJson(Map<String, dynamic> json) {
    final requestTypeValue = json[Request.typeKey];
    if (requestTypeValue != typeValue) {
      throw ArgumentError.value(requestTypeValue, Request.typeKey, 'Not equal $typeValue');
    }

    return IceTrickleRequest(transaction: json['transaction'], line: json['line'], candidate: json['candidate']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {Request.typeKey: typeValue, 'transaction': transaction, 'line': line, 'candidate': candidate};
  }
}
