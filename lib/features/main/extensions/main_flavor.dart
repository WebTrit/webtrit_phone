import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/contact_source_type.dart';

import '../../contacts/view/contacts_screen.dart';
import '../../favorites/view/favorites_screen.dart';
import '../../keypad/view/keypad_screen.dart';
import '../../recents/view/recents_screen.dart';
import '../models/main_flavor.dart';

extension MainFlavorLabelL10n on MainFlavor {
  String labelL10n(BuildContext context) {
    switch (this) {
      case MainFlavor.favorites:
        return context.l10n.main_BottomNavigationBarItemLabel_favorites;
      case MainFlavor.recents:
        return context.l10n.main_BottomNavigationBarItemLabel_recents;
      case MainFlavor.contacts:
        return context.l10n.main_BottomNavigationBarItemLabel_contacts;
      case MainFlavor.keypad:
        return context.l10n.main_BottomNavigationBarItemLabel_keypad;
    }
  }
}

extension MainFlavorIcon on MainFlavor {
  IconData get icon {
    switch (this) {
      case MainFlavor.favorites:
        return Icons.star_outline;
      case MainFlavor.recents:
        return Icons.access_time;
      case MainFlavor.contacts:
        return Icons.account_circle_outlined;
      case MainFlavor.keypad:
        return Icons.dialpad;
    }
  }
}

extension MainFlavorBuilder on MainFlavor {
  Widget builder(BuildContext context) {
    switch (this) {
      case MainFlavor.favorites:
        return const FavoritesScreen();
      case MainFlavor.recents:
        return const RecentsScreen();
      case MainFlavor.contacts:
        return const ContactsScreen(
          sourceTypes: [
            ContactSourceType.local,
            ContactSourceType.external,
          ],
        );
      case MainFlavor.keypad:
        return const KeypadScreen();
    }
  }
}
