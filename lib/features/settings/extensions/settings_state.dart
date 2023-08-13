import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../bloc/settings_bloc.dart';

extension SettingsStateErrorL10n on SettingsState {
  String? errorL10n(BuildContext context) {
    final error = this.error;
    if (error == null) {
      return null;
    } else {
      return defaultErrorL10n(context, error);
    }
  }
}
