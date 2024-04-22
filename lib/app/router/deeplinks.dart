import 'package:auto_route/auto_route.dart';

import 'package:logging/logging.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/undefined/undefined.dart';

import '../constants.dart';

final _logger = Logger('DeepLinkHandler');

abstract class DeepLinkHandler {
  DeepLink? handle();
}

class HandleAndroidBackgroundIncomingCall implements DeepLinkHandler {
  HandleAndroidBackgroundIncomingCall(this.deepLink, this.pendingCalls);

  final PlatformDeepLink deepLink;
  final AndroidPendingCallHandler pendingCalls;

  @override
  DeepLink? handle() {
    if (deepLink.path.startsWith(initialCallRout) && !deepLink.isExternal) {
      final uri = Uri.parse(deepLink.configuration.url);
      final pendingCall = PendingCall.fromMap(uri.queryParameters);

      _logger.fine('Pending call deeplink: $pendingCall');
      pendingCalls.add(pendingCall);

      return deepLink.initial ? DeepLink.defaultPath : DeepLink.none;
    } else {
      return null;
    }
  }
}

class HandleReturnToMain implements DeepLinkHandler {
  HandleReturnToMain(this.deepLink);

  final PlatformDeepLink deepLink;

  @override
  DeepLink? handle() => !deepLink.isExternal && _isMain && !_isInitial ? DeepLink.none : null;

  bool get _isMain => deepLink.path == '/';

  bool get _isInitial => deepLink.initial;
}

class HandleAutoprovision implements DeepLinkHandler {
  HandleAutoprovision(this.deepLink);

  final PlatformDeepLink deepLink;

  @override
  DeepLink? handle() => _isAutoprovision ? deepLink : null;

  bool get _isAutoprovision => deepLink.path.startsWith(kAutoprovisionRout);
}

class HandleNotDefinedPath implements DeepLinkHandler {
  HandleNotDefinedPath(this.deepLink, this.router);

  final PlatformDeepLink deepLink;
  final AppRouter? router;

  @override
  DeepLink? handle() {
    if (!_isDeeplinkExternal) return null;
    if (!_isInitial && _isInvalidScreenActive) return DeepLink.none;

    return DeepLink([
      if (_isInitial) const MainShellRoute(),
      if (!_isInvalidScreenActive) UndefinedScreenPageRoute(undefinedType: UndefinedType.deeplinkConfigurationInvalid),
    ]);
  }

  bool get _isInvalidScreenActive => router?.isRouteActive(UndefinedScreenPageRoute.name) == true;

  bool get _isInitial => deepLink.initial;

  bool get _isDeeplinkExternal => deepLink.isExternal;
}
