import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/extensions/extensions.dart';

class EmbeddedRequestError extends StatelessWidget {
  const EmbeddedRequestError({
    super.key,
    required this.error,
    this.onPressed,
  });

  final WebResourceError error;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? styles = themeData.extension<ElevatedButtonStyles>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.wifi_off_rounded,
          size: 100,
          color: themeData.colorScheme.error,
        ),
        const SizedBox(height: kInset),
        Text(
          error.titleL10n(context),
          style: themeData.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          error.messageL10n(context),
          textAlign: TextAlign.center,
          style: themeData.textTheme.bodyMedium,
        ),
        const SizedBox(height: kInset),
        ElevatedButton(
          onPressed: onPressed,
          style: styles?.primary,
          child: Text(
            context.l10n.common_noInternetConnection_retryButton,
          ),
        ),
      ],
    );
  }
}
