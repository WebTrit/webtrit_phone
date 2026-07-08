import 'models/error.dart';

class RequestFailure implements Exception {
  RequestFailure({required this.url, this.statusCode, required this.requestId, this.token, this.error});

  /// Status codes defined as transient by HTTP semantics (408 Request
  /// Timeout, 425 Too Early, 429 Too Many Requests): the server explicitly
  /// asks to retry, so such a response carries no lasting verdict.
  static const _transientStatusCodes = {408, 425, 429};

  final Uri url;
  final int? statusCode;
  final String requestId;
  final String? token;
  final ErrorResponse? error;

  /// Whether the response is a client error (4xx).
  bool get isClientError {
    final statusCode = this.statusCode;
    return statusCode != null && statusCode >= 400 && statusCode < 500;
  }

  /// Whether the response is a server error (5xx).
  bool get isServerError {
    final statusCode = this.statusCode;
    return statusCode != null && statusCode >= 500 && statusCode < 600;
  }

  /// Whether the status is transient by HTTP semantics, i.e. the server
  /// explicitly asks to retry the request later.
  bool get isTransient => _transientStatusCodes.contains(statusCode);

  /// The backend-produced error code from the response body, if any.
  /// A response without one was likely produced by an intermediary
  /// (load balancer, proxy, WAF) rather than the backend itself.
  String? get errorCode => error?.code;

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

class VoicemailNotConfiguredException extends RequestFailure {
  VoicemailNotConfiguredException({
    required super.url,
    required super.requestId,
    required super.statusCode,
    super.token,
    super.error,
  }) : super();
}

class UserNotFoundException extends RequestFailure {
  UserNotFoundException({required super.url, required super.requestId, required super.statusCode});

  @override
  String toString() => 'UserNotFoundException($statusCode, $url)';
}

class UnauthorizedException extends RequestFailure {
  UnauthorizedException({
    required super.url,
    required super.requestId,
    required super.statusCode,
    super.token,
    super.error,
  });

  @override
  String toString() {
    final code = error?.code;
    return 'UnauthorizedException(statusCode: $statusCode, requestId: $requestId, url: $url'
        '${code != null ? ', code: $code' : ''})';
  }
}

class SessionMissingException extends RequestFailure {
  SessionMissingException({
    required super.url,
    required super.requestId,
    required super.statusCode,
    super.token,
    super.error,
  });

  @override
  String toString() => 'SessionMissingException(statusCode: $statusCode, requestId: $requestId, url: $url)';
}

class PasswordChangeRequiredException extends RequestFailure {
  PasswordChangeRequiredException({
    required super.url,
    required super.requestId,
    required super.statusCode,
    super.token,
    super.error,
  });
}
