import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

class SslAuthErrorView extends StatelessWidget {
  const SslAuthErrorView({super.key, required this.error, required this.onReload, this.failingUrl});

  final SslAuthError error;
  final VoidCallback onReload;
  final String? failingUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final url = failingUrl ?? '';

    return Container(
      color: theme.colorScheme.surface,
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.security_rounded, size: 56, color: theme.colorScheme.error),
              const SizedBox(height: 16),
              Text(context.l10n.webview_sslError_title, style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(
                context.l10n.webview_sslError_message,
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              if (url.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  url,
                  style: theme.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  FilledButton(onPressed: onReload, child: Text(context.l10n.webview_sslError_tryAgain)),
                  OutlinedButton(
                    onPressed: () => _showSslDetails(context, error),
                    child: Text(context.l10n.webview_sslError_details),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSslDetails(BuildContext context, SslAuthError error) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ListTile(title: Text(context.l10n.webview_sslError_details_type), subtitle: Text(error.toString())),
            if (failingUrl != null)
              ListTile(title: Text(context.l10n.webview_sslError_details_url), subtitle: Text(failingUrl!)),
          ],
        ),
      ),
    );
  }
}
