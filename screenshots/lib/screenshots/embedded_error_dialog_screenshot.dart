import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/login/features/login_signup/widgets/widgets.dart';

class EmbeddedErrorDialogScreenshot extends StatelessWidget {
  const EmbeddedErrorDialogScreenshot({super.key});

  @override
  Widget build(BuildContext context) {
    return EmbeddedRequestErrorDialog(
      title: 'No internet connection',
      error: 'Please check your connection and try again.',
      onRetry: () {},
      onBack: () {},
    );
  }
}
