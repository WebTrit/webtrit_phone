import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

import '../language_tab.dart';
import 'language_tab_scaffold.dart';

class LanguageTabScreen extends StatelessWidget {
  const LanguageTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LanguageTabBloc(
          accountInfoRepository: context.read<AccountInfoRepository>(),
        )..add(const LanguageTabStarted());
      },
      child: const LanguageTabScaffold(),
    );
  }
}
