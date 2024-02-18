import 'package:auto_route/auto_route.dart';
import 'package:logging/logging.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

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
    if (deepLink.path.startsWith(initialCallRout)) {
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
