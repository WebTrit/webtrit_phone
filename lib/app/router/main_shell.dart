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
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class MainShell extends StatefulWidget {
  const MainShell({
    super.key,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late final Callkeep _callkeep = Callkeep();
  late final CallkeepConnections _callkeepConnections = CallkeepConnections();

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
        ),
      ),
    );

    // After authentication, regenerate the labels to include core URL and tenant ID in remote logging labels
    context.read<AppLogger>().regenerateRemoteLabels();
  }

  @override
  void dispose() {
    _callkeep.tearDown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WebtritApiClient>(
          create: (context) {
            final appBloc = context.read<AppBloc>();
            final appCerts = AppCertificates();

            return WebtritApiClient(
              Uri.parse(appBloc.state.coreUrl!),
              appBloc.state.tenantId!,
              connectionTimeout: kApiClientConnectionTimeout,
              certs: appCerts.trustedCertificates,
            );
          },
        ),
        RepositoryProvider<FavoritesRepository>(
          create: (context) => FavoritesRepository(
            appDatabase: context.read<AppDatabase>(),
          ),
        ),
        RepositoryProvider<RecentsRepository>(
          create: (context) => RecentsRepository(
            appDatabase: context.read<AppDatabase>(),
          ),
        ),
        RepositoryProvider<CallLogsRepository>(
          create: (context) => CallLogsRepository(
            appDatabase: context.read<AppDatabase>(),
          ),
        ),
        RepositoryProvider<ContactsRepository>(
          create: (context) => ContactsRepository(
            appDatabase: context.read<AppDatabase>(),
          ),
        ),
        RepositoryProvider<LocalContactsRepository>(
          create: (context) => LocalContactsRepository(),
        ),
        RepositoryProvider<PushTokensRepository>(
          create: (context) => PushTokensRepository(
            webtritApiClient: context.read<WebtritApiClient>(),
            token: context.read<AppBloc>().state.token!,
          ),
        ),
        RepositoryProvider<ExternalContactsRepository>(
          create: (context) => ExternalContactsRepository(
            webtritApiClient: context.read<WebtritApiClient>(),
            token: context.read<AppBloc>().state.token!,
            periodicPolling: EnvironmentConfig.PERIODIC_POLLING,
          ),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(
            context.read<WebtritApiClient>(),
            context.read<AppBloc>().state.token!,
            polling: EnvironmentConfig.PERIODIC_POLLING,
            sessionCleanupWorker: SessionCleanupWorker(),
          ),
        ),
        RepositoryProvider<SystemInfoRepository>(
          create: (context) => SystemInfoRepository(
            context.read<WebtritApiClient>(),
          ),
        ),
        RepositoryProvider<CustomPrivateGatewayRepository>(
          create: (context) => CustomPrivateGatewayRepository(
            context.read<WebtritApiClient>(),
            context.read<SecureStorage>(),
            context.read<AppBloc>().state.token!,
          ),
        ),
        RepositoryProvider<VoicemailRepository>(
          create: (context) {
            final featureAccess = context.read<FeatureAccess>();

            return VoicemailRepositoryImpl(
              webtritApiClient: context.read<WebtritApiClient>(),
              token: context.read<AppBloc>().state.token!,
              appDatabase: context.read<AppDatabase>(),
              repositoryOptions: RepositoryOptions(
                shouldOperate: featureAccess.settingsFeature.isVoicemailsEnabled,
                polling: EnvironmentConfig.PERIODIC_POLLING,
                pollPeriod: const Duration(minutes: 5),
              ),
            );
          },
        ),
        RepositoryProvider<AppRepository>(
          create: (context) => AppRepository(
            webtritApiClient: context.read<WebtritApiClient>(),
            token: context.read<AppBloc>().state.token!,
          ),
        ),
        RepositoryProvider<ChatsRepository>(
          create: (context) => ChatsRepository(
            appDatabase: context.read<AppDatabase>(),
          ),
        ),
        RepositoryProvider<ChatsOutboxRepository>(
          create: (context) => ChatsOutboxRepository(
            appDatabase: context.read<AppDatabase>(),
          ),
        ),
        RepositoryProvider<SmsRepository>(
          create: (context) => SmsRepository(
            appDatabase: context.read<AppDatabase>(),
          ),
        ),
        RepositoryProvider<SmsOutboxRepository>(
          create: (context) => SmsOutboxRepository(
            appDatabase: context.read<AppDatabase>(),
          ),
        ),
        RepositoryProvider<MainScreenRouteStateRepository>(
          create: (context) => MainScreenRouteStateRepositoryAutoRouteImpl(),
        ),
        RepositoryProvider<MainShellRouteStateRepository>(
          create: (context) => MainShellRouteStateRepositoryAutoRouteImpl(),
        ),
        RepositoryProvider<RemotePushRepository>(
          create: (context) => RemotePushRepositoryBrokerImpl(),
        ),
        RepositoryProvider<LocalPushRepository>(
          create: (context) => LocalPushRepositoryFLNImpl(),
        ),
        RepositoryProvider<ActiveMessagePushsRepository>(
          create: (context) => ActiveMessagePushsRepositoryDriftImpl(
            appDatabase: context.read<AppDatabase>(),
          ),
        ),
        RepositoryProvider<CallToActionsRepository>(
          create: (context) => CallToActionsRepositoryImpl(
            webtritApiClient: context.read<WebtritApiClient>(),
            token: context.read<AppBloc>().state.token!,
          ),
        ),
        RepositoryProvider<SystemNotificationsLocalRepository>(
          create: (context) => SystemNotificationsLocalRepositoryDriftImpl(
            context.read<AppDatabase>(),
          ),
        ),
        RepositoryProvider<SystemNotificationsRemoteRepository>(
          create: (context) => SystemNotificationsRemoteRepositoryApiImpl(
            context.read<WebtritApiClient>(),
            context.read<AppBloc>().state.token!,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PushTokensBloc>(
            lazy: false,
            create: (context) {
              return PushTokensBloc(
                pushTokensRepository: context.read<PushTokensRepository>(),
                secureStorage: context.read<SecureStorage>(),
                firebaseMessaging: FirebaseMessaging.instance,
                callkeep: _callkeep,
              )..add(const PushTokensStarted());
            },
          ),
          BlocProvider<RecentsBloc>(
            create: (context) {
              return RecentsBloc(
                recentsRepository: context.read<RecentsRepository>(),
                appPreferences: context.read<AppPreferences>(),
                dateFormat: AppTime().formatDateTime(),
              )..add(const RecentsStarted());
            },
          ),
          BlocProvider<LocalContactsSyncBloc>(
            lazy: false,
            create: (context) {
              final localContactsRepository = context.read<LocalContactsRepository>();
              final appDatabase = context.read<AppDatabase>();
              final appPreferences = context.read<AppPreferences>();
              final featureAccess = context.read<FeatureAccess>();
              final appPermissions = context.read<AppPermissions>();

              Future<bool> isFutureEnabled() async {
                final contactTab = featureAccess.bottomMenuFeature.getTabEnabled(MainFlavor.contacts)?.toContacts;
                final contactSourceTypes = contactTab?.contactSourceTypes ?? [];
                return contactSourceTypes.contains(ContactSourceType.local);
              }

              Future<bool> isAgreementAccepted() async {
                final contactsAgreementStatus = appPreferences.getContactsAgreementStatus();
                return contactsAgreementStatus.isAccepted;
              }

              final bloc = LocalContactsSyncBloc(
                localContactsRepository: localContactsRepository,
                appDatabase: appDatabase,
                appPreferences: appPreferences,
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
              final appPreferences = context.read<AppPreferences>();
              final notificationsBloc = context.read<NotificationsBloc>();
              // TODO(Serdun): Refactor into an inherited widget for better code consistency and reusability
              final appCertificates = AppCertificates();
              final featureAccess = context.read<FeatureAccess>();

              final encodingConfig = featureAccess.callFeature.encoding;
              final peerConnectionConfig = featureAccess.callFeature.peerConnection;

              // Initialize media builder with app-configured audio/video constraints
              // Used to capture synchronized MediaStream (audio+video) for WebRTC track addition.
              final userMediaBuilder = DefaultUserMediaBuilder(
                audioConstraintsBuilder: AudioConstraintsWithAppSettingsBuilder(appPreferences),
                videoConstraintsBuilder: VideoConstraintsWithAppSettingsBuilder(appPreferences),
              );
              // Initialize peer connection policy applier with app-specific negotiation rules
              final pearConnectionPolicyApplier = ModifyWithSettingsPeerConnectionPolicyApplier(
                appPreferences,
                peerConnectionConfig,
                userMediaBuilder,
              );
              // Initialize contact name resolver with app-specific contact repository
              // Used to display contact name of caller
              final contactNameResolver = DefaultContactNameResolver(
                contactRepository: context.read<ContactsRepository>(),
              );

              return CallBloc(
                coreUrl: appBloc.state.coreUrl!,
                tenantId: appBloc.state.tenantId!,
                token: appBloc.state.token!,
                trustedCertificates: appCertificates.trustedCertificates,
                callLogsRepository: context.read<CallLogsRepository>(),
                submitNotification: (n) => notificationsBloc.add(NotificationsSubmitted(n)),
                callkeep: _callkeep,
                callkeepConnections: _callkeepConnections,
                sdpMunger: ModifyWithEncodingSettings(appPreferences, encodingConfig),
                sdpSanitizer: RemoteSdpSanitizer(),
                webRtcOptionsBuilder: WebrtcOptionsWithAppSettingsBuilder(appPreferences),
                userMediaBuilder: userMediaBuilder,
                contactNameResolver: contactNameResolver,
                iceFilter: FilterWithAppSettings(appPreferences),
                peerConnectionPolicyApplier: pearConnectionPolicyApplier,
              )..add(const CallStarted());
            },
          ),
          BlocProvider<MessagingBloc>(
            lazy: false,
            create: (context) {
              final appState = context.read<AppBloc>().state;
              final (token, tenantId, userId) = (appState.token!, appState.tenantId!, appState.userId!);

              return MessagingBloc(
                userId,
                createMessagingSocket(appState.coreUrl!, token, tenantId),
                FeatureAccess().messagingFeature,
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
                userId: context.read<AppBloc>().state.userId!,
                chatsRepository: context.read<ChatsRepository>(),
                smsRepository: context.read<SmsRepository>(),
              )..init();
            },
          ),
          BlocProvider(
            create: (_) => ChatsForwardingCubit(),
          ),
          InheritedProvider(
            create: (context) => SystemNotificationsSyncWorker(
              context.read<SystemNotificationsLocalRepository>(),
              context.read<SystemNotificationsRemoteRepository>(),
            ),
            dispose: (context, worker) => worker.dispose(),
          ),
          InheritedProvider(
            create: (context) => SystemNotificationsOutboxWorker(
              context.read<SystemNotificationsLocalRepository>(),
              context.read<SystemNotificationsRemoteRepository>(),
            ),
            dispose: (context, worker) => worker.dispose(),
          ),
        ],
        child: Builder(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  lazy: false,
                  create: (_) => UserInfoCubit(
                    context.read<UserRepository>(),
                  ),
                ),
                BlocProvider(
                  lazy: false,
                  create: (_) => SelfConfigCubit(
                    context.read<CustomPrivateGatewayRepository>(),
                    context.read<FeatureAccess>().settingsFeature.isSelfConfigEnabled,
                  ),
                ),
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
                    context.read<AppPreferences>(),
                    handleError: (error, stackTrace) {
                      context.read<NotificationsBloc>().add(NotificationsSubmitted(DefaultErrorNotification(error)));
                      context.read<AppBloc>().maybeHandleError(error);
                    },
                  ),
                ),
                BlocProvider<SystemNotificationsCounterCubit>(
                  lazy: false,
                  create: (_) => SystemNotificationsCounterCubitRecordsBasedImpl(
                    context.read<SystemNotificationsLocalRepository>(),
                  ),
                ),
              ],
              child: Builder(
                builder: (context) {
                  return CallShell(
                    child: MessagingShell(
                      child: SystemNotificationsShell(
                        child: AutoRouter(
                          navigatorObservers: () => [
                            MainShellNavigatorObserver(context.read<MainShellRouteStateRepository>()),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
