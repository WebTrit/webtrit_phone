import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';

/// Strategy for the Firebase-dependent integrations that [bootstrap] wires up.
///
/// Standalone builds use the default [FirebaseIntegrationEnabled] (defined in
/// bootstrap.dart, next to the Firebase init functions). An embedder that owns
/// the default Firebase app - the theme configurator's realtime preview - passes
/// [FirebaseIntegrationDisabled] so the app runs Firebase-free. The choice is a
/// single polymorphic decision at the composition root; bootstrap consumes the
/// interface uniformly, with no feature-flag branching.
abstract interface class FirebaseIntegration {
  /// Side-effect platform initialisation (Firebase app, messaging, local pushes).
  Future<void> initPlatform();

  /// Source of the app-instance id.
  AppIdProvider get appIdProvider;

  /// Resolves the remote configuration service. [cache] is the always-available
  /// local cache, used as the fallback (or as the sole source when disabled).
  Future<RemoteConfigService> remoteConfig(DefaultRemoteCacheConfigService cache);

  /// Analytics repository (navigator observer source).
  AppAnalyticsRepository get analytics;
}

/// Firebase-free integration: no platform init, the local id provider, the local
/// cache as the remote config source, and no-op analytics.
class FirebaseIntegrationDisabled implements FirebaseIntegration {
  const FirebaseIntegrationDisabled();

  @override
  Future<void> initPlatform() async {}

  @override
  AppIdProvider get appIdProvider => const SharedPreferencesAppIdProvider();

  @override
  Future<RemoteConfigService> remoteConfig(DefaultRemoteCacheConfigService cache) async => cache;

  @override
  AppAnalyticsRepository get analytics => const NoopAppAnalyticsRepository();
}
