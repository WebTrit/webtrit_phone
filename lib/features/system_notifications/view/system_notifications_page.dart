import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

import '../system_notifications.dart';

@RoutePage()
class SystemNotificationsPage extends StatelessWidget {
  const SystemNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SystemNotificationsScreenCubit(
        context.read<SystemNotificationsLocalRepository>(),
        context.read<SystemNotificationsRemoteRepository>(),
      )..init(),
      child: const SystemNotificationsScreen(),
    );
  }
}
