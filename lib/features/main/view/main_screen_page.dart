import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_info_extractor/store_info_extractor.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

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

    final featureAccess = context.read<FeatureAccess>();
    final bottomMenuManager = featureAccess.bottomMenuFeature;
    final tabs = bottomMenuManager.tabs;

    final systemNotificationsFeature = featureAccess.systemNotificationsFeature;
    final systemNotificationsEnabled = systemNotificationsFeature.systemNotificationsSupport;

    final autoTabsRouter = AutoTabsRouter(
      routes: _buildRoutePages(tabs),
      duration: Duration.zero,
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        if (appDemoFlow) {
          final isRouteActive = context.router.isRouteActive(MainScreenPageRoute.name);
          final tabsRouter = AutoTabsRouter.of(context);
          final flavor = MainFlavor.values[tabsRouter.activeIndex];

          context.read<CallToActionsCubit>()
            ..getActions(flavor)
            ..changeVisibility(isRouteActive);
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
          context.read<PrivateGatewayRepository>(),
          context.read<AppPreferences>(),
          EnvironmentConfig.CORE_VERSION_CONSTRAINT,
          context.read<PackageInfo>(),
          storeInfoExtractor: StoreInfoExtractor(),
        )..add(const MainBlocInit());
      },
      child: appDemoFlow
          ? BlocProvider<CallToActionsCubit>(
              create: (context) => CallToActionsCubit(
                callToActionsRepository: context.read<CallToActionsRepository>(),
                locale: context.read<AppBloc>().state.locale,
              ),
              child: CallToActionsShell(child: autoTabsRouter),
            )
          : autoTabsRouter,
    );

    return BlocBuilder<CallPullCubit, List<PullableCall>>(
      builder: (context, state) {
        return AppBarParams(
          systemNotificationsEnabled: systemNotificationsEnabled,
          pullableCalls: state,
          child: provider,
        );
      },
    );
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
                sourceTypes: tab.toContacts?.contactSourceTypes ?? [],
              )
            ],
          );
        case MainFlavor.keypad:
          return const KeypadScreenPageRoute();
        case MainFlavor.messaging:
          return const ConversationsScreenPageRoute();
        default:
          return EmbeddedTabPageRoute(id: tab.toEmbedded!.id);
      }
    }).toList();
  }

  List<BottomNavigationBarItem> _buildNavBarItems(BuildContext context, List<BottomMenuTab> tabs) {
    return tabs.map((tab) {
      final flavor = tab.flavor;
      Widget icon = Icon(tab.icon);
      String label = context.parseL10n(tab.titleL10n);
      if (flavor == MainFlavor.messaging) icon = MessagingFlavorOverlay(child: icon);
      return BottomNavigationBarItem(key: flavor.toNavBarKey(), icon: icon, label: label);
    }).toList();
  }
}
