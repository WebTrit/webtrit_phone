import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../settings.dart';
import 'settings_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SettingsBloc(
          appBloc: context.read<AppBloc>(),
          accountRepository: context.read<AccountRepository>(),
          appRepository: context.read<AppRepository>(),
          appPreferences: AppPreferences(),
        )..add(const SettingsStarted());
      },
      child: const SettingsScaffold(),
    );
  }
}
