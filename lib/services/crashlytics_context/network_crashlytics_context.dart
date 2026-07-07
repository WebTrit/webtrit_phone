import 'package:webtrit_phone/models/models.dart';

import 'crashlytics_app_context.dart';

/// Crashlytics keys owned by the network settings: the incoming call
/// delivery mechanism, which disambiguates the call-delivery path a crash
/// happened on.
class NetworkCrashlyticsContext extends CrashlyticsAppContext {
  const NetworkCrashlyticsContext({super.crashKeysWriter});

  void logIncomingCallType(IncomingCallType incomingCallType) {
    setKey('incomingCallType', incomingCallType.name);
  }
}
