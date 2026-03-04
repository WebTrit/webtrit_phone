import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/constants.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import 'embedded_request_error_style.dart';
import 'embedded_request_error_styles.dart';

export 'embedded_request_error_style.dart';
export 'embedded_request_error_styles.dart';

class EmbeddedRequestErrorDialog extends StatelessWidget {
  const EmbeddedRequestErrorDialog({
    super.key,
    required this.title,
    required this.error,
    required this.onRetry,
    this.onBack,
  });

  final String title;
  final String error;
  final VoidCallback onRetry;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final EmbeddedRequestErrorStyle? logo = theme.extension<EmbeddedRequestErrorStyles>()?.primary;

    final appBar = onBack != null
        ? AppBar(
            automaticallyImplyLeading: onBack != null,
            leading: BackButton(onPressed: onBack),
            elevation: 0,
          )
        : null;

    // canPop: true — allows the system back button to bubble up to the parent PopScope.
    //
    // This widget is used in two modes:
    //   Mode A (inline errorBuilder): embedded inside EmbeddedScreen or LoginSignupEmbeddedRequestScreen
    //     as a WebView replacement. The parent PopScope correctly handles back navigation
    //     (e.g. goBack in WebView or exit the screen). canPop: false here would wrongly block it.
    //   Mode B (pushed route via BlocListener): pushed on top of LoginSignupEmbeddedRequestScreen.
    //     onBack is non-null when the error allows going back (RequestFailure). The
    //     onPopInvokedWithResult callback ensures onBack() is called on system back, so that
    //     _errorDialogShown is properly reset in the parent screen.
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) onBack?.call();
      },
      child: Scaffold(
        appBar: appBar,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (logo?.picture != null) logo!.picture!.svg(),
                Text(
                  title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  error,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: kInset),
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: Text(context.l10n.common_noInternetConnection_retryButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
