import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

/// A common fallback widget for WebView errors when no custom [errorBuilder] is provided.
class DefaultWebViewErrorView extends StatelessWidget {
  const DefaultWebViewErrorView({super.key, required this.error, required this.onReload});

  final WebResourceError error;
  final VoidCallback onReload;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              context.l10n.webview_defaultError_title,
              style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.webview_defaultError_details(error.description, error.errorCode),
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onReload,
              icon: const Icon(Icons.refresh),
              label: Text(context.l10n.webview_defaultError_reload),
            ),
          ],
        ),
      ),
    );
  }
}
