class ExpiringToken {
  const ExpiringToken(this.token, this.expiration);

  final String token;
  final DateTime expiration;

  bool get isValid => DateTime.now().isBefore(expiration);
}
