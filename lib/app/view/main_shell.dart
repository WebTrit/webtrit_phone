import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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

class MainShell extends StatefulWidget {
  const MainShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late final Callkeep callkeep;

  @override
  void initState() {
    super.initState();
    callkeep = Callkeep();
    callkeep.setUp(CallkeepOptions(
      ios: CallkeepIOSOptions(
        localizedName: PackageInfo().appName,
        ringtoneSound: Assets.ringtones.incomingCall1,
        iconTemplateImageAssetName: Assets.logoIconTemplateImage.path,
        maximumCallGroups: 2,
        maximumCallsPerCallGroup: 1,
        supportedHandleTypes: const {CallkeepHandleType.number},
      ),
    ));
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
            return WebtritApiClient(
              Uri.parse(context.read<AppBloc>().state.coreUrl!),
              connectionTimeout: kApiClientConnectionTimeout,
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
        RepositoryProvider<AccountRepository>(
          create: (context) => AccountRepository(
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
                externalContactsRepository: context.read<ExternalContactsRepository>(),
                appDatabase: context.read<AppDatabase>(),
              )..add(const ExternalContactsSyncStarted());
            },
          ),
          BlocProvider<CallBloc>(
            create: (context) {
              return CallBloc(
                recentsRepository: context.read<RecentsRepository>(),
                notificationsBloc: context.read<NotificationsBloc>(),
                appBloc: context.read<AppBloc>(),
                callkeep: callkeep,
              )..add(const CallStarted());
            },
          ),
        ],
        child: widget.child,
      ),
    );
  }
}
