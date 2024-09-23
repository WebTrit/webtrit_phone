import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

extension RouteMatchExension on RouteMatch {
  PageRouteInfo<dynamic>? getPageRouteInfo<T>(Map<PageInfo, T Function(dynamic)> routes, dynamic data) {
    for (final entry in routes.entries) {
      final embedded = findRouteWithRequiredParams(entry.key);
      if (embedded != null && data != null) {
        return entry.value(data) as PageRouteInfo<dynamic>;
      }
    }
    return null;
  }
}
