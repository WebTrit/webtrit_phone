import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/app/session/session.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/push_notification/push_notifications.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';

// Shares the shell's logger name so the log output stays as it was before the
// bloc layer moved into this file.
final _logger = Logger('MainShell');

/// Builds and wires up all feature-level BLoCs of the main shell.
///
/// This layer is responsible for application-wide state orchestration:
/// - Initializes domain-specific blocs (push tokens, recents, contacts sync, calls, messaging, unread counters, etc.)
///   with their required repositories and dependencies.
/// - Dispatches initial events (`Started`/`Init`) right after bloc creation to bootstrap feature flows.
/// - Provides higher-level status cubits (e.g. `SessionStatusCubit`, `RegisterStatusCubit`) that depend on lower-level
///   blocs.
/// - Ensures feature blocs are eagerly created (`lazy: false`) where necessary to guarantee immediate availability
///   (e.g. push tokens, contacts sync, session status).
///
/// Extracted from [MainShell] as a widget of its own so the layer reads as one
/// unit and can be composed (or replaced) on its own in tests. The shell keeps
/// ownership of the session-long collaborators ([callkeep],
/// [callkeepConnections], [signalingModule]) and passes them in.
class MainShellBlocs extends StatelessWidget {
  const MainShellBlocs({
    super.key,
    required this.callkeep,
    required this.callkeepConnections,
    required this.signalingModule,
    required this.child,
  });

  final Callkeep callkeep;
  final CallkeepConnections callkeepConnections;

  /// Created and connected by the shell state before the first build so the
  /// WebSocket handshake runs in parallel while this layer is being built.
  final SignalingModule signalingModule;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Resolves the session snapshot the shell shadows above (see [MainShell]):
    // one configuration for the whole session, so the graph never reshapes.
    final featureAccess = context.read<FeatureAccess>();
    final appTime = context.read<AppTime>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<PushTokensBloc>(
          lazy: false,
          create: (context) {
            return PushTokensBloc(
              pushTokensRepository: context.read<PushTokensRepository>(),
              secureStorage: context.read<SecureStorage>(),
              appPreferences: context.read<AppPreferences>(),
              firebaseMessaging: context.read<FirebaseMessaging>(),
              callkeep: callkeep,
              pushEnvironment: context.read<PushEnvironment>(),
            )..add(const PushTokensEventStarted());
          },
        ),
        BlocProvider<RecentsBloc>(
          create: (context) {
            return RecentsBloc(
              recentsRepository: context.read<RecentsRepository>(),
              activeRecentsVisibilityFilterRepository: context.read<ActiveRecentsVisibilityFilterRepository>(),
              dateFormat: appTime.formatDateTime(),
            )..add(const RecentsStarted());
          },
        ),
        BlocProvider<LocalContactsSyncBloc>(
          lazy: false,
          create: (context) {
            final localContactsRepository = context.read<LocalContactsRepository>();
            final contactsAgreementStatusRepository = context.read<ContactsAgreementStatusRepository>();
            final appPermissions = context.read<AppPermissions>();

            Future<bool> isFutureEnabled() async {
              final contactTab = featureAccess.bottomMenuConfig.getTabEnabled<ContactsBottomMenuTab>();
              final contactSourceTypes = contactTab?.contactSourceTypes ?? [];
              return contactSourceTypes.contains(ContactSourceType.local);
            }

            Future<bool> isAgreementAccepted() async {
              final contactsAgreementStatus = contactsAgreementStatusRepository.getContactsAgreementStatus();
              return contactsAgreementStatus.isAccepted;
            }

            final bloc = LocalContactsSyncBloc(
              localContactsRepository: localContactsRepository,
              contactsAgreementStatusRepository: contactsAgreementStatusRepository,
              contactsRepository: context.read<ContactsRepository>(),
              isFeatureEnabled: isFutureEnabled,
              isAgreementAccepted: isAgreementAccepted,
              isContactsPermissionGranted: () => appPermissions.isContactPermissionGranted(),
              requestContactPermission: () => appPermissions.requestContactPermission(),
            );

            bloc.add(const LocalContactsSyncStarted());
            return bloc;
          },
        ),
        if (featureAccess.coreSupport.supportsExtensions)
          BlocProvider<ExternalContactsSyncBloc>(
            lazy: false,
            create: (context) {
              return ExternalContactsSyncBloc(
                userRepository: context.read<UserRepository>(),
                externalContactsRepository: context.read<ExternalContactsRepository>(),
                contactsRepository: context.read<ContactsRepository>(),
              )..add(const ExternalContactsSyncStarted());
            },
          ),
        BlocProvider<CallBloc>(
          create: (context) {
            final appBloc = context.read<AppBloc>();
            final notificationsBloc = context.read<NotificationsBloc>();
            final audioProcessingSettingsRepository = context.read<AudioProcessingSettingsRepository>();
            final encodingPresetRepository = context.read<EncodingPresetRepository>();
            final iceSettingsRepository = context.read<IceSettingsRepository>();
            final peerConnectionSettingsRepository = context.read<PeerConnectionSettingsRepository>();
            final videoCapturingSettingsRepository = context.read<VideoCapturingSettingsRepository>();
            final encodingSettingsRepository = context.read<EncodingSettingsRepository>();
            final diagnosticService = context.read<DiagnosticService>();

            final encodingConfig = featureAccess.callConfig.encoding;
            final peerConnectionConfig = featureAccess.callConfig.peerConnection;
            final monitorInterval = featureAccess.loggingConfig.monitorCheckInterval;

            // Initialize media builder with app-configured audio/video constraints
            // Used to capture synchronized MediaStream (audio+video) for WebRTC track addition.
            final appPermissions = context.read<AppPermissions>();
            final userMediaBuilder = DefaultUserMediaBuilder(
              audioConstraintsBuilder: AudioConstraintsWithAppSettingsBuilder(audioProcessingSettingsRepository),
              videoConstraintsBuilder: VideoConstraintsWithAppSettingsBuilder(videoCapturingSettingsRepository),
              isCameraPermissionGranted: () => appPermissions.isPermissionGranted(Permission.camera),
            );
            // Initialize peer connection policy applier with app-specific negotiation rules
            final pearConnectionPolicyApplier = ModifyWithSettingsPeerConnectionPolicyApplier(
              peerConnectionSettingsRepository,
              peerConnectionConfig,
              userMediaBuilder,
            );
            // Used to resolve the contact (and its display name) of the caller
            final contactResolver = context.read<ContactResolver>();

            // Try to get CDRs sync worker to trigger immediate sync after call ends
            // If CDRs feature is disabled, the worker will be null and no sync will be performed
            final cdrsSyncWorker = context.readOrNull<CdrsSyncWorker>();

            final peerConnectionManager = PeerConnectionManager(
              retrieveTimeout: kPeerConnectionRetrieveTimeout,
              monitorCheckInterval: monitorInterval,
              monitorDelegatesFactory: (callId, logger) => [LoggingRtpTrafficMonitorDelegate(logger: logger)],
            );

            final localPushRepository = context.read<LocalPushRepository>();
            return CallBloc(
              callLogsRepository: context.read<CallLogsRepository>(),
              onMissedCall: (callId, callerName) => localPushRepository
                  .displayPush(AppLocalPush.missedCall(callId, context.l10n.notifications_missedCall_title, callerName))
                  .catchError((e) => _logger.warning('onMissedCall: $e')),
              linesStateRepository: context.read<LinesStateRepository>(),
              presenceInfoRepository: context.read<PresenceInfoRepository>(),
              dialogInfoRepository: context.read<DialogInfoRepository>(),
              presenceSettingsRepository: context.read<PresenceSettingsRepository>(),
              queuedTerminationRequestsRepository: context.read<QueuedTerminationRequestsRepository>(),
              // Outgoing SIP `from` policy: normalise the user's main number to
              // null (main line), or fall back to caller-ID matcher resolution.
              resolveOutgoingFromNumber: (callerFromNumber, destination) {
                final mainNumber = context.read<UserRepository>().getLocalInfo()?.numbers.main;
                if (callerFromNumber != null && callerFromNumber == mainNumber) return null;
                return callerFromNumber ??
                    context.read<CallerIdSettingsRepository>().getCallerIdSettings().resolveFromNumber(destination);
              },
              onSessionMissedReported: SessionInvalidationHandler(
                SessionVerifier(context.read<UserRepository>()),
                performLogout: (resolution) => appBloc.add(
                  AppLogoutRequested(
                    reason: resolution is SessionPasswordChangeRequired
                        ? AppLogoutReason.passwordChangeRequired
                        : AppLogoutReason.sessionMissed,
                  ),
                ),
              ).onSessionMissedReported,
              submitNotification: (n) => notificationsBloc.add(NotificationsSubmitted(n)),
              isCameraPermissionGranted: () => appPermissions.isPermissionGranted(Permission.camera),
              callkeep: callkeep,
              callkeepConnections: callkeepConnections,
              sdpMunger: ModifyWithEncodingSettings(
                encodingSettingsRepository,
                encodingConfig,
                encodingPresetRepository,
              ),
              sdpSanitizer: RemoteSdpSanitizer(),
              webRtcOptionsBuilder: WebrtcOptionsWithAppSettingsBuilder(audioProcessingSettingsRepository),
              userMediaBuilder: userMediaBuilder,
              contactResolver: contactResolver,
              callErrorReporter: DefaultCallErrorReporter((n) => notificationsBloc.add(NotificationsSubmitted(n))),
              iceFilter: FilterWithAppSettings(iceSettingsRepository),
              peerConnectionPolicyApplier: pearConnectionPolicyApplier,
              // TODO(Serdun): these per-feature capability flags keep growing as
              // individual constructor args; inject a single capabilities/config
              // struct (e.g. CallCapabilitiesConfig) instead of one bool each.
              sendPresenceSettings: featureAccess.presenceConfig.anyPresenceEnabled,
              callPullVideoStrategy: featureAccess.callConfig.capabilities.callPullVideoStrategy,
              peerMessageSupported: featureAccess.callConfig.capabilities.isPeerMessageEnabled,
              onCallEnded: () => cdrsSyncWorker?.forceSync(const Duration(seconds: 1)),
              onDiagnosticReportRequested: (id, error) => diagnosticService.request(
                DiagnosticType.androidCallkeepOnly,
                extras: {'callId': id, 'error': error.name},
              ),
              signalingModule: signalingModule,
              peerConnectionManager: peerConnectionManager,
              connectivityService: context.read<ConnectivityService>(),
              foregroundCallPushSignal: RemotePushBroker.pendingCallForegroundPushs,
            )..add(const CallStarted());
          },
        ),
        BlocProvider<MessagingBloc>(
          lazy: false,
          create: (context) {
            final session = context.read<AppBloc>().state.session;

            return MessagingBloc(
              createMessagingSocket(session.coreUrl!, session.token!, session.tenantId),
              featureAccess.messagingConfig,
              context.read<ChatsRepository>(),
              context.read<ChatsOutboxRepository>(),
              context.read<SmsRepository>(),
              context.read<SmsOutboxRepository>(),
              context.read<SessionRepository>(),
            );
          },
        ),
        BlocProvider<UnreadCountCubit>(
          create: (context) {
            return UnreadCountCubit(
              chatsRepository: context.read<ChatsRepository>(),
              smsRepository: context.read<SmsRepository>(),
              sessionRepository: context.read<SessionRepository>(),
            )..init();
          },
        ),
        BlocProvider(create: (_) => ChatsForwardingCubit()),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(lazy: false, create: (_) => UserInfoCubit(context.read<UserRepository>())),
              BlocProvider(
                lazy: false,
                create: (_) => SessionStatusCubit(
                  pushTokensBloc: context.read<PushTokensBloc>(),
                  callBloc: context.read<CallBloc>(),
                ),
              ),
              BlocProvider(
                lazy: false,
                create: (_) => RegisterStatusCubit(
                  context.read<AppRepository>(),
                  context.read<RegisterStatusRepository>(),
                  handleError: (error, stackTrace) {
                    context.read<AppBloc>().maybeHandleError(error);
                  },
                ),
              ),
              BlocProvider(
                lazy: false,
                create: (context) {
                  return MicrophoneStatusBloc(appPermissions: context.read<AppPermissions>())
                    ..add(MicrophoneStatusStarted());
                },
              ),
              BlocProvider(
                lazy: false,
                create: (_) => SystemNotificationsCounterCubit(context.read<SystemNotificationsLocalRepository>()),
              ),
              BlocProvider(
                lazy: false,
                create: (_) => CallPullCubit(
                  userRepository: context.read<UserRepository>(),
                  dialogInfoRepository: context.read<DialogInfoRepository>(),
                  linesStateRepository: context.read<LinesStateRepository>(),
                  callPullVideoStrategy: featureAccess.callConfig.capabilities.callPullVideoStrategy,
                )..init(),
              ),
              BlocProvider<CallRoutingCubit>(
                lazy: false,
                create: (_) => CallRoutingCubit(
                  context.read<UserRepository>(),
                  context.read<LinesStateRepository>(),
                  context.read<CallerIdSettingsRepository>(),
                  context.read<ConnectivityService>(),
                ),
              ),
            ],
            child: child,
          );
        },
      ),
    );
  }
}
