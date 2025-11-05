abstract class WebtritSignalingException implements Exception {
  const WebtritSignalingException(this.id);

  final int id;

  @override
  String toString() => '$runtimeType id: $id';
}

class WebtritSignalingErrorException extends WebtritSignalingException {
  const WebtritSignalingErrorException(super.id, this.code, this.reason);

  final int code;
  final String reason;

  @override
  String toString() => '${super.toString()}, code: $code, reason: $reason';
}

class WebtritSignalingDisconnectedException extends WebtritSignalingException {
  const WebtritSignalingDisconnectedException(super.id);
}

class WebtritSignalingUnknownMessageException
    extends WebtritSignalingException {
  const WebtritSignalingUnknownMessageException(super.id, this.message);

  final Map<String, dynamic> message;

  @override
  String toString() => '${super.toString()}, message: $message';
}

class WebtritSignalingUnknownResponseException
    extends WebtritSignalingException {
  const WebtritSignalingUnknownResponseException(super.id, this.response);

  final Map<String, dynamic> response;

  @override
  String toString() => '${super.toString()}, response: $response';
}

abstract class WebtritSignalingTransactionException
    extends WebtritSignalingException {
  const WebtritSignalingTransactionException(super.id, this.transactionId);

  final String transactionId;

  @override
  String toString() => '${super.toString()}, transactionId: $transactionId';
}

class WebtritSignalingTransactionTimeoutException
    extends WebtritSignalingTransactionException {
  const WebtritSignalingTransactionTimeoutException(
      super.id, super.transactionId);
}

class WebtritSignalingKeepaliveTransactionTimeoutException
    extends WebtritSignalingTransactionTimeoutException {
  const WebtritSignalingKeepaliveTransactionTimeoutException(
      super.id, super.transactionId);
}

class WebtritSignalingTransactionUnavailableException
    extends WebtritSignalingTransactionException {
  const WebtritSignalingTransactionUnavailableException(
      super.id, super.transactionId);
}

abstract class WebtritSignalingTransactionTerminateException
    extends WebtritSignalingTransactionException {
  const WebtritSignalingTransactionTerminateException(
      super.id, super.transactionId);
}

class WebtritSignalingTransactionTerminateByDisconnectException
    extends WebtritSignalingTransactionTerminateException {
  const WebtritSignalingTransactionTerminateByDisconnectException(
      super.id, super.transactionId, this.closeCode, this.closeReason);

  final int? closeCode;
  final String? closeReason;

  @override
  String toString() =>
      '${super.toString()}, code: $closeCode, reason: $closeReason';
}
