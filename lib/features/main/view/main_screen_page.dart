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
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class MainScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MainScreenPage();

  @override
  Widget build(BuildContext context) {
    final mainScreenRouteStateRepository = context.read<MainScreenRouteStateRepository>();
    const appDemoFlow = EnvironmentConfig.CORE_URL == null;

    final bottomMenuManager = context.read<FeatureAccess>().bottomMenuFeature;

    final autoTabsRouter = AutoTabsRouter(
      routes: _buildRoutePages(bottomMenuManager.tabs),
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

        // Tabs are guaranteed to be non-empty due to validation during the bootstrap phase.
        // Therefore, we only check if there's more than one tab to determine the layout.
        return bottomMenuManager.tabs.length > 1
            ? MainScreen(
                body: child,
                currentTab: bottomMenuManager.activeTab,
                tabs: bottomMenuManager.tabs,
                onNavigationBarTap: (flavor) {
                  bottomMenuManager.activeFlavor = flavor;
                  tabsRouter.setActiveIndex(bottomMenuManager.activeIndex);
                },
              )
            : child;
      },
      navigatorObservers: () => [MainScreenNavigatorObserver(mainScreenRouteStateRepository)],
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

  List<PageRouteInfo> _buildRoutePages(List<BottomMenuTab> tabs) {
    return tabs.map<PageRouteInfo<dynamic>>((tab) {
      switch (tab.flavor) {
        case MainFlavor.favorites:
          return const FavoritesRouterPageRoute();
        case MainFlavor.recents:
          return const RecentsRouterPageRoute();
        case MainFlavor.contacts:
          return ContactsRouterPageRoute(
            children: [
              ContactsScreenPageRoute(
                sourceTypes: tab.toContacts.contactSourceTypes,
              )
            ],
          );
        case MainFlavor.keypad:
          return const KeypadScreenPageRoute();
        case MainFlavor.messaging:
          return const MessagingRouterPageRoute();
        default:
          final embedded = EmbeddedScreenPage.getPageRoute(tab.flavor, tab.data!);
          if (embedded != null) {
            return embedded;
          }
          throw Exception('Unknown flavor type: ${tab.flavor}');
      }
    }).toList();
  }
}
