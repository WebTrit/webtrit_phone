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
    _logger.finest('didInitTabRoute: ${route.routeInfo.name}');
    _mainScreenRouteStateRepository.setActiveTabPage(route.routeInfo.name);
    super.didInitTabRoute(route, previousRoute);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    _logger.finest('didChangeTabRoute: ${route.routeInfo.name}');
    _mainScreenRouteStateRepository.setActiveTabPage(route.routeInfo.name);
    super.didChangeTabRoute(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _logger.finest('didPush: ${route.settings.name}');
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _logger.finest('didPop: ${route.settings.name}');
    super.didPop(route, previousRoute);
  }
}
