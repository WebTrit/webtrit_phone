enum AccountErrorCode {
  passwordChangeRequired('password_change_required'),
  userNotFound('user_not_found');

  final String value;

  const AccountErrorCode(this.value);
}
