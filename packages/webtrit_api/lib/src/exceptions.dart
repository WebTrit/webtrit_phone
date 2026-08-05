import 'models/error.dart';

class RequestFailure implements Exception {
  RequestFailure({required this.url, this.statusCode, required this.requestId, this.token, this.error, this.rawBody});

  // package:http exposes no status-code constants; dart:io is not web-safe.
  static const _requestTimeout = 408;
  static const _tooEarly = 425;
  static const _tooManyRequests = 429;

  static const _transientStatusCodes = {_requestTimeout, _tooEarly, _tooManyRequests};

  final Uri url;
  final int? statusCode;
  final String requestId;
  final String? token;
  final ErrorResponse? error;

  /// Truncated raw response body, carried when the error payload was not JSON
  /// (e.g. a plain-text page from a proxy in front of a dead backend), so
  /// diagnostics keep the actual server response even though [error] is null.
  final String? rawBody;

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

  /// Whether the status is transient by HTTP semantics: the server asks to
  /// retry the request.
  bool get isTransient => _transientStatusCodes.contains(statusCode);

  /// The backend-produced error code from the response body, if any.
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

    if (rawBody != null) buffer.write(', rawBody: $rawBody');

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
