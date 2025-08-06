import 'package:flutter/material.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class UserInfoListTile extends StatelessWidget {
  const UserInfoListTile({
    super.key,
    this.info,
    this.onEditPressed,
    this.contentPadding,
  });

  final UserInfo? info;
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
      child: SafeArea(
        top: false,
        bottom: false,
        minimum: resolvedContentPadding,
        child: Row(
          children: [
            LeadingAvatar(
              username: info?.name ?? info?.numbers.main,
              thumbnailUrl: gravatarThumbnailUrl(info?.email),
              radius: radius,
              showLoading: true,
              loadingPadding: EdgeInsets.zero,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (info != null) ...[
                    if (info.name != null)
                      CopyToClipboard(
                        data: info.name,
                        child: Text(
                          info.name!,
                          style: themeData.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    if (info.numbers.main.isNotEmpty)
                      CopyToClipboard(
                        data: info.numbers.main,
                        child: Text(
                          info.numberWithExtension,
                          style: themeData.textTheme.bodyLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    if (info.balanceWithCurrency?.isNotEmpty == true)
                      Text(
                        info.balanceWithCurrency!,
                        style: themeData.textTheme.labelLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
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
