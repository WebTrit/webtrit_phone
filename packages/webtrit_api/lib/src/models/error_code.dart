enum AccountErrorCode {
  passwordChangeRequired('password_change_required');

  final String value;

  const AccountErrorCode(this.value);
}
