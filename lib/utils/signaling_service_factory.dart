import 'package:webtrit_signaling_service/webtrit_signaling_service.dart'
    show SignalingModule, SignalingServiceConfig, SignalingServiceMode, WebtritSignalingService;

import 'package:webtrit_phone/app/constants.dart';

/// Builds the [SignalingModule] the main shell connects with.
///
/// Provided from the composition root so a host (or a test) can substitute
/// its own module instead of the platform-backed [WebtritSignalingService].
///
/// Not to be confused with the signaling package's `SignalingModuleFactory`
/// typedef: that one is the low-level hook the background isolate registers
/// via `WebtritSignalingService.setModuleFactory` during bootstrap, one layer
/// below this class. Substituting this factory reroutes only the foreground
/// shell connection.
class SignalingServiceFactory {
  const SignalingServiceFactory();

  SignalingModule create({required SignalingServiceConfig config, required SignalingServiceMode mode}) {
    return WebtritSignalingService(config: config, mode: mode, startPendingTimeout: kSignalingStartPendingTimeout);
  }
}
