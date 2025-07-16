import 'package:auto_route/auto_route.dart';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/undefined/undefined.dart';

import '../constants.dart';

final _logger = Logger('DeepLinkHandler');

abstract class DeepLinkHandler {
  DeepLink? handle();
}

class HandleReturnToMain implements DeepLinkHandler {
  HandleReturnToMain(this.deepLink);

  final PlatformDeepLink deepLink;

  @override
  DeepLink? handle() => !deepLink.isExternal && _isMain && !_isInitial ? DeepLink.none : null;

  bool get _isMain => deepLink.path == '/';

  bool get _isInitial => deepLink.initial;
}

/// Handles deep links to `/call`.
///
/// Currently, this simply redirects to the main screen. In the future, it can be extended to
/// preload call parameters and prepare an active call state, even if the signaling has not yet been initialized.
///
/// This is particularly useful for cases where calls are triggered through alternative channels
/// such as SMS, especially in regions with zero-rated mobile data plans. In such scenarios,
/// internet access is allowed only for whitelisted IPs (e.g., the app backend),
/// while push notifications (e.g., via Firebase/Google APIs) may not be deliverable.
class HandleCall implements DeepLinkHandler {
  HandleCall(this.deepLink, this.router);

  final PlatformDeepLink deepLink;
  final AppRouter? router;

  @override
  DeepLink? handle() {
    if (!_isCallPath) return null;

    _logger.fine('Call parameters: ${deepLink.uri.queryParameters}');
    return _isMainShellActive ? const DeepLink([MainShellRoute()]) : const DeepLink.path('/');
  }

  bool get _isCallPath => deepLink.path == '/call';

  bool get _isMainShellActive => router?.isRouteActive(MainShellRoute.name) == true;
}

class HandleAutoprovision implements DeepLinkHandler {
  HandleAutoprovision(this.deepLink);

  final PlatformDeepLink deepLink;

  @override
  DeepLink? handle() {
    _logger.fine('HandleAutoprovision: ${deepLink.path}');

    return _isAutoprovision ? deepLink : null;
  }

  bool get _isAutoprovision => deepLink.path.startsWith(kAutoprovisionRout);
}

class HandleNotDefinedPath implements DeepLinkHandler {
  HandleNotDefinedPath(this.deepLink, this.router);

  final PlatformDeepLink deepLink;
  final AppRouter? router;

  @override
  DeepLink? handle() {
    _logger.fine('HandleNotDefinedPath: ${deepLink.path}');

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
