import 'package:args/args.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/blocs/simple_bloc_observer.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/pages/register.dart';
import 'package:webtrit_phone/pages/main.dart';
import 'package:webtrit_phone/pages/call.dart';
import 'package:webtrit_phone/pages/settings.dart';

void main(List<String> args) {
  final argParser = ArgParser();
  argParser.addOption(
    'debug-level',
    allowed: List.from(Level.LEVELS.map((level) => level.name)),
    defaultsTo: 'INFO',
  );
  argParser.addFlag(
    'periodic-polling',
    defaultsTo: true,
  );

  final argParserResults = argParser.parse(args);
  final debugLevelOption = argParserResults['debug-level'] as String;
  final periodicPollingFlag = argParserResults['periodic-polling'] as bool;

  Logger.root.level = Level.LEVELS.firstWhere((level) => level.name == debugLevelOption);
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
          periodicPolling: periodicPollingFlag,
        ),
      ),
    ],
    child: BlocProvider<AppBloc>(
      create: (context) {
        return AppBloc();
      },
      child: App(),
    ),
  ));
}

class App extends StatelessWidget {
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
      initialRoute: '/register',
      onGenerateRoute: (RouteSettings settings) {
        Widget page;
        switch (settings.name) {
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
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return BlocListener<AppBloc, AppState>(
              listener: (context, state) {
                if (state is AppRegister) {
                  Navigator.pushReplacementNamed(context, '/main');
                }
                if (state is AppUnregister) {
                  Navigator.pushNamedAndRemoveUntil(context, '/register', (route) => false);
                }
              },
              child: page,
            );
          },
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            final PageTransitionsBuilder builder = ZoomPageTransitionsBuilder();
            return builder.buildTransitions(null, context, animation, secondaryAnimation, child);
          },
        );
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
