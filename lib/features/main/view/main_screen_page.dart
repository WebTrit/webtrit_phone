import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_info_extractor/store_info_extractor.dart';
import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class MainScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MainScreenPage();

  get bottomMenuFlavorManager => AppFeatureAvailability().bottomMenuFlavorManager;

  @override
  Widget build(BuildContext context) {
    final appPreferences = context.read<AppPreferences>();
    const appDemoFlow = EnvironmentConfig.CORE_URL == null;

    final autoTabsRouter = AutoTabsRouter(
      routes: buildList(),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        // Set the active index after the builder is executed

        // final isRouteActive = context.router.isRouteActive(MainScreenPageRoute.name);
        // final flavor = bottomMenuFlavorManager.flavorByPosition(tabsRouter.activeIndex);
        // if (appDemoFlow) {
        //   final locale = context.read<AppBloc>().state.locale;
        //
        //   context.read<DemoCubit>().updateConfiguration(flavor: flavor, enable: isRouteActive, locale: locale);
        //   context.read<DemoCubit>().getActions();
        // }

        return MainScreen(
          body: child,
          flavors: bottomMenuFlavorManager.flavors,
          activeFlavor: bottomMenuFlavorManager.activeFlavor,
          onNavigationBarTap: (flavor) {
            tabsRouter.setActiveIndex(bottomMenuFlavorManager.positionOfFlavor(flavor));
            bottomMenuFlavorManager.activeFlavor = flavor;
            // appPreferences.setActiveMainFlavor(flavor);
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
      child: appDemoFlow
          ? BlocProvider<DemoCubit>(
              create: (context) => DemoCubit(
                webtritApiClient: context.read<WebtritApiClient>(),
                token: context.read<AppBloc>().state.token!,
                flavor: bottomMenuFlavorManager.activeFlavor,
                locale: context.read<AppBloc>().state.locale,
              ),
              child: DemoShell(child: autoTabsRouter),
            )
          : autoTabsRouter,
    );

    final blocListener = BlocListener<AppBloc, AppState>(
      listenWhen: (previous, current) =>
          previous.accountErrorCode != current.accountErrorCode && current.accountErrorCode != null,
      listener: (BuildContext context, state) {
        context.showErrorSnackBar(state.accountErrorCode!.l10n(context));
        context.read<AppBloc>().add(const AppLogoutedTeardown());
      },
      child: provider,
    );

    return blocListener;
  }

  List<PageRouteInfo> buildList() {
    return bottomMenuFlavorManager.flavors.map<PageRouteInfo<dynamic>>((flavor) {
      switch (flavor.type) {
        case MainFlavorType.favorites:
          return const FavoritesRouterPageRoute();
        case MainFlavorType.recents:
          return const RecentsRouterPageRoute();
        case MainFlavorType.contacts:
          return const ContactsRouterPageRoute();
        case MainFlavorType.keypad:
          return const KeypadScreenPageRoute();
        case MainFlavorType.embedded:
          return EmbeddedScreenPageRoute(id: 'Tab ${flavor.path}');
        default:
          throw Exception('Unknown flavor type');
      }
    }).toList();
  }
}
