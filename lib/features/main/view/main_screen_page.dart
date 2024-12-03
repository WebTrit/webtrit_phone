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
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class MainScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MainScreenPage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mainScreenRouteStateRepository = context.read<MainScreenRouteStateRepository>();
    // TODO(Serdun): Move this to the environment configuration not to use the CORE_URL.
    const appDemoFlow = EnvironmentConfig.CORE_URL == null;

    final bottomMenuManager = context.read<FeatureAccess>().bottomMenuFeature;
    final tabs = bottomMenuManager.tabs;

    final autoTabsRouter = AutoTabsRouter(
      routes: _buildRoutePages(tabs),
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
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  selectedLabelStyle: theme.textTheme.bodySmall,
                  unselectedLabelStyle: theme.textTheme.bodySmall,
                  // Be aware to use activeIndex from tabsRouter, not from bottomMenuManager
                  // to handle navigation changes correctly, especially when the user navigates by url.
                  // e.g router.navigate(const MainScreenPageRoute(['favorites']));
                  currentIndex: tabsRouter.activeIndex,
                  items: _buildNavBarItems(context, tabs),
                  onTap: (index) {
                    final activeTab = tabs[index];
                    bottomMenuManager.activeFlavor = activeTab;
                    tabsRouter.setActiveIndex(bottomMenuManager.activeIndex);
                  },
                  // items: navBarItems,
                ),
              )
            : child;
      },
      navigatorObservers: () => [MainScreenNavigatorObserver(mainScreenRouteStateRepository)],
    );
    final provider = BlocProvider(
      create: (context) {
        return MainBloc(
          context.read<SystemInfoRepository>(),
          AppPreferences(),
          EnvironmentConfig.CORE_VERSION_CONSTRAINT,
          storeInfoExtractor: StoreInfoExtractor(),
        )..add(const MainBlocInit());
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
          return const ConversationsScreenPageRoute();
        default:
          final embedded = EmbeddedScreenPage.getPageRoute(tab.flavor, tab.data!);
          if (embedded != null) {
            return embedded;
          }
          throw Exception('Unknown flavor type: ${tab.flavor}');
      }
    }).toList();
  }

  List<BottomNavigationBarItem> _buildNavBarItems(BuildContext context, List<BottomMenuTab> tabs) {
    return tabs.map((tab) {
      final flavor = tab.flavor;
      Widget icon = Icon(tab.icon);
      String label = context.parseL10n(tab.titleL10n);
      if (flavor == MainFlavor.messaging) icon = MessagingFlavorOverlay(child: icon);
      return BottomNavigationBarItem(icon: icon, label: label);
    }).toList();
  }
}
