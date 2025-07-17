import 'models/error.dart';

class RequestFailure implements Exception {
  RequestFailure({
    required this.url,
    this.statusCode,
    required this.requestId,
    this.token,
    this.error,
  });

  final Uri url;
  final int? statusCode;
  final String requestId;
  final String? token;
  final ErrorResponse? error;

  @override
  String toString() {
    final buffer = StringBuffer()
      ..write('RequestFailure(statusCode: $statusCode')
      ..write(', requestId: $requestId');

    if (error != null) {
      buffer.write(', code: ${error?.code}');
      final details = error?.details;
      if (details != null) buffer.write(', path: ${details.path}, reason: ${details.reason}');
    }

    buffer.write(')');
    return buffer.toString();
  }
}

class EndpointNotSupportedException extends RequestFailure {
  EndpointNotSupportedException({
    required super.url,
    required super.requestId,
    required super.statusCode,
    required List<String> recognizedNotSupportedCodes,
  }) : super();
}

class UserNotFoundException extends RequestFailure {
  UserNotFoundException({
    required super.url,
    required super.requestId,
    required super.statusCode,
  });

  @override
  String toString() => 'UserNotFoundException($statusCode, $url)';
}
