import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

class ExtBackButton extends StatelessWidget {
  const ExtBackButton({super.key, this.disabled = false});

  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return AutoLeadingButton(
      builder: (context, leadingType, action) {
        switch (leadingType) {
          case LeadingType.back:
            return IconButton(
              icon: const BackButtonIcon(),
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onPressed: disabled ? null : action,
            );
          case LeadingType.close:
            return IconButton(
              icon: const BackButtonIcon(),
              tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
              onPressed: disabled ? null : action,
            );
          case LeadingType.drawer:
            return IconButton(
              icon: const BackButtonIcon(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              onPressed: disabled ? null : action,
            );
          case LeadingType.noLeading:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
