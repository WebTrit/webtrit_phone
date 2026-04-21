import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

class FailureRetryView extends StatelessWidget {
  final VoidCallback onRetry;
  const FailureRetryView({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(context.l10n.webview_defaultError_title, textAlign: TextAlign.center),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: Text(context.l10n.voicemail_Label_retry)),
        ],
      ),
    );
  }
}
