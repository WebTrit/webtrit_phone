import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/call/call.dart';

class CallRouterObserver extends AutoRouterObserver {
  bool _isCallRouterLocation(Route route) {
    return route.settings.name == CallScreenPageRoute.name;
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (_isCallRouterLocation(route)) {
      route.navigator?.context.read<CallBloc>().add(CallScreenEvent.didPush());
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (_isCallRouterLocation(route)) {
      route.navigator?.context.read<CallBloc>().add(CallScreenEvent.didPop());
    }
    super.didPop(route, previousRoute);
  }
}
