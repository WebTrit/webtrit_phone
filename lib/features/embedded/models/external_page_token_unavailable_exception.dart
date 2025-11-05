class ExternalPageTokenUnavailableException implements Exception {
  ExternalPageTokenUnavailableException([this.message = 'External page token is unavailable.']);

  final String message;

  @override
  String toString() => 'ExternalPageTokenUnavailableException: $message';
}
