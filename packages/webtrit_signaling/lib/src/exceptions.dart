abstract class WebtritSignalingException implements Exception {
  const WebtritSignalingException(this.id);

  final int id;

  @override
  String toString() => '$runtimeType id: $id';
}

class WebtritSignalingErrorException extends WebtritSignalingException {
  const WebtritSignalingErrorException(int id, this.code, this.reason) : super(id);

  final int code;
  final String reason;

  @override
  String toString() => '${super.toString()}, code: $code, reason: $reason';
}

class WebtritSignalingDisconnectedException extends WebtritSignalingException {
  const WebtritSignalingDisconnectedException(int id) : super(id);
}

class WebtritSignalingUnknownMessageException extends WebtritSignalingException {
  const WebtritSignalingUnknownMessageException(int id, this.message) : super(id);

  final Map<String, dynamic> message;

  @override
  String toString() => '${super.toString()}, message: $message';
}

class WebtritSignalingUnknownResponseException extends WebtritSignalingException {
  const WebtritSignalingUnknownResponseException(int id, this.response) : super(id);

  final Map<String, dynamic> response;

  @override
  String toString() => '${super.toString()}, response: $response';
}

abstract class WebtritSignalingTransactionException extends WebtritSignalingException {
  const WebtritSignalingTransactionException(int id, this.transactionId) : super(id);

  final String transactionId;

  @override
  String toString() => '${super.toString()}, transactionId: $transactionId';
}

class WebtritSignalingTransactionTimeoutException extends WebtritSignalingTransactionException {
  const WebtritSignalingTransactionTimeoutException(int id, String transactionId) : super(id, transactionId);
}

class WebtritSignalingKeepaliveTimeoutException extends WebtritSignalingTransactionTimeoutException {
  const WebtritSignalingKeepaliveTimeoutException(int id, String transactionId) : super(id, transactionId);
}

class WebtritSignalingTransactionUnavailableException extends WebtritSignalingTransactionException {
  const WebtritSignalingTransactionUnavailableException(int id, String transactionId) : super(id, transactionId);
}

abstract class WebtritSignalingTransactionTerminateException extends WebtritSignalingTransactionException {
  const WebtritSignalingTransactionTerminateException(int id, String transactionId) : super(id, transactionId);
}

class WebtritSignalingTerminateByDisconnectException extends WebtritSignalingTransactionTerminateException {
  const WebtritSignalingTerminateByDisconnectException(int id, String transactionId, this.closeCode, this.closeReason)
      : super(id, transactionId);

  final int? closeCode;
  final String? closeReason;

  @override
  String toString() => '${super.toString()}, code: $closeCode, reason: $closeReason';
}
