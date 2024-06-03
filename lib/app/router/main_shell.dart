import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/app/constants.dart';
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
  late final Callkeep callkeep;

  @override
  void initState() {
    super.initState();
    callkeep = Callkeep();
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
  }

  @override
  void dispose() {
    callkeep.tearDown();
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
              final notificationBloc = context.read<NotificationsBloc>();

              return CallBloc(
                coreUrl: appBloc.state.coreUrl!,
                tenantId: appBloc.state.tenantId!,
                token: appBloc.state.token!,
                trustedCertificates: appCertificates.trustedCertificates,
                recentsRepository: context.read<RecentsRepository>(),
                onNotification: (n) => notificationBloc.add(NotificationSubmitted(n)),
                callkeep: callkeep,
                pendingCallHandler: appBloc.pendingCallHandler,
              )..add(const CallStarted());
            },
          ),
        ],
        child: Builder(
          builder: (context) => const CallShell(
            child: AutoRouter(),
          ),
        ),
      ),
    );
  }
}
