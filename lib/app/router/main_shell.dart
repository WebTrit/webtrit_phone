import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
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
  late final CallkeepBackgroundService _callkeepBackgroundService = CallkeepBackgroundService();

  @override
  void initState() {
    super.initState();
    final incomingCallType = context.read<AppPreferences>().getIncomingCallType();

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
          incomingPath: initialCallRout,
          rootPath: initialMainRout,
          ringtoneSound: Assets.ringtones.incomingCall1,
          ringbackSound: Assets.ringtones.outgoingCall1,
        ),
      ),
    );

    // Launch the service after user authorization if the selected incoming call type is socket-based.
    if (incomingCallType.isSocket) {
      _callkeepBackgroundService.startService();
    }
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
        RepositoryProvider<SelfConfigRepository>(
          create: (context) => SelfConfigRepository(
            context.read<WebtritApiClient>(),
            context.read<AppBloc>().state.token!,
          ),
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
        RepositoryProvider<RemoteNotificationRepository>(
          create: (context) => RemoteNotificationRepositoryBrokerImpl(),
        ),
        RepositoryProvider<LocalNotificationRepository>(
          create: (context) => LocalNotificationRepositoryFLNImpl(),
        ),
        RepositoryProvider<ActiveMessageNotificationsRepository>(
          create: (context) => ActiveMessageNotificationsRepositoryDriftImpl(
            appDatabase: context.read<AppDatabase>(),
          ),
        ),
        RepositoryProvider<CallToActionsRepository>(
          create: (context) => CallToActionsRepositoryImpl(
            webtritApiClient: context.read<WebtritApiClient>(),
            token: context.read<AppBloc>().state.token!,
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
              final bloc = LocalContactsSyncBloc(
                localContactsRepository: context.read<LocalContactsRepository>(),
                appDatabase: context.read<AppDatabase>(),
              );

              // TODO(Serdun): Consider moving this logic to the LocalContactBloc and decomposing the LocalContactsRepository.
              // The repository currently has direct access to the Permissions plugin, which might violate separation of concerns.
              // If contacts agreement is accepted, initiate the LocalContactsSyncStarted event.
              if (context.read<AppPreferences>().getContactsAgreementStatus().isAccepted) {
                bloc.add(const LocalContactsSyncStarted());
              }
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
              final appCertificates = AppCertificates();
              final encodingConfig = context.read<FeatureAccess>().callFeature.encoding;

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
                audioConstraintsBuilder: AudioConstraintsWithAppSettingsBuilder(appPreferences),
                videoConstraintsBuilder: VideoConstraintsWithAppSettingsBuilder(appPreferences),
                webRtcOptionsBuilder: WebrtcOptionsWithAppSettingsBuilder(appPreferences),
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
          )
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
                    context.read<SelfConfigRepository>(),
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
              ],
              child: Builder(
                builder: (context) => CallShell(
                  child: MessagingShell(
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
      ),
    );
  }
}
