import 'package:flutter/material.dart';

class ExtBackButton extends StatelessWidget {
  const ExtBackButton({
    Key? key,
    this.disabled = false,
    this.color,
  }) : super(key: key);

  final bool disabled;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color,
      icon: const Icon(
        Icons.arrow_back,
      ),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: disabled ? null : () => Navigator.maybePop(context),
    );
  }
}
