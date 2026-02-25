import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/mocks/mocks.dart';

class SystemNotificationsScreenScreenshot extends StatefulWidget {
  const SystemNotificationsScreenScreenshot({super.key});

  @override
  State<SystemNotificationsScreenScreenshot> createState() => _SystemNotificationsScreenScreenshotState();
}

class _SystemNotificationsScreenScreenshotState extends State<SystemNotificationsScreenScreenshot> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (!mounted) return;

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, __) {
            return BlocProvider<SystemNotificationsScreenCubit>(
              create: (_) => MockSystemNotificationsScreenCubit.withNotifications(),
              child: const SystemNotificationsScreen(),
            );
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          fullscreenDialog: true,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
