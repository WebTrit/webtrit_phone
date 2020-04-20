import 'package:args/args.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/blocs/simple_bloc_delegate.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/pages/register.dart';
import 'package:webtrit_phone/pages/main.dart';
import 'package:webtrit_phone/pages/call.dart';

void main(List<String> args) {
  final argParser = ArgParser();
  argParser.addOption(
    'debug-level',
    allowed: List.from(Level.LEVELS.map((level) => level.name)),
    defaultsTo: 'INFO',
  );

  final argParserResults = argParser.parse(args);
  final debugLevelOption = argParserResults['debug-level'] as String;

  Logger.root.level = Level.LEVELS.firstWhere((level) => level.name == debugLevelOption);
  Logger.root.onRecord.listen((record) {
    print('${record.time} [${record.level.name}] ${record.loggerName}: ${record.message}');
  });

  BlocSupervisor.delegate = SimpleBlocDelegate();

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
          callRepository: context.repository<CallRepository>(),
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
                  callRepository: context.repository<CallRepository>(),
                  appBloc: BlocProvider.of<AppBloc>(context),
                )..add(RegistrationStarted());
              },
              child: RegisterPage(),
            );
            break;
          case '/main':
            page = MultiBlocProvider(
              providers: [
                BlocProvider<RecentsBloc>(
                  create: (BuildContext context) {
                    return RecentsBloc(
                      recentsRepository: context.repository<RecentsRepository>(),
                    )..add(RecentsInitialLoaded());
                  },
                ),
                BlocProvider<ContactsBloc>(
                  create: (BuildContext context) {
                    return ContactsBloc(
                      contactsRepository: context.repository<ContactsRepository>(),
                    )..add(ContactsInitialLoaded());
                  },
                ),
                BlocProvider<CallBloc>(
                  create: (BuildContext context) {
                    return CallBloc(
                      callRepository: context.repository<CallRepository>(),
                    );
                  },
                ),
              ],
              child: BlocListener<CallBloc, CallState>(
                listener: (context, state) {
                  if (state is CallIncoming) {
                    Navigator.pushNamed(context, '/main/call',
                        arguments: CallNavigationArguments(
                          callBloc: context.bloc<CallBloc>(),
                        ));
                  }
                  if (state is CallHangUp) {
                    Navigator.pop(context);
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
                  Navigator.pushReplacementNamed(context, '/register');
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
