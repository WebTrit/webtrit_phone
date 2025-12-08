import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

class ConfirmDialog extends StatefulWidget {
  const ConfirmDialog({this.askText, this.confirmText, this.cancelText, super.key});

  final String? askText;
  final String? confirmText;
  final String? cancelText;

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  void onConfirm() {
    Navigator.of(context).pop(true);
  }

  void onCancel() {
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    final askText = widget.askText ?? context.l10n.messaging_ConfirmDialog_ask;
    final confirmText = widget.confirmText ?? context.l10n.messaging_ConfirmDialog_confirm;
    final cancelText = widget.cancelText ?? context.l10n.messaging_ConfirmDialog_cancel;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(askText, style: const TextStyle(fontSize: 18), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: onCancel, child: Text(cancelText)),
                  TextButton(onPressed: onConfirm, child: Text(confirmText)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
