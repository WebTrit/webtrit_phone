import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

extension OtpSigninIdentifiersInput on List<OtpSigninIdentifier> {
  bool get _hasPhone => contains(OtpSigninIdentifier.phoneNumber);

  bool get _hasEmail => contains(OtpSigninIdentifier.email);

  /// Input label matching the advertised OTP identifiers, so the hint only
  /// mentions inputs the backend actually accepts.
  String userRefLabel(BuildContext context) {
    final l10n = context.l10n;
    if (_hasPhone && !_hasEmail) return l10n.login_TextFieldLabelText_otpSigninUserRefPhone;
    if (_hasEmail && !_hasPhone) return l10n.login_TextFieldLabelText_otpSigninUserRefEmail;
    return l10n.login_TextFieldLabelText_otpSigninUserRef;
  }

  /// Account references may be alphanumeric (for example `ph123x456`) even when
  /// the backend advertises phone as the only OTP identifier, so a phone-only
  /// dial pad would wrongly block letters. Use a text keyboard whenever email is
  /// not advertised, and the email keyboard otherwise for the handy `@` key.
  TextInputType get userRefKeyboardType => _hasEmail ? TextInputType.emailAddress : TextInputType.text;

  List<String> get userRefAutofillHints {
    if (_hasPhone && !_hasEmail) return const [AutofillHints.telephoneNumber];
    if (_hasEmail && !_hasPhone) return const [AutofillHints.email];
    return const [AutofillHints.email, AutofillHints.telephoneNumber];
  }
}
