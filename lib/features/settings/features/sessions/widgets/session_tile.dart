import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:webtrit_api/webtrit_api.dart' show AppType;

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class SessionTile extends StatelessWidget {
  const SessionTile({
    super.key,
    required this.session,
    required this.dateFormat,
    required this.revoking,
    required this.onRevoke,
  });

  final ActiveSession session;
  final DateFormat dateFormat;
  final bool revoking;
  final ValueChanged<ActiveSession> onRevoke;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;

    final details = [
      if (session.lastActivityAt != null) l10n.sessions_Tile_lastActivity(dateFormat.format(session.lastActivityAt!)),
      if (session.createdAt != null) l10n.sessions_Tile_created(dateFormat.format(session.createdAt!)),
      if (session.lastActivityLocation != null) session.lastActivityLocation!,
      if (session.userAgent != null) session.userAgent!,
      if (session.appBundleId != null) session.appBundleId!,
    ];

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: colorScheme.onSurface.withAlpha(25), blurRadius: 60, offset: Offset(4, 4))],
      ),
      margin: .symmetric(vertical: 8, horizontal: 16),

      child: Container(
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: colorScheme.primary, width: 2)),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: .symmetric(vertical: 8, horizontal: 8),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              mainAxisSize: .min,
              children: [
                if (session.current) Text(l10n.sessions_Tile_currentSession) else Text(_titleOf(l10n, session.appType)),
                SizedBox(width: 8),
                Icon(_iconOf(session.appType), size: 18),
              ],
            ),
            for (final detail in details) Text(detail, style: themeData.textTheme.bodySmall),
            SizedBox(height: 4),
            // Signing THIS device out is what logout in settings is for, so the
            // current session is listed but not revocable from here.
            if (!session.current)
              SizedBox(
                height: 24,
                child: TextButton.icon(
                  icon: revoking ? const SizedCircularProgressIndicator(size: 20, strokeWidth: 2) : null,
                  label: Text(l10n.sessions_Tile_revokeTooltip),
                  onPressed: revoking ? null : () => onRevoke(session),
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.onPrimary,
                    backgroundColor: colorScheme.primary,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    minimumSize: Size(100, 16),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _titleOf(AppLocalizations l10n, AppType? appType) {
    return switch (appType) {
      AppType.ios => l10n.sessions_AppType_ios,
      AppType.android || AppType.androidHms => l10n.sessions_AppType_android,
      AppType.web => l10n.sessions_AppType_web,
      AppType.linux => l10n.sessions_AppType_linux,
      AppType.macos => l10n.sessions_AppType_macos,
      AppType.windows => l10n.sessions_AppType_windows,
      AppType.smart => l10n.sessions_AppType_smart,
      null => l10n.sessions_AppType_unknown,
    };
  }

  IconData _iconOf(AppType? appType) {
    return switch (appType) {
      AppType.ios || AppType.android || AppType.androidHms || AppType.smart => Icons.smartphone,
      AppType.web => Icons.language,
      AppType.linux || AppType.macos || AppType.windows => Icons.desktop_windows,
      null => Icons.devices_other,
    };
  }
}
