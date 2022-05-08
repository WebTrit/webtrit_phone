import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/pages/web_registration.dart';
import 'package:webtrit_phone/styles/styles.dart';
import 'package:webtrit_phone/utils/utils.dart';

import 'main.dart';

class App extends StatelessWidget {
  App({
    Key? key,
    required this.webRegistrationInitialUrl,
    required this.isRegistered,
  }) : super(key: key);

  final String? webRegistrationInitialUrl;
  final bool isRegistered;

  String _initialRoute(String? webRegistrationInitialUrl, bool isRegistered) => isRegistered
      ? '/main'
      : webRegistrationInitialUrl == null
          ? '/login'
          : '/web-registration';

  @override
  Widget build(BuildContext context) {
    setDefaultOrientations();

    final materialApp = MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      restorationScopeId: 'App',
      title: EnvironmentConfig.APP_NAME,
      theme: ThemeData(
        primarySwatch: AppColors.primarySwatch,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      builder: (BuildContext context, Widget? child) {
        final themeData = Theme.of(context);
        return Theme(
          data: themeData.copyWith(
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.backgroundLight,
              elevation: 0,
              iconTheme: IconThemeData(
                color: themeData.textTheme.caption!.color,
              ),
              actionsIconTheme: IconThemeData(
                color: themeData.textTheme.caption!.color,
              ),
              titleTextStyle: themeData.primaryTextTheme.headline6!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
              centerTitle: true,
            ),
            tabBarTheme: TabBarTheme(
              labelColor: themeData.textTheme.caption!.color,
            ),
            inputDecorationTheme: const InputDecorationTheme(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: EdgeInsets.only(bottom: 10.0, left: 20.0, right: 10.0),
              filled: true,
              fillColor: AppColors.white,
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightGrey),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.grey),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                shape: const StadiumBorder(),
              ),
            ),
          ),
          child: child ?? Container(),
        );
      },
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WebtritApiClient>(
          create: (context) => WebtritApiClient(Uri.parse(EnvironmentConfig.CORE_URL)),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NotificationsBloc>(
            create: (context) => NotificationsBloc(),
          ),
          BlocProvider<AppBloc>(
            create: (context) => AppBloc(),
          ),
        ],
        child: materialApp,
      ),
    );
  }

  late final _router = GoRouter(
    initialLocation: _initialRoute(webRegistrationInitialUrl, isRegistered),
    routes: [
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: 'web-registration',
        path: '/web-registration',
        builder: (context, state) => WebRegistrationPage(
          initialUrl: state.extra != null ? state.extra! as String : webRegistrationInitialUrl!,
        ),
      ),
      GoRoute(
        name: 'main',
        path: '/main',
        builder: (context, state) => const Main(),
      ),
    ],
    navigatorBuilder: (context, state, child) => MultiBlocListener(
      listeners: [
        BlocListener<NotificationsBloc, NotificationsState>(
          listener: (context, state) {
            final lastNotification = state.lastNotification;
            if (lastNotification != null) {
              if (lastNotification is CallNotIdleErrorNotification) {
                context.showErrorSnackBar(context.l10n.notifications_errorSnackBar_callNotIdle);
              } else if (lastNotification is CallAttachErrorNotification) {
                context.showErrorSnackBar(context.l10n.notifications_errorSnackBar_callAttach);
              }
              context.read<NotificationsBloc>().add(const NotificationsCleared());
            }
          },
        ),
        BlocListener<AppBloc, AppState>(
          listener: (context, state) async {
            if (state is AppUnregister) {
              context.read<AppDatabase>().deleteEverything();

              final webRegistrationInitialUrl = await SecureStorage().readWebRegistrationInitialUrl();
              final isRegistered = await SecureStorage().readToken() != null;

              context.go(_initialRoute(webRegistrationInitialUrl, isRegistered), extra: webRegistrationInitialUrl);
            }
          },
        ),
      ],
      child: child,
    ),
  );
}
