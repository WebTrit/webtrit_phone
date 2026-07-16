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
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/resolvers/resolvers.dart';

final _logger = Logger('AppWidget');

class App extends StatefulWidget {
  const App({super.key, this.ownsBrowserHistory = true});

  /// See `RootApp.ownsBrowserHistory`: when `false` (embedded preview) the app's
  /// router uses an in-memory route-information provider, so it renders normally
  /// but never syncs the browser URL.
  final bool ownsBrowserHistory;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppBloc appBloc;
  late final AppRouter appRouter;

  /// In-memory route-information provider for an embedded instance (when the app
  /// does not own the browser history). Seeds the initial location and swallows
  /// navigations so the browser URL is never touched. Null in a standalone run.
  late final _InMemoryRouteInformationProvider? _embeddedRouteInformationProvider = widget.ownsBrowserHistory
      ? null
      : _InMemoryRouteInformationProvider(RouteInformation(uri: Uri.parse('/')));

  /// Inert back-button dispatcher for an embedded instance. A standalone run lets
  /// [AppRouter.config] install a [RootBackButtonDispatcher], which registers a
  /// global observer on the platform back button; on the engine the embedded
  /// preview shares with its host that would swallow the host's back button. The
  /// inert dispatcher never claims it, so the host keeps full control. Null in a
  /// standalone run.
  late final BackButtonDispatcher? _embeddedBackButtonDispatcher = widget.ownsBrowserHistory
      ? null
      : _NoopBackButtonDispatcher();

  /// Deep-link builder, resolved once. Null when deep links are disabled.
  late final _deepLinkBuilder = EnvironmentConfig.APP_LINK_DOMAIN.isNotEmpty ? appRouter.deepLinkBuilder : null;

  /// Drives router guard re-evaluation off [AppBloc]. Built once (not per
  /// rebuild): the router caches the first listenable it is handed, so rebuilding
  /// it would leak an [AppBloc] stream subscription on every theme/locale change.
  /// Disposed in [dispose].
  late final ReevaluateListenable _reevaluateListenable = ReevaluateListenable.stream(
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
  );

  List<NavigatorObserver> _navigatorObservers() => [
    AppRouterObserver(),
    context.read<AppAnalyticsRepository>().createObserver(),
    AutoRouteObserver(),
  ];

  @override
  void initState() {
    super.initState();
    final featureAccess = context.read<FeatureAccess>();

    appBloc = AppBloc(
      userAgreementStatusRepository: context.read<UserAgreementStatusRepository>(),
      contactsAgreementStatusRepository: context.read<ContactsAgreementStatusRepository>(),
      localeRepository: context.read<LocaleRepository>(),
      themeModeRepository: context.read<ThemeModeRepository>(),
      sessionRepository: context.read<SessionRepository>(),
      systemInfoRepository: context.read<SystemInfoRepository>(),
      appCompatibilityResolver: context.read<AppCompatibilityResolver>(),
      appInfo: context.read<AppInfo>(),
      supportedLocales: featureAccess.localizationConfig.supportedLocales,
      userSessionCleanupResolver: RepositoryUserSessionCleanupResolver(
        systemInfoRepository: context.read<SystemInfoRepository>(),
        registerStatusRepository: context.read<RegisterStatusRepository>(),
        presenceSettingsRepository: context.read<PresenceSettingsRepository>(),
        queuedTerminationRequestsRepository: context.read<QueuedTerminationRequestsRepository>(),
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
    _reevaluateListenable.dispose();
    _embeddedRouteInformationProvider?.dispose();
    appBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final featureAccess = context.watch<FeatureAccess>();
    final themeSettings = context.watch<ThemeSettings>();
    // Optional read-only override from a host (the configurator's preview);
    // null in a standalone run. When set it wins, so the preview reflects the
    // host's light/dark toggle without persisting anything.
    final hostThemeMode = context.watch<ThemeMode?>();

    final materialApp = ThemeProvider(
      settings: themeSettings,
      lightDynamic: null,
      darkDynamic: null,
      child: BlocBuilder<AppBloc, AppState>(
        buildWhen: (previous, current) =>
            previous.effectiveLocale != current.effectiveLocale || previous.themeMode != current.themeMode,
        builder: (context, state) {
          final themeProvider = ThemeProvider.of(context);
          final forcedMode = featureAccess.supportedConfig.themeMode;
          // Precedence: a host override wins over the feature-access forced mode
          // by design. It is only ever set in a preview (the configurator's
          // light/dark variant toggle), where it must show the chosen variant
          // even if the previewed config enforces a mode; that override-an-
          // enforced-mode case cannot happen in a standalone run, where
          // hostThemeMode is always null and forcedMode governs as before.
          final finalThemeMode =
              hostThemeMode ??
              (forcedMode == ThemeMode.system ? themeSettings.effectiveThemeMode(state.themeMode) : forcedMode);

          return MaterialApp.router(
            locale: state.effectiveLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: featureAccess.localizationConfig.supportedLocales,
            // restorationScopeId: 'App', // TODO: temporary comment to prevent AppShell's AutoRouter placeholder blink - additional investigation necessary
            title: EnvironmentConfig.APP_NAME,
            themeMode: finalThemeMode,
            theme: themeProvider.light(),
            darkTheme: themeProvider.dark(),
            // Standalone owns the browser history: the full config syncs the URL.
            routerConfig: widget.ownsBrowserHistory
                ? appRouter.config(
                    deepLinkBuilder: _deepLinkBuilder,
                    navigatorObservers: _navigatorObservers,
                    reevaluateListenable: _reevaluateListenable,
                  )
                : null,
            // Embedded preview: the same parser/delegate (so the initial route
            // renders normally) but an in-memory route-information provider and an
            // inert back-button dispatcher, so forward navigation stays internal
            // and never writes the host's browser URL, and the system back button
            // is left to the host.
            //
            // Known limitation: an in-app back (`context.back()`) routes through
            // auto_route's own web navigation history, which calls
            // `window.history.back()` directly and is not injectable without
            // forking auto_route internals. It is acceptable here because the
            // preview is forward-oriented (login flow) and the host can recover.
            routeInformationParser: widget.ownsBrowserHistory ? null : appRouter.defaultRouteParser(),
            routeInformationProvider: widget.ownsBrowserHistory ? null : _embeddedRouteInformationProvider,
            backButtonDispatcher: widget.ownsBrowserHistory ? null : _embeddedBackButtonDispatcher,
            routerDelegate: widget.ownsBrowserHistory
                ? null
                : appRouter.delegate(
                    deepLinkBuilder: _deepLinkBuilder,
                    navigatorObservers: _navigatorObservers,
                    reevaluateListenable: _reevaluateListenable,
                  ),
          );
        },
      ),
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

/// A [RouteInformationProvider] that keeps routing entirely in memory.
///
/// It seeds a fixed initial location and ignores navigations reported by the
/// router (it never calls into the platform / `window.history`). Used by an
/// embedded instance that must not own the browser URL, while still driving the
/// app's parser/delegate so screens render normally.
class _InMemoryRouteInformationProvider extends RouteInformationProvider with ChangeNotifier {
  _InMemoryRouteInformationProvider(this._value);

  RouteInformation _value;

  @override
  RouteInformation get value => _value;

  @override
  void routerReportsNewRouteInformation(
    RouteInformation routeInformation, {
    RouteInformationReportingType type = RouteInformationReportingType.none,
  }) {
    _value = routeInformation;
  }
}

/// A [BackButtonDispatcher] that never claims the platform back button.
///
/// Unlike [RootBackButtonDispatcher], the base dispatcher installs no
/// `WidgetsBinding` observer, so the platform back button is never routed to it.
/// An embedded instance uses it to avoid intercepting the back button on the
/// engine it shares with its host.
class _NoopBackButtonDispatcher extends BackButtonDispatcher {}
