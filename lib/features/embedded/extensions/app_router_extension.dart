import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

extension RequestFailureExension on RouteMatch {
  RouteMatch? existRouteWIthRequiredParams(PageInfo pageInfo) {
    return children?.firstWhereOrNull(
      (child) => (child.name == pageInfo.name && child.args == null),
    );
  }
}
