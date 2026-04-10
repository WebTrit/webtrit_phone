import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/mocks/mocks.dart';

class CallerIdSettingsScreenScreenshot extends StatefulWidget {
  const CallerIdSettingsScreenScreenshot({super.key});

  @override
  State<CallerIdSettingsScreenScreenshot> createState() => _CallerIdSettingsScreenScreenshotState();
}

class _CallerIdSettingsScreenScreenshotState extends State<CallerIdSettingsScreenScreenshot> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (!mounted) return;

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, _) {
            return BlocProvider<CallerIdSettingsCubit>(
              create: (_) => MockCallerIdSettingsCubit.initial(),
              child: const CallerIdSettingsScreen(),
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
