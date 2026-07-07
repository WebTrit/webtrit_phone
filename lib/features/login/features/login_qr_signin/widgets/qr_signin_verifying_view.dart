import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

/// The in-progress state of the QR sign-in tab: a scanned code is being
/// verified with the server.
class QrSigninVerifyingView extends StatelessWidget {
  const QrSigninVerifyingView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Center(child: CircularProgressIndicator()),
        const SizedBox(height: kInset),
        Text(
          context.l10n.login_Text_qrSigninVerifyingTitle,
          textAlign: TextAlign.center,
          style: themeData.textTheme.titleLarge,
        ),
        const SizedBox(height: kInset / 2),
        Text(
          context.l10n.login_Text_qrSigninVerifyingDescription,
          textAlign: TextAlign.center,
          style: themeData.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
