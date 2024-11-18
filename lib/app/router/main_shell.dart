import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

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
  late final CallkeepBackgroundService _callkeepBackgroundService = CallkeepBackgroundService();

  late final FeatureAccess _featureAccess = FeatureAccess();
  late final AppPreferences _appPreferences = AppPreferences();

  @override
  void initState() {
    super.initState();
    final incomingCallType = _appPreferences.getIncomingCallType();

    _callkeep.setUp(
      CallkeepOptions(
        ios: CallkeepIOSOptions(
          localizedName: PackageInfo().appName,
          ringtoneSound: Assets.ringtones.incomingCall1,
          iconTemplateImageAssetName: Assets.callkeep.iosIconTemplateImage.path,
          maximumCallGroups: 13,
          maximumCallsPerCallGroup: 13,
          supportedHandleTypes: const {CallkeepHandleType.number},
        ),
        android: CallkeepAndroidOptions(
          incomingPath: initialCallRout,
          rootPath: initialMainRout,
          ringtoneSound: Assets.ringtones.incomingCall1,
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

  get _messagingEnabled => _featureAccess.isMessagingEnabled();

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
            sessionCleanupWorker: SessionCleanupWorker(),
            webtritApiClient: context.read<WebtritApiClient>(),
            token: context.read<AppBloc>().state.token!,
            periodicPolling: EnvironmentConfig.PERIODIC_POLLING,
          ),
        ),
        RepositoryProvider<AppRepository>(
          create: (context) => AppRepository(
            webtritApiClient: context.read<WebtritApiClient>(),
            token: context.read<AppBloc>().state.token!,
          ),
        ),
        RepositoryProvider<InfoRepository>(
          create: (context) => InfoRepository(
            webtritApiClient: context.read<WebtritApiClient>(),
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
              return LocalContactsSyncBloc(
                localContactsRepository: context.read<LocalContactsRepository>(),
                appDatabase: context.read<AppDatabase>(),
              )..add(const LocalContactsSyncStarted());
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
              final appCertificates = AppCertificates();

              return CallBloc(
                coreUrl: appBloc.state.coreUrl!,
                tenantId: appBloc.state.tenantId!,
                token: appBloc.state.token!,
                trustedCertificates: appCertificates.trustedCertificates,
                recentsRepository: context.read<RecentsRepository>(),
                notificationsBloc: context.read<NotificationsBloc>(),
                callkeep: _callkeep,
              )..add(const CallStarted());
            },
          ),
          if (_messagingEnabled)
            BlocProvider<MessagingBloc>(
              lazy: false,
              create: (context) {
                final appState = context.read<AppBloc>().state;
                final (token, tenantId, userId) = (appState.token!, appState.tenantId!, appState.userId!);

                // TODO: replace with createMessagingSocket after messaging-core merging
                const url = EnvironmentConfig.CHAT_SERVICE_URL;
                final socketOpts = PhoenixSocketOptions(params: {'token': token, 'tenant_id': tenantId});

                return MessagingBloc(
                  userId,
                  // createMessagingSocket(appState.coreUrl!, token, tenantId),
                  PhoenixSocket(url, socketOptions: socketOpts),
                  context.read<ChatsRepository>(),
                  context.read<ChatsOutboxRepository>(),
                  context.read<SmsRepository>(),
                  context.read<SmsOutboxRepository>(),
                  (n) => context.read<NotificationsBloc>().add(NotificationsSubmitted(n)),
                )..add(const Connect());
              },
            ),
          if (_messagingEnabled)
            BlocProvider<UnreadCountCubit>(
              create: (context) {
                return UnreadCountCubit(
                  userId: context.read<AppBloc>().state.userId!,
                  chatsRepository: context.read<ChatsRepository>(),
                  smsRepository: context.read<SmsRepository>(),
                )..init();
              },
            ),
          if (_messagingEnabled)
            BlocProvider(
              create: (_) => ChatsForwardingCubit(),
            )
        ],
        child: Builder(
          builder: (context) {
            final mainShellRepo = context.read<MainShellRouteStateRepository>();
            return BlocProvider<SessionStatusCubit>(
              create: (context) => SessionStatusCubit(
                pushTokensBloc: context.read<PushTokensBloc>(),
                callBloc: context.read<CallBloc>(),
              ),
              child: Builder(
                builder: (context) => CallShell(
                  child: MessagingShell(
                    child: AutoRouter(
                      navigatorObservers: () => [
                        MainShellNavigatorObserver(mainShellRepo),
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
