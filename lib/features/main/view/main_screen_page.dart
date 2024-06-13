import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_info_extractor/store_info_extractor.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class MainScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MainScreenPage();

  @override
  Widget build(BuildContext context) {
    final appPreferences = context.read<AppPreferences>();
    final autoTabsRouter = AutoTabsRouter(
      routes: const [
        FavoritesRouterPageRoute(),
        RecentsRouterPageRoute(),
        ContactsRouterPageRoute(),
        KeypadScreenPageRoute(),
        ChatsRouterPageRoute()
      ],
      duration: Duration.zero,
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return MainScreen(
          body: child,
          navigationBarFlavor: MainFlavor.values[tabsRouter.activeIndex],
          onNavigationBarTap: (flavor) {
            tabsRouter.setActiveIndex(flavor.index);

            appPreferences.setActiveMainFlavor(flavor);
          },
        );
      },
    );

    final provider = BlocProvider(
      create: (context) {
        return MainBloc(
          infoRepository: context.read<InfoRepository>(),
          storeInfoExtractor: StoreInfoExtractor(),
        )..add(const MainStarted());
      },
      child: autoTabsRouter,
    );
    return provider;
  }
}
