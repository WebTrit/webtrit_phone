import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

import '../help_tab.dart';
import 'help_tab_scaffold.dart';

class HelpTabScreen extends StatelessWidget {
  const HelpTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HelpTabBloc(
          accountInfoRepository: context.read<AccountInfoRepository>(),
        )..add(const HelpTabStarted());
      },
      child: const HelpTabScaffold(),
    );
  }
}
