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

  @override
  Widget build(BuildContext context) {
    final appPreferences = context.read<AppPreferences>();
    const appDemoFlow = EnvironmentConfig.CORE_URL == null;

    final allowedFlavors = getAllowedFlavors();

    final autoTabsRouter = AutoTabsRouter(
      routes: allowedFlavors.map((flavor) {
        switch (flavor) {
          case MainFlavor.favorites:
            return const FavoritesRouterPageRoute();
          case MainFlavor.recents:
            return const RecentsRouterPageRoute();
          case MainFlavor.contacts:
            return const ContactsRouterPageRoute();
          case MainFlavor.keypad:
            return const KeypadScreenPageRoute();
        }
      }).toList(),
      duration: Duration.zero,
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final isRouteActive = context.router.isRouteActive(MainScreenPageRoute.name);
        final flavor = allowedFlavors[tabsRouter.activeIndex];

        if (appDemoFlow) {
          final locale = context.read<AppBloc>().state.locale;

          context.read<DemoCubit>().updateConfiguration(
                flavor: flavor,
                enable: isRouteActive,
                locale: locale,
              );
          context.read<DemoCubit>().getActions();
        }

        return MainScreen(
          body: child,
          navigationBarFlavor: flavor,
          allowedFlavors: allowedFlavors,
          onNavigationBarTap: (flavor) {
            final index = allowedFlavors.indexOf(flavor);
            if (index != -1) {
              tabsRouter.setActiveIndex(index);
              appPreferences.setActiveMainFlavor(flavor);
            }
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
                flavor: allowedFlavors.contains(MainFlavor.contacts) ? MainFlavor.contacts : allowedFlavors.first,
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

  List<MainFlavor> getAllowedFlavors() {
    return MainFlavor.values.where((flavor) {
      switch (flavor) {
        case MainFlavor.keypad:
          return EnvironmentConfig.KEYPAD_FEATURE_ENABLE;
        case MainFlavor.favorites:
          return EnvironmentConfig.FAVOURITE_FEATURE_ENABLE;
        case MainFlavor.contacts:
          return EnvironmentConfig.CONTACT_FEATURE_ENABLE;
        case MainFlavor.recents:
          return EnvironmentConfig.RECENT_FEATURE_ENABLE;
      }
    }).toList();
  }
}
