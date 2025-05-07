class ExternalPageToken {
  const ExternalPageToken(this.accessToken, this.refreshToken, this.expiration);

  final String accessToken;
  final String refreshToken;
  final DateTime expiration;

  static const Duration _expirationBuffer = Duration(minutes: 5);

  bool get isValid => DateTime.now().isBefore(expiration.subtract(_expirationBuffer));
}
