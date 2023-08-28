import 'package:flutter/widgets.dart';

import 'app_localizations.g.dart';
export 'app_localizations.g.dart';

export 'default_error_l10n.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
