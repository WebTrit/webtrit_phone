import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

import '../network_settings_tab.dart';
import 'network_settings_tab_scaffold.dart';

class NetworkSettingsTabScreen extends StatelessWidget {
  const NetworkSettingsTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return NetworkSettingsTabBloc(
          accountInfoRepository: context.read<AccountInfoRepository>(),
        )..add(const NetworkSettingsTabStarted());
      },
      child: const NetworkSettingsTabScaffold(),
    );
  }
}
