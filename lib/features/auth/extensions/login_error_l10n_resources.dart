import 'package:flutter/material.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/core_version.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

extension LoginErrorL10nResources on Exception {
  String errorL10n(BuildContext context) {
    if (this is CoreVersionUnsupportedException) {
      final coreException = this as CoreVersionUnsupportedException;
      return context.l10n.login_CoreVersionUnsupportedExceptionError(
        coreException.actual.toString(),
        coreException.supportedConstraint.toString(),
      );
    } else if (this is RequestFailure) {
      final coreException = this as RequestFailure;

      switch (coreException.error?.code) {
        // sessionOtpRequest
        case 'unconfigured_bundle_id':
          return context.l10n.login_RequestFailureUnconfiguredBundleIdError;
        case 'phone_not_found':
          return context.l10n.login_RequestFailurePhoneNotFoundError;
        case 'empty_email':
          return context.l10n.login_RequestFailureEmptyEmailError;
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
    return defaultErrorL10n(context, this);
  }
}
