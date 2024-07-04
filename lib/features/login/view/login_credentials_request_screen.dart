import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class LoginCredentialsRequestScreen extends StatelessWidget {
  const LoginCredentialsRequestScreen({
    super.key,
    required this.initialUrl,
  });

  final Uri initialUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          await AcknowledgeDialog.show(
            context,
            title: context.l10n.login_requestCredentials_DialogTitle,
            content: context.l10n.login_requestCredentials_DialogContent,
          );
        },
        child: const Icon(Icons.info_outline),
      ),
      body: WebViewScaffold(
        title: Text(context.l10n.login_requestCredentials_title),
        initialUri: initialUrl,
      ),
    );
  }
}
