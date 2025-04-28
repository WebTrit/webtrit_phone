class ExpiringToken {
  const ExpiringToken(this.token, this.refreshToken, this.expiration);

  final String token;
  final String refreshToken;
  final DateTime expiration;

  bool get isValid => DateTime.now().isBefore(expiration);
}
