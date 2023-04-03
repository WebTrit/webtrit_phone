import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/routes.dart';

class OverlayNavigatorObserver extends RouteObserver {
  OverlayNavigatorObserver();

  Function()? _popCallback;
  Function()? _pushCallback;

  void setPopListener(Function() callback) {
    _popCallback = callback;
  }

  void setPushListener(Function() callback) {
    _pushCallback = callback;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name == MainRoute.call) {
      _popCallback?.call();
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name == MainRoute.call) {
      _pushCallback?.call();
    }
  }

  void dispose() {
    _popCallback = null;
    _pushCallback = null;
  }
}
