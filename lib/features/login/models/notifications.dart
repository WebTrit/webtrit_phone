import 'package:flutter/material.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

final class LoginErrorNotification extends DefaultErrorNotification {
  const LoginErrorNotification(super.error);

  @override
  String l10n(BuildContext context) => _loginErrorL10n(context, error) ?? super.l10n(context);
}

final class SupportedLoginTypeMissedErrorNotification extends ErrorNotification {
  const SupportedLoginTypeMissedErrorNotification();

  @override
  String l10n(BuildContext context) => context.l10n.login_SupportedLoginTypeMissedExceptionError;
}

final class CoreVersionUnsupportedErrorNotification extends ErrorNotification {
  const CoreVersionUnsupportedErrorNotification(this.actual, this.supportedConstraint);

  final String actual;
  final String supportedConstraint;

  @override
  String l10n(BuildContext context) =>
      context.l10n.login_CoreVersionUnsupportedExceptionError(actual, supportedConstraint);
}

String? _loginErrorL10n(BuildContext context, Object error) {
  if (error is RequestFailure) {
    switch (error.error?.code) {
      case 'parameters_apply_issue':
        return context.l10n.login_RequestFailureParametersApplyIssueError;
      // sessionOtpRequest
      case 'unconfigured_bundle_id':
        return context.l10n.login_RequestFailureUnconfiguredBundleIdError;
      case 'phone_not_found':
        return context.l10n.login_RequestFailurePhoneNotFoundError;
      case 'empty_email':
        return context.l10n.login_RequestFailureEmptyEmailError;
      case 'validation_error':
        return context.l10n.login_RequestFailureIdentifierIsNotValid;
      // sessionOtpVerify
      case 'otp_already_verified':
        return context.l10n.login_RequestFailureOtpAlreadyVerifiedError;
      case 'otp_verification_attempts_exceeded':
        return context.l10n.login_RequestFailureOtpVerificationAttemptsExceededError;
      case 'otp_expired':
        return context.l10n.login_RequestFailureOtpExpiredError;
      case 'incorrect_otp_code':
        return context.l10n.login_RequestFailureIncorrectOtpCodeError;
      case 'otp_not_found':
        return context.l10n.login_RequestFailureOtpNotFoundError;
    }
  }
  return null;
}
