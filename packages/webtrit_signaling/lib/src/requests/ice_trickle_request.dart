import 'line_request.dart';
import 'request.dart';

class IceTrickleRequest extends LineRequest {
  const IceTrickleRequest({
    required String transaction,
    required int line,
    this.candidate,
  }) : super(transaction: transaction, line: line);

  final Map<String, dynamic>? candidate;

  @override
  List<Object?> get props => [
        ...super.props,
        candidate,
      ];

  static const typeValue = 'ice_trickle';

  factory IceTrickleRequest.fromJson(Map<String, dynamic> json) {
    final requestTypeValue = json[Request.typeKey];
    if (requestTypeValue != typeValue) {
      throw ArgumentError.value(requestTypeValue, Request.typeKey, 'Not equal $typeValue');
    }

    return IceTrickleRequest(
      transaction: json['transaction'],
      line: json['line'],
      candidate: json['candidate'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      Request.typeKey: typeValue,
      'transaction': transaction,
      'line': line,
      'candidate': candidate,
    };
  }
}
