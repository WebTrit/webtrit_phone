import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/environment_config.dart';

extension DeepLinkExtension on PlatformDeepLink {
  bool get isExternal {
    var appLinkDomain = EnvironmentConfig.APP_LINK_DOMAIN;
    return uri.host == appLinkDomain;
  }
}
