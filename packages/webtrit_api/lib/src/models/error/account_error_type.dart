enum AccountErrorType {
  passwordChangeRequired('password_change_required');

  final String code;

  const AccountErrorType(this.code);
}
