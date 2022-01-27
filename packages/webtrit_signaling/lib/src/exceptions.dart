class WebtritSignalingException implements Exception {}

class WebtritSignalingTransactionUnavailableException implements WebtritSignalingException {
  const WebtritSignalingTransactionUnavailableException(this.transactionId);

  final String transactionId;

  @override
  String toString() => '$WebtritSignalingTransactionUnavailableException { transactionId: "$transactionId" }';
}

class WebtritSignalingTerminateException implements WebtritSignalingException {
  const WebtritSignalingTerminateException([this.closeCode, this.closeReason]);

  final int? closeCode;
  final String? closeReason;
}

class WebtritSignalingTimeoutException implements WebtritSignalingException {}

class WebtritSignalingErrorException implements WebtritSignalingException {
  const WebtritSignalingErrorException(this.code, this.reason);

  final int code;
  final String reason;

  @override
  String toString() => '$WebtritSignalingErrorException { code: $code, reason: "$reason" }';
}
