import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

@RoutePage()
class MainScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MainScreenPage();

  @override
  Widget build(BuildContext context) {
    final mainScreenRouteStateRepository = context.read<MainScreenRouteStateRepository>();

    final featureAccess = context.read<FeatureAccess>();
    final bottomMenuManager = featureAccess.bottomMenuConfig;
    final tabs = bottomMenuManager.tabs;

    // Reactive: rebuilds when the adapter capability becomes available (e.g. system-info loads async).
    final callToActionsEnabled = context.select<FeatureAccess, bool>(
      (features) => features.coreSupport.supportsCallToActions,
    );

    final systemNotificationsFeature = featureAccess.systemNotificationsConfig;
    final systemNotificationsEnabled = systemNotificationsFeature.systemNotificationsSupport;

    final autoTabsRouter = AutoTabsRouter(
      routes: _buildRoutePages(tabs),
      duration: Duration.zero,
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        if (callToActionsEnabled) {
          final isRouteActive = context.router.isRouteActive(MainScreenPageRoute.name);
          // The flavor belongs to the active tab, not to the position: the tab
          // set is configured per install, so an index into the enum points at
          // the wrong flavor and walks off it once more tabs are configured
          // than the enum has values.
          final flavor = tabs[tabsRouter.activeIndex].flavor;

          context.read<CallToActionsCubit>()
            ..getActions(flavor)
            ..changeVisibility(isRouteActive);
        }

        // Tabs are guaranteed to be non-empty due to validation during the bootstrap phase.
        // Therefore, we only check if there's more than one tab to determine the layout.
        return bottomMenuManager.tabs.length > 1
            ? MainScreen(
                body: child,
                tabs: tabs,
                // Be aware to use activeIndex from tabsRouter, not from bottomMenuManager
                // to handle navigation changes correctly, especially when the user navigates by url.
                // e.g router.navigate(const MainScreenPageRoute(['favorites']));
                currentIndex: tabsRouter.activeIndex,
                onTabSelected: (index) =>
                    BottomMenuTabHandler.handleTap(context, index: index, tabs: tabs, tabsRouter: tabsRouter),
              )
            : child;
      },
      navigatorObservers: () => [MainScreenNavigatorObserver(mainScreenRouteStateRepository)],
    );
    final content = callToActionsEnabled
        ? BlocProvider<CallToActionsCubit>(
            create: (context) => CallToActionsCubit(
              callToActionsRepository: context.read<CallToActionsRepository>(),
              userRepository: context.read<UserRepository>(),
              locale: context.read<AppBloc>().state.locale,
            ),
            child: CallToActionsShell(child: autoTabsRouter),
          )
        : autoTabsRouter;

    return BlocBuilder<CallPullCubit, List<DialogInfo>>(
      builder: (context, dialogs) {
        return AppBarParams(
          systemNotificationsEnabled: systemNotificationsEnabled,
          pullableCallDialogs: dialogs,
          child: content,
        );
      },
    );
  }

  List<PageRouteInfo> _buildRoutePages(List<BottomMenuTab> tabs) {
    return tabs.map<PageRouteInfo<dynamic>>((tab) {
      switch (tab) {
        case FavoritesBottomMenuTab():
          return const FavoritesRouterPageRoute();
        case KeypadBottomMenuTab():
          return const KeypadScreenPageRoute();
        case MessagingBottomMenuTab():
          return const ConversationsScreenPageRoute();
        case RecentsBottomMenuTab():
          return tab.supportsCallHistory ? const RecentCdrsRouterPageRoute() : const RecentsRouterPageRoute();
        case ContactsBottomMenuTab():
          return ContactsRouterPageRoute(children: [ContactsScreenPageRoute(sourceTypes: tab.contactSourceTypes)]);
        case EmbeddedBottomMenuTab():
          return EmbeddedTabPageRoute(id: tab.id);
      }
    }).toList();
  }
}

/// Handles the logic for bottom menu tab interactions and persistence.
abstract final class BottomMenuTabHandler {
  /// Processes a tab tap by persisting the selection and updating the UI router.
  static void handleTap(
    BuildContext context, {
    required int index,
    required List<BottomMenuTab> tabs,
    required TabsRouter tabsRouter,
  }) {
    final tappedTab = tabs[index];

    // Persist the selection to the repository
    context.read<ActiveMainFlavorRepository>().setActiveMainFlavor(tappedTab.flavor);

    // Update the actual UI state via AutoRoute
    tabsRouter.setActiveIndex(index);
  }
}
