import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

import '../cubit/presence_settings_cubit.dart';
import 'presence_settings_screen.dart';

@RoutePage()
class PresenceSettingsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const PresenceSettingsScreenPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PresenceSettingsCubit(context.read<PresenceInfoRepository>()),
      child: const PresenceSettingsScreen(),
    );
  }
}
