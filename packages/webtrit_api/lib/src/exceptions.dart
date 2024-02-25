import 'models/error.dart';

class RequestFailure implements Exception {
  RequestFailure({
    required this.statusCode,
    required this.requestId,
    this.error,
  });

  final int statusCode;
  final String requestId;
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
