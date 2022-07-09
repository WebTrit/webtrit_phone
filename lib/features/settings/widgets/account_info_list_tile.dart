import 'package:flutter/material.dart';

import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_phone/extensions/extensions.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

class AccountInfoListTile extends StatelessWidget {
  const AccountInfoListTile({
    Key? key,
    this.info,
    this.onEditPressed,
    this.contentPadding,
  }) : super(key: key);

  final AccountInfo? info;
  final VoidCallback? onEditPressed;

  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final info = this.info;

    final themeData = Theme.of(context);
    final ListTileThemeData tileTheme = ListTileTheme.of(context);

    const EdgeInsets defaultContentPadding = EdgeInsets.symmetric(horizontal: 16.0);
    final TextDirection textDirection = Directionality.of(context);
    final EdgeInsets resolvedContentPadding = contentPadding?.resolve(textDirection) ??
        tileTheme.contentPadding?.resolve(textDirection) ??
        defaultContentPadding;

    const radius = 32.0;

    return Ink(
      height: radius * 3,
      child: SafeArea(
        top: false,
        bottom: false,
        minimum: resolvedContentPadding,
        child: Row(
          children: [
            LeadingAvatar(
              username: info?.name ?? '?',
              radius: radius,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    info?.name ?? '',
                    style: themeData.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    info?.balanceWithCurrency ?? '',
                    style: themeData.textTheme.labelLarge,
                  ),
                ],
              ),
            ),
            if (onEditPressed != null)
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: onEditPressed,
              )
          ],
        ),
      ),
    );
  }
}
