import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/features/embedded/bloc/embedded_cubit.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

import 'package:screenshots/mocks/mocks.dart';

class MainScreenScreenshot extends StatelessWidget {
  const MainScreenScreenshot(
    this.flavor,
    this.title, {
    super.key,
  });

  final MainFlavor flavor;

  final Widget? title;

  @override
  Widget build(BuildContext context) {
    List<BottomMenuTab> tabs = [
      BottomMenuTab(
        enabled: true,
        initial: true,
        flavor: MainFlavor.favorites,
        titleL10n: 'main_BottomNavigationBarItemLabel_favorites',
        icon: Icons.star,
      ),
      BottomMenuTab(
        enabled: true,
        initial: false,
        flavor: MainFlavor.recents,
        titleL10n: ' main_BottomNavigationBarItemLabel_recents ',
        icon: Icons.history,
      ),
      BottomMenuTab(
        enabled: true,
        initial: false,
        flavor: MainFlavor.contacts,
        titleL10n: 'main_BottomNavigationBarItemLabel_contacts',
        icon: Icons.people,
      ),
      BottomMenuTab(
        enabled: true,
        initial: false,
        flavor: MainFlavor.keypad,
        titleL10n: 'main_BottomNavigationBarItemLabel_keypad',
        icon: Icons.dialpad,
      )
    ];

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
        body: _flavorWidgetBuilder(context, flavor),
        tabs: tabs,
        currentTab: tabs.firstWhere((tab) => tab.flavor == flavor),
      ),
    );
  }

  Widget _flavorWidgetBuilder(BuildContext context, MainFlavor flavor) {
    switch (flavor) {
      case MainFlavor.favorites:
        final widget = FavoritesScreen(
          title: title,
        );
        final provider = BlocProvider<FavoritesBloc>(
          create: (context) => MockFavoritesBloc.mainScreen(),
          child: widget,
        );
        return provider;
      case MainFlavor.recents:
        final widget = RecentsScreen(
          title: title,
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
          title: title,
        );
        final provider = BlocProvider<ContactsBloc>(
          create: (context) => MockContactsSearchBloc.mainScreen(),
          child: widget,
        );
        return provider;
      case MainFlavor.keypad:
        final widget = KeypadScreen(
          title: title,
        );
        final provider = BlocProvider<KeypadCubit>(
          create: (context) => MockKeypadCubit.mainScreen(),
          child: widget,
        );
        return provider;
      case MainFlavor.embedded1:
      case MainFlavor.embedded2:
      case MainFlavor.embedded3:
        final provider = BlocProvider<EmbeddedCubit>(
          create: (context) => MockEmbeddedCubit.mainScreen(),
          child: EmbeddedScreen(
            initialUri: Uri.parse('htts://example.com'),
            title: const Text("Embedded page"),
          ),
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
