import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ContactsSource {
  local,
  external,
}

extension ContactsSourceI10nExtension on ContactsSource {
  String l10n(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    switch (this) {
      case ContactsSource.local:
        return appLocalizations.contactsSourceLocal;
      case ContactsSource.external:
        return appLocalizations.contactsSourceExternal;
      default:
        return null;
    }
  }
}
