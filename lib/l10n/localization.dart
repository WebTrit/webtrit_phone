import 'package:flutter/widgets.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'l10n.dart';

export 'default_error_l10n.dart';

extension AppLocalizationsX on BuildContext {
  AppIntlLocalizations get l10n => AppIntlLocalizations.of(this);
}

extension AppLocalizations on AppIntlLocalizations {
  String get localeName => Intl.canonicalizedLocale(Intl.defaultLocale);

  static List<Locale> get supportedLocales => AppIntlLocalizations.delegate.supportedLocales;

  static List<LocalizationsDelegate<dynamic>> get localizationsDelegates => [
        AppIntlLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];
}
