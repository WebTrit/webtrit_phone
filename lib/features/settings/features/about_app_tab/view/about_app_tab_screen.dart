import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

import '../about_app_tab.dart';
import 'about_app_tab_scaffold.dart';

class AboutAppTabScreen extends StatelessWidget {
  const AboutAppTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AboutAppTabBloc(
          accountInfoRepository: context.read<AccountInfoRepository>(),
        )..add(const AboutAppTabStarted());
      },
      child: const AboutAppTabScaffold(),
    );
  }
}
