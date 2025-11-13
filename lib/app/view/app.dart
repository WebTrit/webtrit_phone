import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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
    final featureAccess = FeatureAccess();

    appBloc = AppBloc(
      appPreferences: context.read<AppPreferences>(),
      userAgreementStatusRepository: context.read<UserAgreementStatusRepository>(),
      contactsAgreementStatusRepository: context.read<ContactsAgreementStatusRepository>(),
      localeRepository: context.read<LocaleRepository>(),
      appThemes: context.read<AppThemes>(),
      sessionRepository: context.read<SessionRepository>(),
      appInfo: context.read<AppInfo>(),
    );
    appRouter = AppRouter(
      appBloc,
      context.read<AppPermissions>(),
      featureAccess.loginFeature.launchLoginPage,
      featureAccess.bottomMenuFeature,
      featureAccess.toChecker(),
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
              return MaterialApp.router(
                locale: state.effectiveLocale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                // restorationScopeId: 'App', // TODO: temporary comment to prevent AppShell's AutoRouter placeholder blink - additional investigation necessary
                title: EnvironmentConfig.APP_NAME,
                themeMode: state.effectiveThemeMode,
                theme: themeProvider.light(),
                darkTheme: themeProvider.dark(),
                routerConfig: appRouter.config(
                  deepLinkBuilder: isDeepLinkEnabled ? appRouter.deepLinkBuilder : null,
                  navigatorObservers: () => [
                    AppRouterObserver(),
                    context.read<AppAnalyticsRepository>().createObserver(),
                    AutoRouteObserver(),
                  ],
                  reevaluateListenable: ReevaluateListenable.stream(appBloc.stream),
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
          create: (context) => OrientationsBloc()..add(const OrientationsChanged(PreferredOrientation.regular)),
        ),
        BlocProvider<NotificationsBloc>(create: (context) => NotificationsBloc()),
        BlocProvider<AppBloc>.value(value: appBloc),
      ],
      child: materialApp,
    );
  }
}
