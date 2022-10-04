import 'dart:io';

import 'package:flutter/material.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../cubit/login_cubit.dart';

extension LoginStateErrorL10n on LoginState {
  String? errorL10n(BuildContext context) {
    final error = this.error;
    if (error != null) {
      if (error is LoginIncompatibleCoreVersionException) {
        return context.l10n
            .login_LoginIncompatibleCoreVersionExceptionError(error.actual.toString(), error.expected.toString());
      } else if (error is FormatException) {
        return context.l10n.login_FormatExceptionError;
      } else if (error is TlsException) {
        return context.l10n.login_TlsExceptionError;
      } else if (error is SocketException) {
        return context.l10n.login_SocketExceptionError;
      } else if (error is TypeError) {
        return context.l10n.login_TypeErrorError;
      } else if (error is RequestFailure) {
        switch (error.error?.code) {
          // sessionOtpRequest
          case 'phone_not_found':
            return context.l10n.login_RequestFailurePhoneNotFoundError;
          case 'empty_email':
            return context.l10n.login_RequestFailureEmptyEmailError;
          // sessionOtpVerify
          case 'code_incorrect':
            return context.l10n.login_RequestFailureCodeIncorrectError;
          case 'otp_id_verify_attempts_exceeded':
            return context.l10n.login_RequestFailureOtpIdVerifyAttemptsExceededError;
          //
          default:
            return context.l10n.login_RequestFailureError;
        }
      } else {
        return error.toString();
      }
    } else {
      return null;
    }
  }
}
