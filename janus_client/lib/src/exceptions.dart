part of '../janus_client.dart';

class JanusException implements Exception {}

class JanusTransactionException implements Exception {}

class JanusTransactionTimeoutException implements JanusTransactionException {}

class JanusErrorException implements JanusException {
  final int code;
  final String reason;

  const JanusErrorException(this.code, this.reason);

  @override
  String toString() => 'JanusErrorException { code: $code, reason: "$reason" }';
}

class JanusGatewayException implements JanusException {}

class JanusGatewayTransactionUnavailableException implements JanusGatewayException {
  final String transactionId;

  const JanusGatewayTransactionUnavailableException(this.transactionId);

  @override
  String toString() => 'JanusGatewayTransactionUnavailableException { transactionId: "$transactionId" }';
}

class JanusGatewaySessionUnavailableException implements JanusGatewayException {
  final int sessionId;

  const JanusGatewaySessionUnavailableException(this.sessionId);

  @override
  String toString() => 'JanusGatewaySessionUnavailableException { sessionId: $sessionId }';
}

class JanusSessionException implements JanusException {}

class JanusSessionHandleUnavailableException implements JanusSessionException {
  final int handleId;

  const JanusSessionHandleUnavailableException(this.handleId);

  @override
  String toString() => 'JanusSessionHandleUnavailableException { handleId: $handleId }';
}

class JanusSessionTimeoutException implements JanusSessionException {}

class JanusPluginHandleException implements JanusException {}

class JanusPluginHandleErrorException implements JanusPluginHandleException {
  final int errorCode;
  final String error;

  const JanusPluginHandleErrorException(this.errorCode, this.error);

  @override
  String toString() => 'JanusPluginHandleErrorException { errorCode: $errorCode, error: "$error" }';
}
