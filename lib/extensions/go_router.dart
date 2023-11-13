import 'package:go_router/go_router.dart';

extension GoRouterExtension on GoRouter {
  bool isRouteExit(String route) {
    try {
      return configuration.findMatch(route).matches.isNotEmpty;
    } catch (err) {
      return false;
    }
  }

  bool isCurrentLocation(String route) {
    return routerDelegate.currentConfiguration.last.matchedLocation == route;
  }
}
