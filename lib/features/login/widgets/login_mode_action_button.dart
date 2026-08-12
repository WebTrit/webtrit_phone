import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class LoginModeActionButton extends StatelessWidget {
  const LoginModeActionButton({
    super.key,
    required this.processing,
    required this.isDemoModeEnabled,
    required this.onPressed,
    required this.style,
    required this.title,
  });

  final bool processing;
  final bool isDemoModeEnabled;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: processing ? null : onPressed,
      style: style,
      child: !processing
          ? Text(title)
          : SizedCircularProgressIndicator(
              size: 16,
              strokeWidth: 2,
              color: style?.foregroundColor?.resolve({}),
              semanticsLabel: context.l10n.common_SemanticsLabel_loading,
            ),
    );
  }
}
