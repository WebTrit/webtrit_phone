import 'package:flutter/material.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/notifications/models/notification.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

@Deprecated.instantiate('will be removed, (see [app/notifications/models/notification.dart] for details)')
final class LoginErrorNotification extends DefaultErrorNotification {
  LoginErrorNotification(super.error);

  @override
  String l10n(BuildContext context) {
    final error = this.error;
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
    return super.l10n(context);
  }
}

final class LoginOtpNotFoundNotification extends MessageNotification {
  const LoginOtpNotFoundNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.login_RequestFailureOtpNotFoundError;
  }
}

final class LoginIncorrectOtpCodeNotification extends MessageNotification {
  const LoginIncorrectOtpCodeNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.login_RequestFailureIncorrectOtpCodeError;
  }
}

final class LoginOtpExpiredNotification extends MessageNotification {
  const LoginOtpExpiredNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.login_RequestFailureOtpExpiredError;
  }
}

final class LoginOtpVerificationAttemptsExceededNotification extends MessageNotification {
  const LoginOtpVerificationAttemptsExceededNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.login_RequestFailureOtpVerificationAttemptsExceededError;
  }
}

final class LoginOtpAlreadyVerifiedNotification extends MessageNotification {
  const LoginOtpAlreadyVerifiedNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.login_RequestFailureOtpAlreadyVerifiedError;
  }
}

final class LoginPhoneNotFoundNotification extends MessageNotification {
  const LoginPhoneNotFoundNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.login_RequestFailurePhoneNotFoundError;
  }
}

final class LoginIncorrectCredentialsNotification extends MessageNotification {
  const LoginIncorrectCredentialsNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.login_RequestFailureIncorrectCredentialsError;
  }
}

final class LoginUserNotFoundNotification extends MessageNotification {
  const LoginUserNotFoundNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.login_RequestFailureUserNotFoundError;
  }
}

final class LoginUnconfiguredBundleIdNotification extends MessageNotification {
  const LoginUnconfiguredBundleIdNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.login_RequestFailureUnconfiguredBundleIdError;
  }
}

final class LoginValidationErrorNotification extends MessageNotification {
  const LoginValidationErrorNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.login_RequestFailureIdentifierIsNotValid;
  }
}

final class LoginParametersApplyIssueNotification extends MessageNotification {
  const LoginParametersApplyIssueNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.login_RequestFailureParametersApplyIssueError;
  }
}

final class LoginEmptyEmailNotification extends MessageNotification {
  const LoginEmptyEmailNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.login_RequestFailureEmptyEmailError;
  }
}

final class SupportedLoginTypeMissedErrorNotification extends MessageNotification {
  const SupportedLoginTypeMissedErrorNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.login_SupportedLoginTypeMissedExceptionError;
  }
}

final class CoreVersionUnsupportedErrorNotification extends MessageNotification {
  const CoreVersionUnsupportedErrorNotification(this.actual, this.supportedConstraint);

  final String actual;
  final String supportedConstraint;

  @override
  String l10n(BuildContext context) {
    return context.l10n.login_CoreVersionUnsupportedExceptionError(actual, supportedConstraint);
  }
}
