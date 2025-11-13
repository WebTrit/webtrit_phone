import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/repositories/account/user_repository.dart';
import 'package:webtrit_phone/repositories/caller_id_settings/caller_id_settings_repository.dart';

import '../caller_id.dart';

@RoutePage()
class CallerIdSettingsScreenPage extends StatelessWidget {
  const CallerIdSettingsScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CallerIdSettingsCubit(context.read<CallerIdSettingsRepository>(), context.read<UserRepository>())..init(),
      child: const CallerIdSettingsScreen(),
    );
  }
}
