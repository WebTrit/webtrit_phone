import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

const _kHoldSpaceData = ' ';

class AccountInfoListTile extends StatelessWidget {
  const AccountInfoListTile({
    Key? key,
    required this.callStatus,
    this.info,
    this.onEditPressed,
    this.contentPadding,
  }) : super(key: key);

  final CallStatus callStatus;
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
                  Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          child: Container(
                            width: radius / 3,
                            height: radius / 3,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: callStatus.color(context),
                            ),
                          ),
                          alignment: PlaceholderAlignment.middle,
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(text: callStatus.l10n(context)),
                      ],
                    ),
                  ),
                  CopyToClipboard(
                    data: info?.name,
                    child: Text(
                      info?.name ?? _kHoldSpaceData,
                      style: themeData.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CopyToClipboard(
                    data: info?.login,
                    child: Text(
                      info?.numberWithExtension ?? _kHoldSpaceData,
                      style: themeData.textTheme.bodyLarge,
                    ),
                  ),
                  Text(
                    info?.balanceWithCurrency ?? _kHoldSpaceData,
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
