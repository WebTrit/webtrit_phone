import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:logging/logging.dart';

final _logger = Logger('AppRouterObserver');

class AppRouterObserver extends AutoRouterObserver {
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    super.didInitTabRoute(route, previousRoute);
    _logger.fine(() => 'didInitTabRoute: $route / $previousRoute');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    super.didChangeTabRoute(route, previousRoute);
    _logger.fine(() => 'didChangeTabRoute: $route / $previousRoute');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _logger.fine(() => 'didPush: $route / $previousRoute');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _logger.fine(() => 'didPop: $route / $previousRoute');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _logger.fine(() => 'didRemove: $route / $previousRoute');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _logger.fine(() => 'didReplace newRoute: $newRoute oldRoute: $oldRoute');
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    _logger.fine(() => 'didStartUserGesture: $route / $previousRoute');
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    _logger.fine('didStopUserGesture');
  }
}
