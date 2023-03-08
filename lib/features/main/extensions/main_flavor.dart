import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../../call/call.dart';
import '../../contacts/contacts.dart';
import '../../favorites/favorites.dart';
import '../../keypad/keypad.dart';
import '../../recents/recents.dart';
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
        const widget = FavoritesScreen();
        final provider = BlocProvider(
          create: (context) => FavoritesBloc(
            favoritesRepository: context.read<FavoritesRepository>(),
          )..add(const FavoritesStarted()),
          child: widget,
        );
        return provider;
      case MainFlavor.recents:
        final widget = RecentsScreen(
          initialFilter: context.read<RecentsBloc>().state.filter,
        );
        return widget;
      case MainFlavor.contacts:
        const widget = ContactsScreen(
          sourceTypes: [
            ContactSourceType.local,
            ContactSourceType.external,
          ],
        );
        final provider = BlocProvider(
          create: (context) => ContactsSearchBloc(),
          child: widget,
        );
        return provider;
      case MainFlavor.keypad:
        const widget = KeypadScreen();
        final provider = BlocProvider(
          create: (context) => KeypadCubit(
            callBloc: context.read<CallBloc>(),
          ),
          child: widget,
        );
        return provider;
    }
  }
}
