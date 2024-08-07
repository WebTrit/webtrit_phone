import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_info_extractor/store_info_extractor.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
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

    final autoTabsRouter = AutoTabsRouter(
      routes: const [
        FavoritesRouterPageRoute(),
        RecentsRouterPageRoute(),
        ContactsRouterPageRoute(),
        KeypadScreenPageRoute(),
      ],
      duration: Duration.zero,
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final isRouteActive = context.router.isRouteActive(MainScreenPageRoute.name);
        final flavor = MainFlavor.values[tabsRouter.activeIndex];

        if (appDemoFlow) {
          final locale = context.read<AppBloc>().state.locale;

          context.read<DemoCubit>().updateConfiguration(flavor: flavor, enable: isRouteActive, locale: locale);
          context.read<DemoCubit>().getActions();
        }

        return MainScreen(
          body: child,
          navigationBarFlavor: flavor,
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
      child: appDemoFlow
          ? BlocProvider<DemoCubit>(
              create: (context) => DemoCubit(
                webtritApiClient: context.read<WebtritApiClient>(),
                token: context.read<AppBloc>().state.token!,
                flavor: MainFlavor.contacts,
                locale: context.read<AppBloc>().state.locale,
              ),
              child: DemoShell(child: autoTabsRouter),
            )
          : autoTabsRouter,
    );

    return provider;
  }
}
