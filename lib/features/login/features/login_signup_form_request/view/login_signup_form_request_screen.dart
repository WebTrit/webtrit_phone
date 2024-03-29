import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/settings/widgets/widgets.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class LoginSignupFormRequestScreenScreen extends StatelessWidget {
  const LoginSignupFormRequestScreenScreen({
    super.key,
    required this.initialUri,
  });

  final Uri initialUri;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await ConfirmDialog.showAlert(
            context,
            title: "Account Request",
            content:
                "Please provide basic information and specify in the message that you would like to receive an account. Our administrators will verify the information and send the account details to your email.",
          );
        },
        label: Icon(Icons.info_outline),
      ),
      body: WebViewScaffold(
        title: Text("Sign up"),
        initialUri: initialUri,
      ),
    );
  }
}
