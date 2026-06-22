import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/session_status/view/teardown_screen.dart';

import 'package:screenshots/mocks/mocks.dart';

/// Renders the real [TeardownScreen] so the preview stays in sync with the app.
///
/// `TeardownScreen.initState` calls `WebtritSignalingService.stopService()`, which
/// reaches `SignalingServicePlatform.instance` and throws synchronously when the
/// native platform is not initialized (the configurator preview / web harness).
/// Register a no-op platform before the real screen mounts instead of copying its
/// UI, which would drift from the actual screen over time.
class TeardownScreenScreenshot extends StatefulWidget {
  const TeardownScreenScreenshot({super.key});

  @override
  State<TeardownScreenScreenshot> createState() => _TeardownScreenScreenshotState();
}

class _TeardownScreenScreenshotState extends State<TeardownScreenScreenshot> {
  @override
  void initState() {
    super.initState();
    // Runs before the child TeardownScreen mounts, so its initState side effect
    // has a platform to call into.
    ensureMockSignalingServicePlatform();
  }

  @override
  Widget build(BuildContext context) {
    return const TeardownScreen();
  }
}
