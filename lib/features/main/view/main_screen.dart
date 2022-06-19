import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../main.dart';
import 'main_scaffold.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MainBloc()..add(const MainStarted());
      },
      child: const MainScaffold(),
    );
  }
}
