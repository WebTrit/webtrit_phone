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
      final refining = error.refining;
      if (refining != null) {
        final s = refining.map((r) => '${r.path}: ${r.reason}').join(', ');
        return '$RequestFailure($statusCode, ${error.code}, [$s])';
      } else {
        return '$RequestFailure($statusCode, ${error.code})';
      }
    } else {
      return '$RequestFailure($statusCode)';
    }
  }
}
