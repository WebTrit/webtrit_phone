import 'models/error.dart';

class RequestFailure implements Exception {
  RequestFailure({
    required this.statusCode,
    this.error,
  });

  final int statusCode;
  final ErrorResponse? error;

  @override
  String toString() {
    final error = this.error;
    if (error != null) {
      final errorDetails = error.details;
      if (errorDetails != null) {
        final s = errorDetails.map((d) => '${d.path}: ${d.reason}').join(', ');
        return '$RequestFailure($statusCode, ${error.code}, [$s])';
      } else {
        return '$RequestFailure($statusCode, ${error.code})';
      }
    } else {
      return '$RequestFailure($statusCode)';
    }
  }
}
