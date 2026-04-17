import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/app/router/app_router_observer.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/resolvers/resolvers.dart';

final _logger = Logger('AppWidget');

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppBloc appBloc;
  late final AppRouter appRouter;

  @override
  void initState() {
    super.initState();
    final featureAccess = context.read<FeatureAccess>();

    appBloc = AppBloc(
      userAgreementStatusRepository: context.read<UserAgreementStatusRepository>(),
      contactsAgreementStatusRepository: context.read<ContactsAgreementStatusRepository>(),
      localeRepository: context.read<LocaleRepository>(),
      themeModeRepository: context.read<ThemeModeRepository>(),
      appThemes: context.read<AppThemes>(),
      sessionRepository: context.read<SessionRepository>(),
      systemInfoRepository: context.read<SystemInfoRepository>(),
      appInfo: context.read<AppInfo>(),
      userSessionCleanupResolver: RepositoryUserSessionCleanupResolver(
        systemInfoRepository: context.read<SystemInfoRepository>(),
        registerStatusRepository: context.read<RegisterStatusRepository>(),
        presenceSettingsRepository: context.read<PresenceSettingsRepository>(),
        activeMainFlavorRepository: context.read<ActiveMainFlavorRepository>(),
        activeRecentsVisibilityFilterRepository: context.read<ActiveRecentsVisibilityFilterRepository>(),
        activeContactSourceTypeRepository: context.read<ActiveContactSourceTypeRepository>(),
        audioProcessingSettingsRepository: context.read<AudioProcessingSettingsRepository>(),
        encodingPresetRepository: context.read<EncodingPresetRepository>(),
        iceSettingsRepository: context.read<IceSettingsRepository>(),
        incomingCallTypeRepository: context.read<IncomingCallTypeRepository>(),
        peerConnectionSettingsRepository: context.read<PeerConnectionSettingsRepository>(),
        videoCapturingSettingsRepository: context.read<VideoCapturingSettingsRepository>(),
        encodingSettingsRepository: context.read<EncodingSettingsRepository>(),
        localeRepository: context.read<LocaleRepository>(),
        themeModeRepository: context.read<ThemeModeRepository>(),
        userLocalDatasource: context.read<UserLocalDatasource>(),
        appDatabase: context.read<AppDatabase>(),
      ),
    );

    final initialTabResolver = BottomMenuInitialTabResolver(
      config: featureAccess.bottomMenuConfig,
      repository: context.read<ActiveMainFlavorRepository>(),
    );

    appRouter = AppRouter(
      appBloc,
      context.read<AppPermissions>(),
      context.read<SystemInfoRepository>(),
      featureAccess.loginConfig.launchLoginPage,
      featureAccess.bottomMenuConfig,
      initialTabResolver,
      featureAccess.checker,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final featureAccess = context.watch<FeatureAccess>();

    context.read<AppLogger>().applyConfig(featureAccess.loggingConfig);

    final initialTabResolver = BottomMenuInitialTabResolver(
      config: featureAccess.bottomMenuConfig,
      repository: context.read<ActiveMainFlavorRepository>(),
    );

    appRouter.updateConfiguration(
      featureAccess.loginConfig.launchLoginPage,
      featureAccess.bottomMenuConfig,
      initialTabResolver,
      featureAccess.checker,
    );
  }

  @override
  void dispose() {
    appBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDeepLinkEnabled = EnvironmentConfig.APP_LINK_DOMAIN.isNotEmpty;

    final featureAccess = context.watch<FeatureAccess>();

    final materialApp = BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => previous.themeSettings != current.themeSettings,
      builder: (context, state) {
        return ThemeProvider(
          settings: state.themeSettings,
          lightDynamic: null,
          darkDynamic: null,
          child: BlocBuilder<AppBloc, AppState>(
            buildWhen: (previous, current) =>
                previous.effectiveLocale != current.effectiveLocale ||
                previous.effectiveThemeMode != current.effectiveThemeMode,
            builder: (context, state) {
              final themeProvider = ThemeProvider.of(context);
              final forcedMode = featureAccess.supportedConfig.themeMode;
              final finalThemeMode = forcedMode == ThemeMode.system ? state.effectiveThemeMode : forcedMode;

              return MaterialApp.router(
                locale: state.effectiveLocale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                // restorationScopeId: 'App', // TODO: temporary comment to prevent AppShell's AutoRouter placeholder blink - additional investigation necessary
                title: EnvironmentConfig.APP_NAME,
                themeMode: finalThemeMode,
                theme: themeProvider.light(),
                darkTheme: themeProvider.dark(),
                routerConfig: appRouter.config(
                  deepLinkBuilder: isDeepLinkEnabled ? appRouter.deepLinkBuilder : null,
                  navigatorObservers: () => [
                    AppRouterObserver(),
                    context.read<AppAnalyticsRepository>().createObserver(),
                    AutoRouteObserver(),
                  ],
                  reevaluateListenable: ReevaluateListenable.stream(
                    // Insert and skip the initial state to ensure the distinct buffer if filled
                    // and ensure the next state change is emitted only if it differ from the initial state.
                    //
                    // Please verify next caases if you change this logic:
                    // - Call drop after theme change or locale change:
                    appBloc.stream
                        .mergeAll([
                          Stream.fromIterable([appBloc.state]),
                        ])
                        .distinct((p, n) {
                          final same = p.compareToReevaluate(n);
                          _logger.fine('AppState compareToReevaluate: $same');
                          if (!same) _logger.fine('AppState compareToReevaluate: previous: $p\n  next: $n');
                          return same;
                        })
                        .skip(1),
                  ),
                ),
              );
            },
          ),
        );
      },
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<OrientationsBloc>(
          lazy: false,
          create: (context) =>
              OrientationsBloc(deviceRotationUtil: const DeviceRotationUtil())
                ..add(const OrientationsChanged(PreferredOrientation.portrait)),
        ),
        BlocProvider<NotificationsBloc>(create: (context) => NotificationsBloc()),
        BlocProvider<AppBloc>.value(value: appBloc),
      ],
      child: materialApp,
    );
  }
}
