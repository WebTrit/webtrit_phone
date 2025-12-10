import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/app/session/session.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.mapper.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';
import 'package:webtrit_phone/utils/utils.dart';

@RoutePage()
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> with WidgetsBindingObserver {
  late final Callkeep _callkeep = Callkeep();
  late final CallkeepConnections _callkeepConnections = CallkeepConnections();

  /// The [SessionGuard] instance that handles session expiration and logout.
  late final SessionGuard _sessionGuard;

  /// The [PollingService] instance that handles periodic polling of repositories.
  late PollingService? _polling;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
        ),
      ),
    );

    // After authentication, regenerate the labels to include core URL and tenant ID in remote logging labels
    context.read<AppLogger>().regenerateRemoteLabels();

    _sessionGuard = RouterLogoutSessionGuard(
      performLogout: () {
        context.read<SessionRepository>().logout();
      },
      onPreLogout: () {
        final notification = ErrorMessageNotification(context.l10n.notifications_errorSnackBar_sessionExpired);
        final notificationsBloc = context.read<NotificationsBloc>();
        notificationsBloc.add(NotificationsSubmitted(notification));
      },
    );
  }

  @override
  void dispose() {
    _disposeSessionGuard();
    _callkeep.tearDown();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _polling?.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    final featureAccess = context.watch<FeatureAccess>();
    final appTime = context.read<AppTime>();
    final appCertificates = context.read<AppCertificates>();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WebtritApiClient>(
          create: (context) {
            final appBloc = context.read<AppBloc>();

            return WebtritApiClient(
              Uri.parse(appBloc.state.session.coreUrl!),
              appBloc.state.session.tenantId,
              connectionTimeout: kApiClientConnectionTimeout,
              certs: appCertificates.trustedCertificates,
            );
          },
        ),
        RepositoryProvider<FavoritesRepository>(
          create: (context) => FavoritesRepository(appDatabase: context.read<AppDatabase>()),
        ),
        RepositoryProvider<RecentsRepository>(
          create: (context) => RecentsRepository(appDatabase: context.read<AppDatabase>()),
        ),
        RepositoryProvider<CallLogsRepository>(
          create: (context) => CallLogsRepository(appDatabase: context.read<AppDatabase>()),
        ),
        RepositoryProvider<ContactsRepository>(
          create: (context) => ContactsRepository(appDatabase: context.read<AppDatabase>()),
        ),
        RepositoryProvider<LocalContactsRepository>(create: (context) => LocalContactsRepository()),
        RepositoryProvider<PushTokensRepository>(
          create: (context) => PushTokensRepository(
            webtritApiClient: context.read<WebtritApiClient>(),
            token: context.read<AppBloc>().state.session.token!,
          ),
        ),
        RepositoryProvider<ExternalContactsRepository>(
          create: (context) => ExternalContactsRepository(
            webtritApiClient: context.read<WebtritApiClient>(),
            token: context.read<AppBloc>().state.session.token!,
          ),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(
            context.read<WebtritApiClient>(),
            context.read<AppBloc>().state.session.token!,
            sessionGuard: _sessionGuard,
          ),
        ),
        RepositoryProvider<SystemInfoRemoteRepository>(
          create: (context) => SystemInfoRemoteRepository(context.read<WebtritApiClient>()),
        ),
        RepositoryProvider<PrivateGatewayRepository>(
          create: (context) => CustomPrivateGatewayRepository(
            context.read<WebtritApiClient>(),
            context.read<SecureStorage>(),
            context.read<AppBloc>().state.session.token!,
            _sessionGuard,
          ),
          dispose: disposeIfDisposable,
        ),
        RepositoryProvider<VoicemailRepository>(
          create: (context) {
            final isVoicemailsEnabled = featureAccess.settingsFeature.isVoicemailsEnabled;

            if (isVoicemailsEnabled) {
              return VoicemailRepositoryImpl(
                webtritApiClient: context.read<WebtritApiClient>(),
                token: context.read<AppBloc>().state.session.token!,
                appDatabase: context.read<AppDatabase>(),
              );
            } else {
              return const EmptyVoicemailRepository();
            }
          },
        ),
        RepositoryProvider<AppRepository>(
          create: (context) => AppRepository(
            webtritApiClient: context.read<WebtritApiClient>(),
            token: context.read<AppBloc>().state.session.token!,
          ),
        ),
        RepositoryProvider<ChatsRepository>(
          create: (context) => ChatsRepository(appDatabase: context.read<AppDatabase>()),
        ),
        RepositoryProvider<ChatsOutboxRepository>(
          create: (context) => ChatsOutboxRepository(appDatabase: context.read<AppDatabase>()),
        ),
        RepositoryProvider<SmsRepository>(create: (context) => SmsRepository(appDatabase: context.read<AppDatabase>())),
        RepositoryProvider<SmsOutboxRepository>(
          create: (context) => SmsOutboxRepository(appDatabase: context.read<AppDatabase>()),
        ),
        RepositoryProvider<MainScreenRouteStateRepository>(
          create: (context) => MainScreenRouteStateRepositoryDefaultImpl(),
        ),
        RepositoryProvider<MainShellRouteStateRepository>(
          create: (context) => MainShellRouteStateRepositoryAutoRouteImpl(),
        ),
        RepositoryProvider<RemotePushRepository>(create: (context) => RemotePushRepositoryBrokerImpl()),
        RepositoryProvider<LocalPushRepository>(create: (context) => LocalPushRepositoryFLNImpl()),
        RepositoryProvider<ActiveMessagePushsRepository>(
          create: (context) => ActiveMessagePushsRepositoryDriftImpl(appDatabase: context.read<AppDatabase>()),
        ),
        RepositoryProvider<CallToActionsRepository>(
          create: (context) => CallToActionsRepositoryImpl(
            webtritApiClient: context.read<WebtritApiClient>(),
            token: context.read<AppBloc>().state.session.token!,
          ),
        ),
        RepositoryProvider<SystemNotificationsLocalRepository>(
          create: (context) => SystemNotificationsLocalRepositoryDriftImpl(context.read<AppDatabase>()),
        ),
        RepositoryProvider<SystemNotificationsRemoteRepository>(
          create: (context) => SystemNotificationsRemoteRepositoryApiImpl(
            context.read<WebtritApiClient>(),
            context.read<AppBloc>().state.session.token!,
            _sessionGuard,
          ),
        ),
        RepositoryProvider<CallPullRepository>(create: (context) => CallPullRepositoryMemoryImpl()),
        RepositoryProvider<LinesStateRepository>(create: (context) => LinesStateRepositoryInMemoryImpl()),
        RepositoryProvider<PresenceInfoRepository>(
          create: (context) => PresenceInfoRepositoryDriftImpl(context.read<AppDatabase>()),
        ),
        RepositoryProvider<CdrsLocalRepository>(
          create: (context) => CdrsLocalRepositoryDriftImpl(context.read<AppDatabase>()),
        ),
        RepositoryProvider<CdrsRemoteRepository>(
          create: (context) => CdrsRemoteRepositoryApiImpl(
            context.read<WebtritApiClient>(),
            context.read<AppBloc>().state.session.token!,
            _sessionGuard,
          ),
        ),
      ],

      /// Bridge layers for background/periodic tasks between repositories and Blocs
      /// (connectivity recovery, scheduled polling, auto-refresh on network restore).
      child: Builder(
        builder: (context) => MultiProvider(
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
              create: (context) => _polling = PollingService(
                connectivityService: context.read<ConnectivityService>(),
                registrations: _pollingRegistrations(context),
              ),
              dispose: (context, service) => service.dispose(),
              lazy: false,
            ),
            if (featureAccess.bottomMenuFeature.getTabEnabled<RecentsBottomMenuTab>()?.useCdrs == true)
              Provider<CdrsSyncWorker>(
                create: (context) =>
                    CdrsSyncWorker(context.read<CdrsLocalRepository>(), context.read<CdrsRemoteRepository>())..init(),
                dispose: (context, worker) => worker.dispose(),
                lazy: false,
              ),
          ],

          /// Builds and wires up all feature-level BLoCs together with the main shell widgets.
          ///
          /// This section is responsible for application-wide state orchestration:
          /// - Initializes domain-specific blocs (push tokens, recents, contacts sync, calls, messaging, unread counters, etc.)
          ///   with their required repositories and dependencies.
          /// - Dispatches initial events (`Started`/`Init`) right after bloc creation to bootstrap feature flows.
          /// - Provides higher-level status cubits (e.g. `SessionStatusCubit`, `RegisterStatusCubit`) that depend on lower-level blocs.
          /// - Ensures feature blocs are eagerly created (`lazy: false`) where necessary to guarantee immediate availability
          ///   (e.g. push tokens, contacts sync, session status).
          ///
          /// The returned widget tree is wrapped into multiple shell layers:
          /// - [CallShell] for handling call-related UI and logic.
          /// - [MessagingShell] for in-app messaging flows.
          /// - [SystemNotificationsShell] for displaying system notifications.
          /// - [AutoRouter] for navigation, with a [MainShellNavigatorObserver] attached.
          ///
          /// Centralizing bloc creation and shell composition here makes the
          /// feature setup explicit, maintainable, and ensures all cross-cutting
          /// concerns (calls, messaging, notifications, routing) are consistently
          /// available throughout the app.
          child: Builder(
            builder: (context) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider<PushTokensBloc>(
                    lazy: false,
                    create: (context) {
                      return PushTokensBloc(
                        pushTokensRepository: context.read<PushTokensRepository>(),
                        secureStorage: context.read<SecureStorage>(),
                        firebaseMessaging: FirebaseMessaging.instance,
                        callkeep: _callkeep,
                      )..add(const PushTokensEventStarted());
                    },
                  ),
                  BlocProvider<RecentsBloc>(
                    create: (context) {
                      return RecentsBloc(
                        recentsRepository: context.read<RecentsRepository>(),
                        activeRecentsVisibilityFilterRepository: context
                            .read<ActiveRecentsVisibilityFilterRepository>(),
                        dateFormat: appTime.formatDateTime(),
                      )..add(const RecentsStarted());
                    },
                  ),
                  BlocProvider<LocalContactsSyncBloc>(
                    lazy: false,
                    create: (context) {
                      final localContactsRepository = context.read<LocalContactsRepository>();
                      final appDatabase = context.read<AppDatabase>();
                      final contactsAgreementStatusRepository = context.read<ContactsAgreementStatusRepository>();
                      final appPermissions = context.read<AppPermissions>();

                      Future<bool> isFutureEnabled() async {
                        final contactTab = featureAccess.bottomMenuFeature.getTabEnabled<ContactsBottomMenuTab>();
                        final contactSourceTypes = contactTab?.contactSourceTypes ?? [];
                        return contactSourceTypes.contains(ContactSourceType.local);
                      }

                      Future<bool> isAgreementAccepted() async {
                        final contactsAgreementStatus = contactsAgreementStatusRepository.getContactsAgreementStatus();
                        return contactsAgreementStatus.isAccepted;
                      }

                      final bloc = LocalContactsSyncBloc(
                        localContactsRepository: localContactsRepository,
                        appDatabase: appDatabase,
                        contactsAgreementStatusRepository: contactsAgreementStatusRepository,
                        isFeatureEnabled: isFutureEnabled,
                        isAgreementAccepted: isAgreementAccepted,
                        isContactsPermissionGranted: () => appPermissions.isContactPermissionGranted(),
                        requestContactPermission: () => appPermissions.requestContactPermission(),
                      );

                      bloc.add(const LocalContactsSyncStarted());
                      return bloc;
                    },
                  ),
                  BlocProvider<ExternalContactsSyncBloc>(
                    lazy: false,
                    create: (context) {
                      return ExternalContactsSyncBloc(
                        userRepository: context.read<UserRepository>(),
                        externalContactsRepository: context.read<ExternalContactsRepository>(),
                        appDatabase: context.read<AppDatabase>(),
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

                      final encodingConfig = featureAccess.callFeature.encoding;
                      final peerConnectionConfig = featureAccess.callFeature.peerConnection;

                      // Initialize media builder with app-configured audio/video constraints
                      // Used to capture synchronized MediaStream (audio+video) for WebRTC track addition.
                      final userMediaBuilder = DefaultUserMediaBuilder(
                        audioConstraintsBuilder: AudioConstraintsWithAppSettingsBuilder(
                          audioProcessingSettingsRepository,
                        ),
                        videoConstraintsBuilder: VideoConstraintsWithAppSettingsBuilder(
                          videoCapturingSettingsRepository,
                        ),
                      );
                      // Initialize peer connection policy applier with app-specific negotiation rules
                      final pearConnectionPolicyApplier = ModifyWithSettingsPeerConnectionPolicyApplier(
                        peerConnectionSettingsRepository,
                        peerConnectionConfig,
                        userMediaBuilder,
                      );
                      // Initialize contact name resolver with app-specific contact repository
                      // Used to display contact name of caller
                      final contactNameResolver = DefaultContactNameResolver(
                        contactRepository: context.read<ContactsRepository>(),
                      );

                      // Try to get CDRs sync worker to trigger immediate sync after call ends
                      // If CDRs feature is disabled, the worker will be null and no sync will be performed
                      final cdrsSyncWorker = context.readOrNull<CdrsSyncWorker>();

                      return CallBloc(
                        coreUrl: appBloc.state.session.coreUrl!,
                        tenantId: appBloc.state.session.tenantId,
                        token: appBloc.state.session.token!,
                        trustedCertificates: appCertificates.trustedCertificates,
                        callLogsRepository: context.read<CallLogsRepository>(),
                        callPullRepository: context.read<CallPullRepository>(),
                        linesStateRepository: context.read<LinesStateRepository>(),
                        presenceInfoRepository: context.read<PresenceInfoRepository>(),
                        presenceSettingsRepository: context.read<PresenceSettingsRepository>(),
                        sessionRepository: context.read<SessionRepository>(),
                        userRepository: context.read<UserRepository>(),
                        submitNotification: (n) => notificationsBloc.add(NotificationsSubmitted(n)),
                        callkeep: _callkeep,
                        callkeepConnections: _callkeepConnections,
                        sdpMunger: ModifyWithEncodingSettings(
                          encodingSettingsRepository,
                          encodingConfig,
                          encodingPresetRepository,
                        ),
                        sdpSanitizer: RemoteSdpSanitizer(),
                        webRtcOptionsBuilder: WebrtcOptionsWithAppSettingsBuilder(audioProcessingSettingsRepository),
                        userMediaBuilder: userMediaBuilder,
                        contactNameResolver: contactNameResolver,
                        callErrorReporter: DefaultCallErrorReporter(
                          (n) => notificationsBloc.add(NotificationsSubmitted(n)),
                        ),
                        iceFilter: FilterWithAppSettings(iceSettingsRepository),
                        peerConnectionPolicyApplier: pearConnectionPolicyApplier,
                        sipPresenceEnabled: featureAccess.sipPresenceFeature.sipPresenceSupport,
                        onCallEnded: () => cdrsSyncWorker?.forceSync(const Duration(seconds: 1)),
                      )..add(const CallStarted());
                    },
                  ),
                  BlocProvider<MessagingBloc>(
                    lazy: false,
                    create: (context) {
                      final session = context.read<AppBloc>().state.session;

                      return MessagingBloc(
                        session.userId,
                        createMessagingSocket(session.coreUrl!, session.token!, session.tenantId),
                        featureAccess.messagingFeature,
                        context.read<ChatsRepository>(),
                        context.read<ChatsOutboxRepository>(),
                        context.read<SmsRepository>(),
                        context.read<SmsOutboxRepository>(),
                        (n) => context.read<NotificationsBloc>().add(NotificationsSubmitted(n)),
                      );
                    },
                  ),
                  BlocProvider<UnreadCountCubit>(
                    create: (context) {
                      return UnreadCountCubit(
                        userId: context.read<AppBloc>().state.session.userId,
                        chatsRepository: context.read<ChatsRepository>(),
                        smsRepository: context.read<SmsRepository>(),
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
                              context.read<NotificationsBloc>().add(
                                NotificationsSubmitted(DefaultErrorNotification(error)),
                              );
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
                          create: (_) =>
                              SystemNotificationsCounterCubit(context.read<SystemNotificationsLocalRepository>()),
                        ),
                        BlocProvider(lazy: false, create: (_) => CallPullCubit(context.read<CallPullRepository>())),
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
                      child: Builder(
                        builder: (context) {
                          final sipPresenceFeature = featureAccess.sipPresenceFeature;

                          return PresenceViewParams(
                            viewSource: switch (sipPresenceFeature.sipPresenceSupport) {
                              true => PresenceViewSource.sipPresence,
                              false => PresenceViewSource.contactInfo,
                            },
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
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
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
  /// - [VoicemailRepository]: polled every 5 minutes, but only if the voicemail feature is enabled
  ///   in [FeatureAccess.settingsFeature].
  ///
  /// This method centralizes the polling configuration, so changes in polling logic or intervals
  /// can be made here without touching the [Provider] or [PollingService] setup.
  List<PollingRegistration> _pollingRegistrations(BuildContext context) {
    final isVoicemailsEnabled = context.read<FeatureAccess>().settingsFeature.isVoicemailsEnabled;

    return [
      PollingRegistration(
        listener: context.read<UserRepository>(),
        interval: const Duration(seconds: EnvironmentConfig.USER_REPOSITORY_POLLING_INTERVAL_SECONDS),
      ),
      PollingRegistration(
        listener: context.read<SystemInfoRemoteRepository>(),
        interval: const Duration(seconds: EnvironmentConfig.SYSTEM_INFO_REPOSITORY_POLLING_INTERVAL_SECONDS),
      ),
      PollingRegistration(
        listener: context.read<ExternalContactsRepository>(),
        interval: const Duration(seconds: EnvironmentConfig.EXTERNAL_CONTACTS_REPOSITORY_POLLING_INTERVAL_SECONDS),
      ),
      if (isVoicemailsEnabled)
        PollingRegistration(
          listener: context.read<VoicemailRepository>(),
          interval: const Duration(seconds: EnvironmentConfig.VOICEMAIL_REPOSITORY_POLLING_INTERVAL_SECONDS),
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
  /// - [VoicemailRepository]: refreshed when going online, but only if the voicemail feature
  ///   is enabled in [FeatureAccess.settingsFeature].
  ///
  /// This method centralizes the connectivity recovery configuration, so changes in
  /// registration logic can be made here without touching the [Provider] or service setup.
  List<ConnectivityRecoveryRegistration> _connectivityRecoveryRegistrations(BuildContext context) {
    final isVoicemailsEnabled = context.read<FeatureAccess>().settingsFeature.isVoicemailsEnabled;

    return [if (isVoicemailsEnabled) ConnectivityRecoveryRegistration.refreshable(context.read<VoicemailRepository>())];
  }

  /// Disposes [sessionGuard] if it implements [Disposable].
  /// This ensures any held resources are released before
  /// the widget tree is torn down.
  void _disposeSessionGuard() {
    disposeIfDisposable(_sessionGuard);
  }
}
