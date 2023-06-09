import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/extensions/build_context.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import 'popup_menu.dart';

class CopyToClipboard extends StatelessWidget {
  const CopyToClipboard({
    super.key,
    this.data,
    required this.child,
  });

  final String? data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final data = this.data;
    if (data == null) {
      return child;
    } else {
      final themeData = Theme.of(context);
      return GestureDetector(
        onLongPressStart: (details) async {
          HapticFeedback.mediumImpact();
          final copy = await showMenu<bool>(
            context: context,
            position: RelativeRect.fromLTRB(details.globalPosition.dx, details.globalPosition.dy,
                details.globalPosition.dx, details.globalPosition.dy),
            items: [
              PopupMenuItem<bool>(
                enabled: false,
                labelTextStyle: MaterialStatePropertyAll(themeData.textTheme.bodyLarge),
                child: Text(data),
              ),
              PopupMenuItem<bool>(
                value: true,
                child: Text(context.l10n.copyToClipboard_popupMenuItem),
              )
            ],
          );
          if (context.mounted && copy == true) {
            context.showFloatingSnackBar(context.l10n.copyToClipboard_floatingSnackBar);
            Clipboard.setData(ClipboardData(text: data));
          }
        },
        child: child,
      );
    }
  }
}
