import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class ExtBackButton extends StatelessWidget {
  const ExtBackButton({
    Key? key,
    this.disabled = false,
  }) : super(key: key);

  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
      ),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: disabled ? null : () => GoRouter.of(context).pop(context),
    );
  }
}
