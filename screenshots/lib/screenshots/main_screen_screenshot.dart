import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

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
      const BottomMenuTab(
        enabled: true,
        initial: true,
        flavor: MainFlavor.favorites,
        titleL10n: 'main_BottomNavigationBarItemLabel_favorites',
        icon: Icons.star,
      ),
      const BottomMenuTab(
        enabled: true,
        initial: false,
        flavor: MainFlavor.recents,
        titleL10n: ' main_BottomNavigationBarItemLabel_recents ',
        icon: Icons.history,
      ),
      const BottomMenuTab(
        enabled: true,
        initial: false,
        flavor: MainFlavor.contacts,
        titleL10n: 'main_BottomNavigationBarItemLabel_contacts',
        icon: Icons.people,
      ),
      const BottomMenuTab(
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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: tabs.indexWhere((tab) => tab.flavor == flavor),
          items: tabs.map((tab) => BottomNavigationBarItem(icon: Icon(tab.icon), label: tab.titleL10n)).toList(),
        ),
      ),
    );
  }

  Widget _flavorWidgetBuilder(BuildContext context, MainFlavor flavor) {
    switch (flavor) {
      case MainFlavor.favorites:
        final widget = FavoritesScreen(
          title: title,
          videoCallEnable: true,
        );
        final provider = BlocProvider<FavoritesBloc>(
          create: (context) => MockFavoritesBloc.mainScreen(),
          child: widget,
        );
        return provider;
      case MainFlavor.recents:
        final widget = RecentsScreen(
          title: title,
          videoCallEnable: true,
          chatsEnabled: false,
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
          videoVisible: true,
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
            initialUri: Uri.parse('https://example.com'),
            appBar: MainAppBar(
              title: const Text('Embedded'),
            ),
          ),
        );
        return provider;
      case MainFlavor.messaging:
        const widget = Placeholder();
        return widget;
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
