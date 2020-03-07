import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/blocs/simple_bloc_delegate.dart';
import 'package:webtrit_phone/pages/register.dart';
import 'package:webtrit_phone/pages/main.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(App());
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
      routes: {
        '/register': (BuildContext context) => RegisterPage(),
        '/main': (BuildContext context) => MainPage(),
      },
    );
  }
}
