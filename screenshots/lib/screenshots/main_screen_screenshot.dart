import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

import 'package:screenshots/mocks/mocks.dart';

class MainScreenScreenshot extends StatelessWidget {
  const MainScreenScreenshot(
    this.flavor, {
    super.key,
  });

  final MainFlavor flavor;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CallBloc>(
          create: (context) => MockCallBloc.mainScreen(),
        ),
        BlocProvider<MainBloc>(
          create: (context) => MockMainBloc.mainScreen(),
        ),
      ],
      child: MainScreen(
        flavor,
        flavorWidgetBuilder: _flavorWidgetBuilder,
      ),
    );
  }

  Widget _flavorWidgetBuilder(BuildContext context, MainFlavor flavor) {
    switch (flavor) {
      case MainFlavor.favorites:
        const widget = FavoritesScreen();
        final provider = BlocProvider<FavoritesBloc>(
          create: (context) => MockFavoritesBloc.mainScreen(),
          child: widget,
        );
        return provider;
      case MainFlavor.recents:
        const widget = RecentsScreen(
          initialFilter: RecentsVisibilityFilter.all,
        );
        final provider = BlocProvider<RecentsBloc>(
          create: (context) => MockRecentsBloc.mainScreen(),
          child: widget,
        );
        return provider;
      case MainFlavor.contacts:
        final widget = ContactsScreen(
          sourceTypes: const [
            ContactSourceType.local,
            ContactSourceType.external,
          ],
          sourceTypeWidgetBuilder: _contactSourceTypeWidgetBuilder,
        );
        final provider = BlocProvider<ContactsSearchBloc>(
          create: (context) => MockContactsSearchBloc.mainScreen(),
          child: widget,
        );
        return provider;
      case MainFlavor.keypad:
        const widget = KeypadScreen();
        final provider = BlocProvider<KeypadCubit>(
          create: (context) => MockKeypadCubit.mainScreen(),
          child: widget,
        );
        return provider;
    }
  }

  Widget _contactSourceTypeWidgetBuilder(BuildContext context, ContactSourceType sourceType) {
    switch (sourceType) {
      case ContactSourceType.local:
        const widget = ContactsLocalTab();
        final provider = BlocProvider<ContactsLocalTabBloc>(
          create: (context) => MockContactsLocalTabBloc.mainScreen(),
          child: widget,
        );
        return provider;
      case ContactSourceType.external:
        const widget = ContactsExternalTab();
        final provider = BlocProvider<ContactsExternalTabBloc>(
          create: (context) => MockContactsExternalTabBloc.mainScreen(),
          child: widget,
        );
        return provider;
    }
  }
}
