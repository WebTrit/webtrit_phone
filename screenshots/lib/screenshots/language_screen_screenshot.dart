import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:webtrit_phone/features/features.dart';

class LanguageScreenScreenshot extends StatefulWidget {
  const LanguageScreenScreenshot({super.key});

  @override
  State<LanguageScreenScreenshot> createState() => _LanguageScreenScreenshotState();
}

class _LanguageScreenScreenshotState extends State<LanguageScreenScreenshot> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (!mounted) return;

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, _) {
            return const LanguageScreen();
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
