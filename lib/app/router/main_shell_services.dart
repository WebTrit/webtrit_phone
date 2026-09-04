import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';

/// Bridge layers for background/periodic tasks between repositories and Blocs
/// (connectivity recovery, scheduled polling, auto-refresh on network restore).
///
/// Extracted from [MainShell] as a widget of its own so the layer reads as one
/// unit and can be composed (or replaced) on its own in tests.
class MainShellServices extends StatelessWidget {
  const MainShellServices({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Resolves the session snapshot the shell shadows above (see [MainShell]):
    // one configuration for the whole session, so the graph never reshapes.
    final featureAccess = context.read<FeatureAccess>();
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => ConnectivityLifecycleService(
            connectivity: context.read<ConnectivityService>(),
            registrations: _connectivityRecoveryRegistrations(context),
          ),
          dispose: (context, service) => service.dispose(),
          lazy: false,
        ),
        Provider<PollingService>(
          create: (context) => PollingService(
            connectivityService: context.read<ConnectivityService>(),
            registrations: _pollingRegistrations(context),
          ),
          dispose: (context, service) => service.dispose(),
          lazy: false,
        ),
        if (featureAccess.bottomMenuConfig.getTabEnabled<RecentsBottomMenuTab>()?.supportsCallHistory == true)
          Provider<CdrsSyncWorker>(
            create: (context) =>
                CdrsSyncWorker(context.read<CdrsLocalRepository>(), context.read<CdrsRemoteRepository>())..init(),
            dispose: (context, worker) => worker.dispose(),
            lazy: false,
          ),
      ],
      child: child,
    );
  }

  /// Builds a list of repositories that should be periodically polled by [PollingService].
  ///
  /// Each [PollingRegistration] defines:
  /// - the repository (listener) that needs to be refreshed,
  /// - the polling interval at which it should be triggered.
  ///
  /// Current registrations:
  /// - [UserRepository]: polled every 10 seconds to keep user data up to date.
  /// - [SystemInfoRepository]: polled every 5 minutes to refresh system information.
  /// - [VoicemailRepository]: polled every 5 minutes, but only if voicemail runs for this session
  ///   ([FeatureAccess.voicemailAvailable]) - whichever placement offers it.
  /// - [IceServersRepository]: polled every 5 minutes when the core bundles STUN/TURN servers.
  ///   The tick is a noop until the cached configuration approaches its expiration, so its only
  ///   job is to renew short-lived TURN credentials inside a long-running session.
  ///
  /// This method centralizes the polling configuration, so changes in polling logic or intervals
  /// can be made here without touching the [Provider] or [PollingService] setup.
  List<PollingRegistration> _pollingRegistrations(BuildContext context) {
    final featureAccess = context.read<FeatureAccess>();
    final isVoicemailsEnabled = featureAccess.voicemailAvailable;
    final supportsExtensions = featureAccess.coreSupport.supportsExtensions;
    final cliSettingsRepository = context.read<CallerIdSettingsRepository>();
    final favoritesRepository = context.read<FavoritesRepository>();
    final sipSubscriptionsRepository = context.read<SipSubscriptionsRepository>();
    final iceServersRepository = context.read<IceServersRepository>();

    return [
      PollingRegistration(
        listener: context.read<UserRepository>(),
        interval: Duration(seconds: EnvironmentConfig.USER_REPOSITORY_POLLING_INTERVAL_SECONDS),
      ),
      PollingRegistration(
        listener: context.read<SystemInfoRepository>(),
        interval: Duration(seconds: EnvironmentConfig.SYSTEM_INFO_REPOSITORY_POLLING_INTERVAL_SECONDS),
      ),
      if (supportsExtensions)
        PollingRegistration(
          listener: context.read<ExternalContactsRepository>(),
          interval: Duration(seconds: EnvironmentConfig.EXTERNAL_CONTACTS_REPOSITORY_POLLING_INTERVAL_SECONDS),
        ),
      if (isVoicemailsEnabled)
        PollingRegistration(
          listener: context.read<VoicemailRepository>(),
          interval: Duration(seconds: EnvironmentConfig.VOICEMAIL_REPOSITORY_POLLING_INTERVAL_SECONDS),
        ),
      if (cliSettingsRepository is CallerIdSettingsRepositoryRemoteImpl)
        PollingRegistration(
          listener: cliSettingsRepository,
          interval: Duration(seconds: EnvironmentConfig.CALLER_ID_SETTINGS_REPOSITORY_POLLING_INTERVAL_SECONDS),
        ),
      if (favoritesRepository is FavoritesRepositorySyncableImpl)
        PollingRegistration(
          listener: favoritesRepository,
          interval: Duration(seconds: EnvironmentConfig.FAVORITES_REPOSITORY_POLLING_INTERVAL_SECONDS),
        ),
      if (sipSubscriptionsRepository is SipSubscriptionsRepositorySyncableImpl)
        PollingRegistration(
          listener: sipSubscriptionsRepository,
          interval: Duration(seconds: EnvironmentConfig.SIP_SUBSCRIPTIONS_REPOSITORY_POLLING_INTERVAL_SECONDS),
        ),
      if (iceServersRepository is IceServersRepositoryImpl)
        PollingRegistration(
          listener: iceServersRepository,
          interval: Duration(seconds: EnvironmentConfig.ICE_SERVERS_REPOSITORY_POLLING_INTERVAL_SECONDS),
        ),
    ];
  }

  /// Builds a list of listeners that should be registered in [ConnectivityLifecycleService].
  ///
  /// Each [ConnectivityRecoveryRegistration] defines:
  /// - a [Refreshable] listener to be refreshed automatically when connectivity is restored,
  /// - a [Suspendable] listener to be suspended automatically when connectivity is lost.
  ///
  /// Current registrations:
  /// - [VoicemailRepository]: refreshed when going online, but only if voicemail runs for this
  ///   session ([FeatureAccess.voicemailAvailable]) - whichever placement offers it.
  ///
  /// This method centralizes the connectivity recovery configuration, so changes in
  /// registration logic can be made here without touching the [Provider] or service setup.
  List<ConnectivityRecoveryRegistration> _connectivityRecoveryRegistrations(BuildContext context) {
    final isVoicemailsEnabled = context.read<FeatureAccess>().voicemailAvailable;

    return [if (isVoicemailsEnabled) ConnectivityRecoveryRegistration.refreshable(context.read<VoicemailRepository>())];
  }
}
