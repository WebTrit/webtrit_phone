import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/simple_bloc_delegate.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/pages/register.dart';
import 'package:webtrit_phone/pages/main.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<RecentsRepository>(
        create: (context) => RecentsRepository(),
      ),
      RepositoryProvider<ContactsRepository>(
        create: (context) => ContactsRepository(),
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
              ],
              child: MainPage(),
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
