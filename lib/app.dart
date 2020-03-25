import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/simple_bloc_delegate.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/pages/register.dart';
import 'package:webtrit_phone/pages/main.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(BlocProvider<AppBloc>(
    create: (context) {
      return AppBloc();
    },
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            page = RegisterPage();
            break;
          case '/main':
            page = MainPage();
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
