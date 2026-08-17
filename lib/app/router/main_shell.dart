import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart' show SignalingModule, SignalingServiceConfig;

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/app/router/main_shell_blocs.dart';
import 'package:webtrit_phone/app/router/main_shell_repositories.dart';
import 'package:webtrit_phone/app/router/main_shell_services.dart';
import 'package:webtrit_phone/app/session/session.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';
import 'package:webtrit_phone/utils/utils.dart';

final _logger = Logger('MainShell');

@RoutePage()
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  /// From the composition root (see bootstrap), like every other dependency;
  /// fields so each keeps one identity for the shell's lifetime ([dispose]
  /// still needs the callkeep instance after the context is gone).
  late final Callkeep _callkeep = context.read<Callkeep>();
  late final CallkeepConnections _callkeepConnections = context.read<CallkeepConnections>();

  /// The [SessionGuard] instance that handles session expiration and logout.
  late final SessionGuard _sessionGuard;

  /// Stored in [initState] so it remains accessible during [dispose] without
  /// reading from a potentially deactivated [BuildContext].
  late final AppBloc _appBloc;

  /// Captured in [initState] so the session-guard callbacks can submit
  /// notifications without touching a possibly-deactivated [BuildContext].
  late final NotificationsBloc _notificationsBloc;

  /// Created and connected in [initState] so that the WebSocket handshake
  /// runs in parallel while the widget tree and [CallBloc] are being built.
  /// Late subscribers (including [CallBloc]) receive all buffered session
  /// events via the replay stream.
  late final SignalingModule _signalingModule;

  /// Drives the native Play Core update prompt; checked once on startup. No-op outside Android.
  /// Constructed here on purpose - per session, so a fresh login checks (and
  /// may re-prompt) anew; tests substitute behavior via its constructor handles.
  final AppUpdateService _appUpdateService = AppUpdateService();

  /// Lazily initialised on first [build] once [CallBloc], [CallRoutingCubit],
  /// and [NotificationsBloc] are available in the widget tree. The `??=`
  /// assignment guarantees a single instance for the lifetime of this [State],
  /// preventing consumers from holding stale references across rebuilds.
  CallController? _callController;

  /// The feature configuration for this authenticated session, snapshotted at
  /// mount and shadowing the reactive provider for everything below the shell.
  ///
  /// Runtime configuration updates must not reach the session subtree: they
  /// used to reshape the provider graph under the live navigator, closing the
  /// session blocs that open screens still held - calls then died silently
  /// until an app restart. With the whole subtree reading one snapshot, the
  /// graph, the tabs and the screens always agree; configuration changes take
  /// effect on the next login. Widgets outside the shell (login and friends)
  /// keep following runtime updates as before.
  late final FeatureAccess _sessionFeatureAccess = context.read<FeatureAccess>();

  @override
  void initState() {
    super.initState();
    _callkeep.setUp(
      CallkeepOptions(
        ios: CallkeepIOSOptions(
          localizedName: context.read<PackageInfo>().appName,
          ringtoneSound: Assets.ringtones.incomingCall1,
          ringbackSound: Assets.ringtones.outgoingCall1,
          iconTemplateImageAssetName: Assets.callkeep.iosIconTemplateImage.path,
          maximumCallGroups: 13,
          maximumCallsPerCallGroup: 13,
          supportedHandleTypes: const {CallkeepHandleType.number},
        ),
        android: CallkeepAndroidOptions(
          ringtoneSound: Assets.ringtones.incomingCall1,
          ringbackSound: Assets.ringtones.outgoingCall1,
          nativeLogFilePath: context.read<AppPath>().nativeLogFilePath,
        ),
      ),
    );

    // After authentication, regenerate the labels to include core URL and tenant ID in remote logging labels
    context.read<AppLogger>().updateRemoteLabels();

    _appBloc = context.read<AppBloc>();
    final session = _appBloc.state.session;
    _signalingModule = context.read<SignalingServiceFactory>().create(
      config: SignalingServiceConfig(
        coreUrl: session.coreUrl!,
        tenantId: session.tenantId,
        token: session.token!,
        trustedCertificates: context.read<AppCertificates>().trustedCertificates,
      ),
      mode: context.read<IncomingCallTypeRepository>().getIncomingCallType().toSignalingServiceMode(),
    )..connect();

    _notificationsBloc = context.read<NotificationsBloc>();

    _sessionGuard = RouterLogoutSessionGuard(
      performLogout: _onSessionGuardLogout,
      onPreLogout: _onSessionGuardPreLogout,
    );

    unawaited(_appUpdateService.check());
  }

  /// Maps an unauthorized [Exception] to a logout reason and triggers logout.
  void _onSessionGuardLogout(Exception e) {
    final reason = e is UserNotFoundException ? AppLogoutReason.userNotFound : AppLogoutReason.serverRejection;
    _appBloc.add(AppLogoutRequested(reason: reason));
  }

  /// Surfaces a reason-specific notification before the guard logs the user out.
  void _onSessionGuardPreLogout(Exception e) {
    final notification = e is UserNotFoundException
        ? const AccountNotFoundNotification()
        : const SessionExpiredNotification();
    _notificationsBloc.add(NotificationsSubmitted(notification));
  }

  @override
  void dispose() {
    _disposeSessionGuard();
    _callkeep.tearDown();
    unawaited(_tearDownSignaling());
    _callController?.dispose();
    super.dispose();
  }

  Future<void> _tearDownSignaling() async {
    try {
      await _signalingModule.dispose();
    } catch (e, st) {
      _logger.warning('_tearDownSignaling: signalingModule.dispose() failed', e, st);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider<FeatureAccess>.value(
      value: _sessionFeatureAccess,
      child: MainShellRepositories(
        sessionGuard: _sessionGuard,
        child: MainShellServices(
          child: MainShellBlocs(
            callkeep: _callkeep,
            callkeepConnections: _callkeepConnections,
            signalingModule: _signalingModule,

            /// The shell chrome: call, messaging and notification overlays around
            /// the nested [AutoRouter], with a [MainShellNavigatorObserver] attached.
            child: Builder(
              builder: (context) {
                final sipPresenceFeature = _sessionFeatureAccess.sipPresenceConfig;
                return CallControllerScope(
                  controller: _callController ??= CallController(callBloc: context.read<CallBloc>()),
                  child: PresenceViewParams(
                    hybridPresenceSupport: sipPresenceFeature.hybridPresenceSupport,
                    blfViaSipSupport: sipPresenceFeature.dialogsViaSipBlfSupport,
                    presenceViaSipSupport: sipPresenceFeature.presenceViaSipSupport,
                    child: CallConfigSynchronizer(
                      child: CallShell(
                        child: MessagingShell(
                          child: SystemNotificationsShell(
                            child: AutoRouter(
                              navigatorObservers: () => [
                                MainShellNavigatorObserver(context.read<MainShellRouteStateRepository>()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Disposes [sessionGuard] if it implements [Disposable].
  /// This ensures any held resources are released before
  /// the widget tree is torn down.
  void _disposeSessionGuard() {
    disposeIfDisposable(_sessionGuard);
  }
}
