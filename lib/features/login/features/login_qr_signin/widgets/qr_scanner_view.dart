import 'package:flutter/material.dart';

import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/qr_signin_uri_parser.dart';

/// The scanning state of the QR sign-in tab: hint text, camera viewfinder and
/// an inline line for the last rejection reason.
class QrScannerView extends StatelessWidget {
  const QrScannerView({super.key, required this.controller, required this.onDetect, this.parseError});

  final MobileScannerController controller;
  final ValueChanged<BarcodeCapture> onDetect;
  final QrSigninParseError? parseError;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.l10n.login_Text_qrSigninScanHint,
          textAlign: TextAlign.center,
          style: themeData.textTheme.bodyLarge,
        ),
        const SizedBox(height: kInset),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320, maxHeight: 320),
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kInset),
                // The neutral backdrop keeps the viewfinder shape visible while
                // the camera initializes (the preview flickers in otherwise).
                child: ColoredBox(
                  color: themeData.colorScheme.surfaceContainerHighest,
                  child: MobileScanner(
                    controller: controller,
                    onDetect: onDetect,
                    placeholderBuilder: (context) => const SizedBox.expand(),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: kInset / 2),
        // Reserve the line so the layout does not jump when an error appears.
        Text(
          parseError != null ? context.l10n.login_Text_qrSigninInvalidCodeError : '',
          textAlign: TextAlign.center,
          style: themeData.textTheme.bodyMedium?.copyWith(color: themeData.colorScheme.error),
        ),
      ],
    );
  }
}
