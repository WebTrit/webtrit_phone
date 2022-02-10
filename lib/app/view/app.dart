import 'package:flutter/material.dart';

import 'package:callkeep/callkeep.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/pages/settings.dart';
import 'package:webtrit_phone/pages/web_registration.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/utils/utils.dart';

class App extends StatelessWidget {
  const App({
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

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      restorationScopeId: 'App',
      title: EnvironmentConfig.APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: _initialRoute(webRegistrationInitialUrl, isRegistered),
      builder: (BuildContext context, Widget? child) {
        final themeData = Theme.of(context);
        return Theme(
          data: themeData.copyWith(
            appBarTheme: AppBarTheme(
              color: themeData.canvasColor,
              iconTheme: IconThemeData(
                color: themeData.textTheme.caption!.color,
              ),
              actionsIconTheme: IconThemeData(
                color: themeData.textTheme.caption!.color,
              ),
              titleTextStyle: themeData.primaryTextTheme.headline6!.copyWith(
                color: themeData.colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
              centerTitle: false,
            ),
            tabBarTheme: TabBarTheme(
              labelColor: themeData.textTheme.caption!.color,
            ),
          ),
          child: child ?? Container(),
        );
      },
      onGenerateRoute: (RouteSettings settings) {
        Widget page;
        switch (settings.name) {
          case '/login':
            page = const LoginPage();
            break;
          case '/web-registration':
            page = WebRegistrationPage(
              initialUrl: settings.arguments != null ? settings.arguments as String : webRegistrationInitialUrl!,
            );
            break;
          case '/main':
            page = MultiBlocProvider(
              providers: [
                BlocProvider<PushTokensBloc>(
                  lazy: false,
                  create: (context) {
                    return PushTokensBloc(
                      pushTokensRepository: context.read<PushTokensRepository>(),
                      firebaseMessaging: FirebaseMessaging.instance,
                      callkeep: FlutterCallkeep(),
                    )..add(const PushTokensStarted());
                  },
                ),
                BlocProvider<RecentsBloc>(
                  create: (context) {
                    return RecentsBloc(
                      recentsRepository: context.read<RecentsRepository>(),
                    )..add(const RecentsInitialLoaded());
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
                      callRepository: context.read<CallRepository>(),
                      recentsRepository: context.read<RecentsRepository>(),
                      notificationsBloc: context.read<NotificationsBloc>(),
                      appBloc: context.read<AppBloc>(),
                    )..add(const CallAttached());
                  },
                ),
              ],
              child: BlocListener<CallBloc, CallState>(
                listenWhen: (previous, current) => previous.runtimeType != current.runtimeType,
                listener: (context, state) {
                  if (state is CallActive) {
                    setCallOrientations().then((_) {
                      Navigator.pushNamed(context, '/main/call',
                          arguments: CallNavigationArguments(
                            callBloc: context.read<CallBloc>(),
                          ));
                    });
                  }
                  if (state is CallIdle && Navigator.canPop(context)) {
                    // TODO canPop must be removed by reorganise states
                    setDefaultOrientations().then((_) {
                      Navigator.pop(context);
                    });
                  }
                },
                child: const MainPage(),
              ),
            );
            break;
          case '/main/call':
            final callNavigationArguments = settings.arguments as CallNavigationArguments;
            page = BlocProvider<CallBloc>.value(
              value: callNavigationArguments.callBloc,
              child: const CallPage(),
            );
            break;
          case '/main/settings':
            page = const SettingsPage();
            break;
          case '/main/log-records-console':
            page = const LogRecordsConsolePage();
            break;
          case '/main/contact':
            final contact = settings.arguments! as Contact;
            page = ContactPage(contact);
            break;
          case '/main/recent':
            final recent = settings.arguments! as Recent;
            page = RecentScreen(recent);
            break;
          default:
            return null;
        }

        if ('/'.allMatches(settings.name!).length <= 1) {
          // add listener only to top level page
          page = BlocListener<NotificationsBloc, NotificationsState>(
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
            child: page,
          );

          page = BlocListener<AppBloc, AppState>(
            listener: (context, state) async {
              if (state is AppUnregister) {
                final webRegistrationInitialUrl = await SecureStorage().readWebRegistrationInitialUrl();
                final isRegistered = await SecureStorage().readToken() != null;

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  _initialRoute(webRegistrationInitialUrl, isRegistered),
                  (route) => false,
                  arguments: webRegistrationInitialUrl,
                );
              }
            },
            child: page,
          );
        }

        switch (settings.name) {
          case '/main/call':
            return PageRouteBuilder(
              fullscreenDialog: true,
              settings: settings,
              pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                return page;
              },
              transitionsBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation, Widget child) {
                const builder = ZoomPageTransitionsBuilder();
                return builder.buildTransitions(null, context, animation, secondaryAnimation, child);
              },
            );
          default:
            return MaterialPageRoute(
              fullscreenDialog: true,
              settings: settings,
              builder: (BuildContext context) => page,
            );
        }
      },
    );
  }
}

class CallNavigationArguments {
  final CallBloc callBloc;

  CallNavigationArguments({
    required this.callBloc,
  });
}
