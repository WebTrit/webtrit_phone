import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final notificationsBloc = context.read<NotificationsBloc>();
    const widget = SettingsScreen();
    final provider = BlocProvider(
      create: (context) {
        return SettingsBloc(
          appBloc: context.read<AppBloc>(),
          userRepository: context.read<UserRepository>(),
          appRepository: context.read<AppRepository>(),
          appPreferences: context.read<AppPreferences>(),
          onNotification: (n) => notificationsBloc.add(NotificationsIssued(n)),
        )..add(const SettingsRefreshed());
      },
      child: widget,
    );
    return provider;
  }
}
