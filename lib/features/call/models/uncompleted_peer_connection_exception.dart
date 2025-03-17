class UncompletedPeerConnectionException implements Exception {
  final String message;

  UncompletedPeerConnectionException(this.message);

  @override
  String toString() => 'UncompletedPeerConnectionException: $message';
}
