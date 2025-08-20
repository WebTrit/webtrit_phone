import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class SettingsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const SettingsScreenPage();

  @override
  Widget build(BuildContext context) {
    final settingsFeature = context.read<FeatureAccess>().settingsFeature;

    final widget = SettingsScreen(sections: settingsFeature.sections);

    final provider = BlocProvider(
      create: (context) {
        return SettingsBloc(
          notificationsBloc: context.read<NotificationsBloc>(),
          appBloc: context.read<AppBloc>(),
          userRepository: context.read<UserRepository>(),
          voicemailRepository: context.read<VoicemailRepository>(),
          sessionRepository: context.read(),
        );
      },
      child: widget,
    );
    return provider;
  }
}
