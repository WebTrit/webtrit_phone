import 'package:flutter/material.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/app/core_version.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../cubit/login_cubit.dart';

extension LoginStateErrorL10n on LoginState {
  String? errorL10n(BuildContext context) {
    final error = this.error;
    if (error == null) {
      return null;
    } else {
      if (error is CoreVersionUnsupportedException) {
        return context.l10n.login_CoreVersionUnsupportedExceptionError(
          error.actual.toString(),
          error.supportedConstraint.toString(),
        );
      } else if (error is SupportedLoginTypeMissedException) {
        return context.l10n.login_SupportedLoginTypeMissedExceptionError;
      } else if (error is RequestFailure) {
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

      return defaultErrorL10n(context, error);
    }
  }

  List<ErrorFieldModel>? errorDetails(BuildContext context) {
    return error?.castToOrNull<RequestFailure>()?.errorFields(context);
  }
}
