import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/session/session.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';

/// The session-scoped repository layer of the main shell.
///
/// Everything here is built for the lifetime of an authenticated session on
/// top of the API client, the local database and the app-level singletons
/// provided above the shell. Extracted from [MainShell] as a widget of its own
/// so the layer reads as one unit and can be composed (or replaced) on its
/// own in tests.
class MainShellRepositories extends StatelessWidget {
  const MainShellRepositories({super.key, required this.sessionGuard, required this.child});

  /// Handles session expiration reported by the remote datasources; owned by
  /// the shell state so it stays alive across rebuilds of this layer.
  final SessionGuard sessionGuard;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Resolves the session snapshot the shell shadows above (see [MainShell]):
    // one configuration for the whole session, so the graph never reshapes.
    final featureAccess = context.read<FeatureAccess>();
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
              userAgent: context.read<AppMetadataProvider>().userAgent,
            );
          },
        ),
        RepositoryProvider<FavoritesRepository>(
          create: (context) {
            final appDatabase = context.read<AppDatabase>();
            final apiClient = context.read<WebtritApiClient>();
            final apiToken = context.read<AppBloc>().state.session.token!;
            final core = context.read<SystemInfoRepository>().getLocalSystemInfo().core;

            final localDataSource = FavoritesLocalDataSourceDriftImpl(appDatabase);
            final remoteDataSource = FavoritesRemoteDataSourceApiImpl(apiClient: apiClient, apiToken: apiToken);

            return FavoritesRepositorySyncableImpl(
              localDataSource: localDataSource,
              remoteDataSource: remoteDataSource,
              connectivityService: context.read<ConnectivityService>(),
              remoteSyncEnabled: core.supportsRemoteFavorites,
            );
          },
        ),
        RepositoryProvider<SipSubscriptionsRepository>(
          create: (context) {
            final appDatabase = context.read<AppDatabase>();
            final apiClient = context.read<WebtritApiClient>();
            final apiToken = context.read<AppBloc>().state.session.token!;

            final localDataSource = SipSubscriptionsLocalDataSourceDriftImpl(appDatabase);
            final remoteDataSource = SipSubscriptionsRemoteDataSourceApiImpl(apiClient: apiClient, apiToken: apiToken);

            return SipSubscriptionsRepositorySyncableImpl(
              localDataSource: localDataSource,
              remoteDataSource: remoteDataSource,
              connectivityService: context.read<ConnectivityService>(),
              remoteSyncEnabled: featureAccess.sipPresenceConfig.subsSyncEnabled,
            );
          },
        ),
        RepositoryProvider<RecentsRepository>(
          create: (context) => RecentsRepository(appDatabase: context.read<AppDatabase>()),
        ),
        RepositoryProvider<CallLogsRepository>(
          create: (context) => CallLogsRepository(appDatabase: context.read<AppDatabase>()),
        ),

        // TODO: Refactor dependency injection.
        RepositoryProvider<ContactsRepository>(
          create: (context) {
            final appDatabase = context.read<AppDatabase>();
            final webtritApiClient = context.read<WebtritApiClient>();

            final token = context.read<AppBloc>().state.session.token!;

            final supportsExtensions = featureAccess.coreSupport.supportsExtensions;
            final contactsRemoteDataSource = supportsExtensions
                ? ContactsRemoteDataSourceImpl(webtritApiClient, token)
                : null;
            final contactsLocalDataSource = ContactsLocalDataSourceImpl(appDatabase);

            return ContactsRepository(
              appDatabase: appDatabase,
              contactsRemoteDataSource: contactsRemoteDataSource,
              contactsLocalDataSource: contactsLocalDataSource,
            );
          },
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
        RepositoryProvider<SessionsRepository>(
          create: (context) => SessionsRepositoryApiImpl(
            context.read<WebtritApiClient>(),
            context.read<AppBloc>().state.session.token!,
            sessionGuard,
          ),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(
            remoteDatasource: UserRemoteDatasourceApiImpl(
              context.read<WebtritApiClient>(),
              context.read<AppBloc>().state.session.token!,
              sessionGuard: sessionGuard,
            ),
            localDatasource: context.read<UserLocalDatasource>(),
          ),
        ),
        // Resolves a phone number to a contact (and its display name) for the call
        // and keypad screens; previews override it with their own resolver.
        RepositoryProvider<ContactResolver>(
          create: (context) => DefaultContactResolver(
            contactsRepository: context.read<ContactsRepository>(),
            userRepository: context.read<UserRepository>(),
          ),
        ),
        RepositoryProvider<CallerIdSettingsRepository>(
          create: (context) {
            final core = context.read<SystemInfoRepository>().getLocalSystemInfo().core;
            final remoteSettingsSupport = core.supportsRemoteCallerIdSettings;
            if (remoteSettingsSupport) {
              return CallerIdSettingsRepositoryRemoteImpl(
                context.read<WebtritApiClient>(),
                context.read<AppBloc>().state.session.token!,
              );
            } else {
              return CallerIdSettingsRepositoryPrefsImpl(context.read<AppPreferences>());
            }
          },
          dispose: (repo) => repo.clear(),
        ),
        RepositoryProvider<PrivateGatewayRepository>(
          create: (context) => CustomPrivateGatewayRepository(
            context.read<WebtritApiClient>(),
            context.read<SecureStorage>(),
            context.read<AppBloc>().state.session.token!,
            sessionGuard,
          ),
          dispose: disposeIfDisposable,
        ),
        RepositoryProvider<VoicemailRepository>(
          create: (context) {
            final isVoicemailsEnabled = featureAccess.voicemailAvailable;

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
        RepositoryProvider<IceServersRepository>(
          create: (context) {
            // Only a core that bundles STUN/TURN servers has a configuration to
            // serve; every other deployment keeps the public STUN fallback,
            // which the empty implementation returns without a request.
            if (!featureAccess.coreSupport.supportsBundledIceServers) return const EmptyIceServersRepository();

            return IceServersRepositoryImpl(
              webtritApiClient: context.read<WebtritApiClient>(),
              token: context.read<AppBloc>().state.session.token!,
            );
          },
          dispose: disposeIfDisposable,
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
            sessionGuard,
          ),
        ),
        RepositoryProvider<LinesStateRepository>(create: (context) => LinesStateRepositoryInMemoryImpl()),
        RepositoryProvider<PresenceInfoRepository>(
          create: (context) => PresenceInfoRepositoryDriftImpl(context.read<AppDatabase>()),
        ),
        RepositoryProvider<DialogInfoRepository>(
          create: (context) => DialogInfoRepositoryDriftImpl(context.read<AppDatabase>()),
        ),
        RepositoryProvider<CdrsLocalRepository>(
          create: (context) => CdrsLocalRepositoryDriftImpl(context.read<AppDatabase>()),
        ),
        RepositoryProvider<CdrsRemoteRepository>(
          create: (context) => CdrsRemoteRepositoryApiImpl(
            context.read<WebtritApiClient>(),
            context.read<AppBloc>().state.session.token!,
            sessionGuard,
          ),
        ),
        RepositoryProvider<AppCacheManager>(
          create: (context) {
            final appPath = context.read<AppPath>();

            return AppCacheManager(
              sections: [
                if (!kIsWeb && featureAccess.voicemailAvailable)
                  VoicemailCacheSection(
                    mediaCacheBasePath: appPath.mediaCacheBasePath,
                    temporaryPath: appPath.temporaryPath,
                  ),
                DatabaseCacheSection(context.read<AppDatabase>(), context.read<CdrsLocalRepository>()),
              ],
            );
          },
        ),
      ],
      child: child,
    );
  }
}
