import 'dart:io';

import 'package:flutter/material.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../bloc/settings_bloc.dart';

extension SettingsStateErrorL10n on SettingsState {
  String? errorL10n(BuildContext context) {
    if (error != null) {
      if (error is FormatException) {
        return context.l10n.settings_FormatExceptionError;
      } else if (error is SocketException) {
        return context.l10n.settings_SocketExceptionError;
      } else if (error is TypeError) {
        return context.l10n.settings_TypeErrorError;
      } else if (error is RequestFailure) {
        return context.l10n.settings_RequestFailureError;
      } else {
        return error.toString();
      }
    } else {
      return null;
    }
  }
}
