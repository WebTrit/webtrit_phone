import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'list_tile_separator.dart';

class AccountActionsTile extends StatelessWidget {
  const AccountActionsTile({
    super.key,
    required this.sessionsCount,
    required this.onLogoutTap,
    required this.onSessionsTap,
    this.logoutIconColor,
    this.sessionsIconColor,
    this.textStyle,
    this.showSeparator = true,
    this.separatorColor,
  });

  /// Number of active sessions, or `null` when the backend cannot list them -
  /// then logout takes the whole row. `0` means "not loaded yet" and shows no
  /// badge.
  final int? sessionsCount;

  final VoidCallback onLogoutTap;
  final VoidCallback onSessionsTap;
  final Color? logoutIconColor;
  final Color? sessionsIconColor;
  final TextStyle? textStyle;
  final bool showSeparator;
  final Color? separatorColor;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final sessionsCount = this.sessionsCount;
    final showSessions = sessionsCount != null;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final row = showSessions == false
        ? InkWell(
            // The Patrol logout subsequence taps this key.
            key: settingsLogoutButtonKey,
            onTap: onLogoutTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Icon(Icons.logout, color: logoutIconColor),
                  const SizedBox(width: 16),
                  Text(l10n.settings_ListViewTileTitle_logout, style: textStyle, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (showSessions) ...[
                  Flexible(
                    child: InkWell(
                      onTap: onSessionsTap,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Row(
                          children: [
                            Icon(Icons.devices),
                            SizedBox(width: 16),
                            Text(
                              l10n.settings_ListViewTileTitle_sessions,
                              style: textStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: 16),
                            // The badge is silent by itself; the row it merges
                            // into speaks the count after its own name.
                            if (sessionsCount > 0)
                              Semantics(
                                value: l10n.common_SemanticsValue_totalCount(sessionsCount),
                                child: CountBadge(count: sessionsCount),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(width: 1, thickness: 1, indent: 8, endIndent: 8, color: separatorColor),
                ],
                SizedBox(width: 16),
                TextButton(
                  // The Patrol logout subsequence taps this key; it has to be on
                  // whichever branch renders, not just the sessions-less one.
                  key: settingsLogoutButtonKey,
                  onPressed: onLogoutTap,
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.onPrimary,
                    backgroundColor: colorScheme.primary,
                  ),
                  child: Text(l10n.settings_ListViewTileTitle_logout),
                ),
                SizedBox(width: 16),
              ],
            ),
          );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IntrinsicHeight(child: row),
        if (showSeparator) ListTileSeparator(color: separatorColor),
      ],
    );
  }
}
