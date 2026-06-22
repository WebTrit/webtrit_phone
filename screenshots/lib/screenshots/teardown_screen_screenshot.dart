import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

/// Preview-only stand-in for the teardown screen.
///
/// The real `TeardownScreen.initState` calls `WebtritSignalingService.stopService()`,
/// which reaches `SignalingServicePlatform.instance` and throws synchronously when the
/// native platform is not initialized (as in the configurator preview / web harness).
/// The screenshot only needs the visual, so render the same layout here without the
/// side effects instead of mounting the real screen.
class TeardownScreenScreenshot extends StatelessWidget {
  const TeardownScreenScreenshot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(context.l10n.session_Teardown_progressText),
          ],
        ),
      ),
    );
  }
}
