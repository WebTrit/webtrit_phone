import 'package:flutter/material.dart';

class ExtBackButton extends StatelessWidget {
  const ExtBackButton({
    super.key,
    this.disabled = false,
  });

  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
      ),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: disabled ? null : () => Navigator.maybePop(context),
    );
  }
}
