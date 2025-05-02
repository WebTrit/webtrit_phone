import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/repositories/account/user_repository.dart';

import '../caller_id.dart';

@RoutePage()
class CallerIDSettingsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CallerIDSettingsScreenPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CallerIDSettingsCubit(
        context.read<UserRepository>(),
        context.read<AppPreferences>(),
      ),
      child: const CallerIDSettingsScreen(),
    );
  }
}
