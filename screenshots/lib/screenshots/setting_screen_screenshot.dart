import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/mocks/mocks.dart';

class SettingScreenScreenshot extends StatefulWidget {
  const SettingScreenScreenshot({
    super.key,
  });

  @override
  State<SettingScreenScreenshot> createState() => _SettingScreenScreenshotState();
}

class _SettingScreenScreenshotState extends State<SettingScreenScreenshot> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (!mounted) {
        return;
      }

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, __) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<CallBloc>(
                  create: (context) => MockCallBloc.settingsScreen(),
                ),
                BlocProvider<SettingsBloc>(
                  create: (context) => MockSettingsBloc.settingsScreen(),
                ),
              ],
              child: const SettingsScreen(),
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
