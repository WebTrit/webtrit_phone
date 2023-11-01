import 'response.dart';

class ErrorResponse extends Response {
  const ErrorResponse({
    super.transaction,
    super.line,
    super.callId,
    required this.code,
    required this.reason,
  });

  final int code;
  final String reason;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
        reason,
      ];

  static const typeValue = 'error';

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    final responseTypeValue = json[Response.typeKey];
    if (responseTypeValue != typeValue) {
      throw ArgumentError.value(responseTypeValue, Response.typeKey, 'Not equal $typeValue');
    }

    return ErrorResponse(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      code: json['code'],
      reason: json['reason'],
    );
  }
}
