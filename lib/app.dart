import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/blocs/simple_bloc_observer.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/pages/register.dart';
import 'package:webtrit_phone/pages/main.dart';
import 'package:webtrit_phone/pages/call.dart';
import 'package:webtrit_phone/pages/settings.dart';
import 'package:webtrit_phone/pages/web_registration.dart';
import 'package:webtrit_phone/environment_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait(
    [
      'assets/logo.svg',
    ].map(
      (assetName) => precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoder, assetName),
        null,
      ),
    ),
  );

  Logger.root.level = Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL);
  Logger.root.onRecord.listen((record) {
    print('${record.time} [${record.level.name}] ${record.loggerName}: ${record.message}');
  });

  Bloc.observer = SimpleBlocObserver();

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<CallRepository>(
        create: (context) => CallRepository(),
      ),
      RepositoryProvider<RecentsRepository>(
        create: (context) => RecentsRepository(),
      ),
      RepositoryProvider<ContactsRepository>(
        create: (context) => ContactsRepository(
          callRepository: context.read<CallRepository>(),
          periodicPolling: EnvironmentConfig.PERIODIC_POLLING,
        ),
      ),
    ],
    child: BlocProvider<AppBloc>(
      create: (context) {
        return AppBloc();
      },
      child: App(
        webRegistrationInitialUrl: await SecureStorage.readWebRegistrationInitialUrl(),
        isRegistered: await SecureStorage.readToken() != null,
      ),
    ),
  ));
}

class App extends StatelessWidget {
  App({
    Key key,
    @required this.webRegistrationInitialUrl,
    @required this.isRegistered,
  }) : super(key: key);

  final String webRegistrationInitialUrl;
  final bool isRegistered;

  String _initialRoute(String webRegistrationInitialUrl, bool isRegistered) =>
      webRegistrationInitialUrl == null || isRegistered ? '/register' : '/web-registration';

  @override
  Widget build(BuildContext context) {
    setDefaultOrientations();

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'WebTrit Phone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: _initialRoute(webRegistrationInitialUrl, isRegistered),
      builder: (BuildContext context, Widget child) {
        final themeData = Theme.of(context);
        return Theme(
          data: themeData.copyWith(
            appBarTheme: AppBarTheme(
              brightness: Brightness.light,
              color: themeData.canvasColor,
              iconTheme: IconThemeData(
                color: themeData.textTheme.caption.color,
              ),
              actionsIconTheme: IconThemeData(
                color: themeData.textTheme.caption.color,
              ),
              textTheme: themeData.primaryTextTheme.copyWith(
                headline6: themeData.primaryTextTheme.headline6.copyWith(
                  color: themeData.accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: false,
            ),
          ),
          child: child,
        );
      },
      onGenerateRoute: (RouteSettings settings) {
        Widget page;
        switch (settings.name) {
          case '/web-registration':
            page = WebRegistrationPage(
              initialUrl: settings.arguments != null ? settings.arguments as String : webRegistrationInitialUrl,
            );
            break;
          case '/register':
            page = BlocProvider(
              create: (context) {
                return RegistrationBloc(
                  callRepository: context.read<CallRepository>(),
                  appBloc: context.read<AppBloc>(),
                )..add(RegistrationStarted());
              },
              child: RegisterPage(),
            );
            break;
          case '/main':
            page = MultiBlocProvider(
              providers: [
                BlocProvider<RecentsBloc>(
                  create: (context) {
                    return RecentsBloc(
                      recentsRepository: context.read<RecentsRepository>(),
                    )..add(RecentsInitialLoaded());
                  },
                ),
                BlocProvider<ContactsBloc>(
                  create: (context) {
                    return ContactsBloc(
                      contactsRepository: context.read<ContactsRepository>(),
                    )..add(ContactsInitialLoaded());
                  },
                ),
                BlocProvider<CallBloc>(
                  create: (context) {
                    return CallBloc(
                      callRepository: context.read<CallRepository>(),
                      recentsBloc: context.read<RecentsBloc>(),
                    );
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
                  if (state is CallIdle) {
                    setDefaultOrientations().then((_) {
                      Navigator.pop(context);
                    });
                  }
                },
                child: MainPage(),
              ),
            );
            break;
          case '/main/call':
            final callNavigationArguments = settings.arguments as CallNavigationArguments;
            page = BlocProvider<CallBloc>.value(
              value: callNavigationArguments.callBloc,
              child: CallPage(),
            );
            break;
          case '/main/settings':
            page = SettingsPage();
            break;
          default:
            return null;
        }

        page = BlocListener<AppBloc, AppState>(
          listener: (context, state) async {
            if (state is AppRegister) {
              Navigator.pushReplacementNamed(context, '/main');
            }
            if (state is AppUnregister) {
              final webRegistrationInitialUrl = await SecureStorage.readWebRegistrationInitialUrl();
              final isRegistered = await SecureStorage.readToken() != null;

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
                final PageTransitionsBuilder builder = ZoomPageTransitionsBuilder();
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

Future<void> setDefaultOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

Future<void> setCallOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

class CallNavigationArguments {
  final CallBloc callBloc;

  CallNavigationArguments({
    @required this.callBloc,
  }) : assert(callBloc != null);
}
