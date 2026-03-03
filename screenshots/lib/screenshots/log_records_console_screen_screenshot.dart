import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/mocks/mocks.dart';

class LogRecordsConsoleScreenScreenshot extends StatefulWidget {
  const LogRecordsConsoleScreenScreenshot({super.key});

  @override
  State<LogRecordsConsoleScreenScreenshot> createState() => _LogRecordsConsoleScreenScreenshotState();
}

class _LogRecordsConsoleScreenScreenshotState extends State<LogRecordsConsoleScreenScreenshot> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (!mounted) return;

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, _) {
            return BlocProvider<LogRecordsConsoleCubit>(
              create: (_) => MockLogRecordsConsoleCubit.withRecords(),
              child: const LogRecordsConsoleScreen(),
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
