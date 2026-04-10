import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/mocks/mocks.dart';

class PresenceSettingsScreenScreenshot extends StatefulWidget {
  const PresenceSettingsScreenScreenshot({super.key});

  @override
  State<PresenceSettingsScreenScreenshot> createState() => _PresenceSettingsScreenScreenshotState();
}

class _PresenceSettingsScreenScreenshotState extends State<PresenceSettingsScreenScreenshot> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (!mounted) return;

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, _) {
            return BlocProvider<PresenceSettingsCubit>(
              create: (_) => MockPresenceSettingsCubit.initial(),
              child: const PresenceSettingsScreen(),
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
