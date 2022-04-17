class WebtritSignalingException implements Exception {}

class WebtritSignalingAlreadyConnectException implements Exception {
  const WebtritSignalingAlreadyConnectException();

  @override
  String toString() => '$WebtritSignalingAlreadyConnectException';
}

class WebtritSignalingUnknownMessageException implements Exception {
  const WebtritSignalingUnknownMessageException(this.message);

  final Map<String, dynamic> message;

  @override
  String toString() => '$WebtritSignalingUnknownMessageException message: $message';
}

class WebtritSignalingResponseException implements Exception {
  const WebtritSignalingResponseException(this.response);

  final Map<String, dynamic> response;

  @override
  String toString() => '$WebtritSignalingResponseException response: $response';
}

class WebtritSignalingTransactionUnavailableException implements WebtritSignalingException {
  const WebtritSignalingTransactionUnavailableException(this.transactionId);

  final String transactionId;

  @override
  String toString() => '$WebtritSignalingTransactionUnavailableException transactionId: $transactionId';
}

class WebtritSignalingTerminateException implements WebtritSignalingException {
  const WebtritSignalingTerminateException([this.closeCode, this.closeReason]);

  final int? closeCode;
  final String? closeReason;
}

class WebtritSignalingTimeoutException implements WebtritSignalingException {}

class WebtritSignalingKeepaliveTimeoutException extends WebtritSignalingTimeoutException {}

class WebtritSignalingErrorException implements WebtritSignalingException {
  const WebtritSignalingErrorException(this.code, this.reason);

  final int code;
  final String reason;

  @override
  String toString() => '$WebtritSignalingErrorException code: $code, reason: $reason';
}
