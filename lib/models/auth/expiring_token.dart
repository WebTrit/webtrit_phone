class ExternalPageToken {
  const ExternalPageToken(this.accessToken, this.refreshToken, this.expiration);

  final String accessToken;
  final String refreshToken;
  final DateTime expiration;

  bool get isValid => DateTime.now().isBefore(expiration);
}
