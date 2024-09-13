enum HttpMethod {
  get,
  post,
  delete,
  patch,
}

class ResponseException implements Exception {
  final HttpMethod method;
  final Uri url;
  final String requestId;
  final String? token;
  final int requestAttempt;
  final dynamic error;

  ResponseException(
    this.method,
    this.url,
    this.requestId,
    this.token,
    this.requestAttempt,
    this.error,
  );

  @override
  String toString() {
    return 'ResponseException: $method $url (requestId: $requestId, attempt: $requestAttempt) failed with error: $error';
  }
}
