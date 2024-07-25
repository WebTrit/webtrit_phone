import 'dart:ui';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatefulWidget {
  const ConfirmDialog({
    this.askText = 'Are you sure?',
    this.confirmText = 'Yes',
    this.cancelText = 'No',
    super.key,
  });

  final String askText;
  final String confirmText;
  final String cancelText;

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  onConfirm() {
    Navigator.of(context).pop(true);
  }

  onCancel() {
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.askText,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: onCancel, child: Text(widget.cancelText)),
                  TextButton(onPressed: onConfirm, child: Text(widget.confirmText)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
