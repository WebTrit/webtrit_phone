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
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import 'package:webtrit_phone/services/services.dart' as foreground_call_isolate show onStart, onChangedLifecycle;

@RoutePage()
class MainShell extends StatefulWidget {
  const MainShell({
    super.key,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late final Callkeep callkeep;
  late final CallkeepBackgroundService androidCallkeepBackgroundService;
  late final FeatureAccess featureAccess;

  @override
  void initState() {
    super.initState();
    callkeep = Callkeep();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    callkeep.setUp(
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

    final incomingCallSocketType = AppPreferences().getIncomingCallType() == IncomingCallType.socket;

    androidCallkeepBackgroundService = CallkeepBackgroundService();
    androidCallkeepBackgroundService.setUp(
      onStart: foreground_call_isolate.onStart,
      onChangedLifecycle: foreground_call_isolate.onChangedLifecycle,
      autoStartOnBoot: incomingCallSocketType,
      autoRestartOnTerminate: incomingCallSocketType,
      androidNotificationName: context.l10n.settings_network_androidNotificationName,
      androidNotificationDescription: context.l10n.settings_network_androidNotificationDescription,
    );

    if (incomingCallSocketType) {
      CallkeepBackgroundService().startService();
    }
    featureAccess = FeatureAccess();
  }

  @override
  void dispose() {
    callkeep.tearDown();
    super.dispose();
  }

  get _messagingEnabled => featureAccess.isMessagingEnabled();

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
                firebaseMessaging: FirebaseMessaging.instance,
                callkeep: callkeep,
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
                callkeep: callkeep,
                pendingCallHandler: appBloc.pendingCallHandler,
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
            var mainShellRepo = context.read<MainShellRouteStateRepository>();
            return CallShell(
              child: MessagingShell(
                child: AutoRouter(navigatorObservers: () => [MainShellNavigatorObserver(mainShellRepo)]),
              ),
            );
          },
        ),
      ),
    );
  }
}
