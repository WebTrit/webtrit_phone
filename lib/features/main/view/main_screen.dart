import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

import '../main.dart';
import 'main_scaffold.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MainBloc(
          accountInfoRepository: context.read<AccountInfoRepository>(),
        )..add(const MainStarted());
      },
      child: const MainScaffold(),
    );
  }

}
