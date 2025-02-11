import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
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
    // Fetch tabs for the bottom menu using FeatureAccess, which is specifically used in the configurator project.
    // If FeatureAccess is not available, fallback to predefined default tabs.
    final tabs = context.read<FeatureAccess?>()?.bottomMenuFeature.tabs ?? _defaultTabs(context);
    return MultiBlocProvider(
      providers: _createMockBlocProviders(),
      child: MainScreen(
        body: _buildFlavorWidget(context, flavor),
        bottomNavigationBar: _buildBottomNavigationBar(tabs),
      ),
    );
  }

  List<BlocProvider> _createMockBlocProviders() {
    return [
      BlocProvider<CallBloc>(create: (_) => MockCallBloc.mainScreen()),
      BlocProvider<MainBloc>(create: (_) => MockMainBloc.mainScreen()),
      BlocProvider<SessionStatusCubit>(create: (_) => MockSessionStatusCubit.initial()),
      BlocProvider<UserInfoCubit>(create: (_) => MockUserInfoCubit.initial()),
    ];
  }

  List<BottomMenuTab> _defaultTabs(BuildContext context) {
    return [
      BottomMenuTab(
        enabled: true,
        initial: true,
        flavor: MainFlavor.favorites,
        titleL10n: context.parseL10n('main_BottomNavigationBarItemLabel_favorites'),
        icon: Icons.star,
      ),
      BottomMenuTab(
        enabled: true,
        initial: false,
        flavor: MainFlavor.recents,
        titleL10n: context.parseL10n('main_BottomNavigationBarItemLabel_recents'),
        icon: Icons.history,
      ),
      BottomMenuTab(
        enabled: true,
        initial: false,
        flavor: MainFlavor.contacts,
        titleL10n: context.parseL10n('main_BottomNavigationBarItemLabel_contacts'),
        icon: Icons.people,
      ),
      BottomMenuTab(
        enabled: true,
        initial: false,
        flavor: MainFlavor.keypad,
        titleL10n: context.parseL10n('main_BottomNavigationBarItemLabel_keypad'),
        icon: Icons.dialpad,
      ),
    ];
  }

  BottomNavigationBar _buildBottomNavigationBar(List<BottomMenuTab> tabs) {
    return BottomNavigationBar(
      currentIndex: tabs.indexWhere((tab) => tab.flavor == flavor),
      items: tabs
          .map((tab) => BottomNavigationBarItem(
                icon: Icon(tab.icon),
                label: tab.titleL10n,
              ))
          .toList(),
    );
  }

  Widget _buildFlavorWidget(BuildContext context, MainFlavor flavor) {
    switch (flavor) {
      case MainFlavor.favorites:
        return BlocProvider<FavoritesBloc>(
          create: (_) => MockFavoritesBloc.mainScreen(),
          child: FavoritesScreen(
            title: title,
            videoCallEnable: true,
          ),
        );
      case MainFlavor.recents:
        return BlocProvider<RecentsBloc>(
          create: (_) => MockRecentsBloc.mainScreen(),
          child: RecentsScreen(
            title: title,
            videoCallEnable: true,
            chatsEnabled: false,
          ),
        );
      case MainFlavor.contacts:
        return BlocProvider<ContactsBloc>(
          create: (_) => MockContactsSearchBloc.mainScreen(),
          child: ContactsScreen(
            sourceTypes: const [
              ContactSourceType.local,
              ContactSourceType.external,
            ],
            sourceTypeWidgetBuilder: _buildContactSourceTypeWidget,
            title: title,
          ),
        );
      case MainFlavor.keypad:
        return BlocProvider<KeypadCubit>(
          create: (_) => MockKeypadCubit.mainScreen(),
          child: KeypadScreen(
            title: title,
            videoVisible: true,
          ),
        );
      case MainFlavor.embedded1:
      case MainFlavor.embedded2:
      case MainFlavor.embedded3:
        return BlocProvider<EmbeddedCubit>(
          create: (_) => MockEmbeddedCubit.mainScreen(),
          child: EmbeddedScreen(
            initialUri: Uri.parse('https://example.com'),
            appBar: MainAppBar(
              title: const Text('Embedded'),
            ),
          ),
        );
      case MainFlavor.messaging:
        return const Placeholder();
    }
  }

  Widget _buildContactSourceTypeWidget(BuildContext context, ContactSourceType sourceType) {
    switch (sourceType) {
      case ContactSourceType.local:
        return BlocProvider<ContactsLocalTabBloc>(
          create: (_) => MockContactsLocalTabBloc.mainScreen(),
          child: const ContactsLocalTab(),
        );
      case ContactSourceType.external:
        return BlocProvider<ContactsExternalTabBloc>(
          create: (_) => MockContactsExternalTabBloc.mainScreen(),
          child: const ContactsExternalTab(),
        );
    }
  }
}
