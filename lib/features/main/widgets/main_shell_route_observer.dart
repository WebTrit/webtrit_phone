import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('MainShellNavigatorObserver');

class MainShellNavigatorObserver extends AutoRouterObserver {
  MainShellNavigatorObserver(this._mainShellRouteStateRepository);

  final MainShellRouteStateRepository _mainShellRouteStateRepository;

  @override
  void didPush(Route route, Route? previousRoute) {
    _logger.info('didPush: ${route.settings.name}');

    final activeRouteName = route.settings.name;
    final activeRouteArgs = route.data?.route.args;
    _mainShellRouteStateRepository.setActiveRouteName(activeRouteName ?? '');
    _mainShellRouteStateRepository.setActiveRouteArgs(activeRouteArgs);

    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _logger.info('didPop: ${route.settings.name}');

    final activeRouteName = previousRoute?.settings.name;
    final activeRouteArgs = previousRoute?.data?.route.args;
    _mainShellRouteStateRepository.setActiveRouteName(activeRouteName ?? '');
    _mainShellRouteStateRepository.setActiveRouteArgs(activeRouteArgs);

    super.didPop(route, previousRoute);
  }
}
