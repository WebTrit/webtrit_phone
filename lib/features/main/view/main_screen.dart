import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/router/app_router.dart';

import '../main.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('MainScreen'));

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return AutoTabsScaffold(
      lazyLoad: false,
      routes: const [
        FavoritesTabPageRoute(),
        RecentsTabPageRoute(),
        ContactsTabPageRoute(),
        KeypadScreenPageRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: themeData.textTheme.bodySmall,
          unselectedLabelStyle: themeData.textTheme.bodySmall,
          onTap: tabsRouter.setActiveIndex,
          items: MainFlavor.values.map((flavor) {
            return BottomNavigationBarItem(
              icon: Icon(flavor.icon),
              label: flavor.labelL10n(context),
            );
          }).toList(),
        );
      },
    );
  }
}
