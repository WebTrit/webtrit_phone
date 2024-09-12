import 'package:flutter/widgets.dart';

import 'package:webtrit_phone/l10n/app_localizations.g.mapper.dart';

import 'app_localizations.g.dart';
export 'app_localizations.g.dart';

export 'default_error_l10n.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  String findL10n(String translationKey, {List<Object>? arguments}) =>
      parseL10n(translationKey, arguments: arguments) ?? translationKey;
}
