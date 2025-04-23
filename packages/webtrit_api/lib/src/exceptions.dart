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
    final error = this.error;
    if (error != null) {
      final errorDetails = error.details;
      if (errorDetails != null) {
        return '$RequestFailure($statusCode, ${error.code},${error.details?.path}: ${error.details?.reason}';
      } else {
        return '$RequestFailure($statusCode, ${error.code})';
      }
    } else {
      return '$RequestFailure($statusCode)';
    }
  }
}

class EndpointNotSupportedException extends RequestFailure {
  EndpointNotSupportedException({
    required super.url,
    required super.requestId,
  }) : super(statusCode: 404);
}
