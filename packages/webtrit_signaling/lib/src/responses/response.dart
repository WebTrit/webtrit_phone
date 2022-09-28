import 'package:equatable/equatable.dart';

import 'responses.dart';

abstract class Response extends Equatable {
  const Response({
    this.line,
    this.callId,
  });

  final int? line;
  final String? callId;

  @override
  List<Object?> get props => [
        line,
        callId,
      ];

  static const typeKey = 'response';

  factory Response.fromJson(Map<String, dynamic> json) {
    final responseTypeValue = json[Response.typeKey];
    switch (responseTypeValue) {
      case AckResponse.typeValue:
        return AckResponse.fromJson(json);
      case ErrorResponse.typeValue:
        return ErrorResponse.fromJson(json);
      default:
        throw ArgumentError.value(responseTypeValue, Response.typeKey, 'Unknown response type');
    }
  }
}
