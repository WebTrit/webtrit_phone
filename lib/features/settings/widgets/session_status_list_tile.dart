import 'package:flutter/material.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';

class SessionStatusListTile extends StatelessWidget {
  const SessionStatusListTile({
    super.key,
    required this.status,
    this.info,
    this.onTap,
    this.contentPadding,
  });

  final CallStatus status;
  final UserInfo? info;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ListTile(
      onTap: onTap,
      contentPadding: contentPadding,
      leading: CircleAvatar(
        radius: 12,
        backgroundColor: themeData.colorScheme.surface.withOpacity(0.5),
        child: CircleAvatar(
          radius: 4,
          backgroundColor: status.color(context),
        ),
      ),
      title: Text(
        status.l10n(context),
        style: themeData.textTheme.labelLarge,
      ),
    );
  }
}
