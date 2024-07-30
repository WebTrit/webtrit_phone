import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('MainScreenNavigatorObserver');

class MainScreenNavigatorObserver extends AutoRouterObserver {
  MainScreenNavigatorObserver(this._mainScreenRouteStateRepository);

  final MainScreenRouteStateRepository _mainScreenRouteStateRepository;

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    _logger.info('didInitTabRoute: ${route.routeInfo.name}');
    _mainScreenRouteStateRepository.setActiveTabPage(route.routeInfo.name);
    super.didInitTabRoute(route, previousRoute);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    _logger.info('didchangeTabRoute: ${route.routeInfo.name}');
    _mainScreenRouteStateRepository.setActiveTabPage(route.routeInfo.name);
    super.didChangeTabRoute(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    final args = route.data?.route.args;
    _logger.info('didPush: ${route.settings.name}');
    _mainScreenRouteStateRepository.setLastRouteArgs(args);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    final args = previousRoute?.data?.route.args;
    _logger.info('didPop: ${route.settings.name}');
    _mainScreenRouteStateRepository.setLastRouteArgs(args);
    super.didPop(route, previousRoute);
  }
}
