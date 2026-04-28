import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    required this.displayName,
    this.thumbnail,
    this.thumbnailUrl,
    this.registered,
    this.smart = false,
    this.onTap,
    this.onLongPress,
    this.onMessagePressed,
    this.presenceInfo,
    this.dialogInfo,
  });

  final String displayName;
  final Uint8List? thumbnail;
  final Uri? thumbnailUrl;
  final bool? registered;
  final bool smart;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final GestureTapCallback? onMessagePressed;
  final List<PresenceInfo>? presenceInfo;
  final List<DialogInfo>? dialogInfo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final contentColor = colorScheme.onSurface;

    final presenceParams = PresenceViewParams.of(context);

    final title = switch (presenceParams.hybridPresenceSupport) {
      true => '$displayName ${presenceInfo?.primaryStatusIcon ?? ''}',
      false => displayName,
    };

    Widget? subtitle;

    if (presenceParams.blfViaSipSupport && (dialogInfo ?? []).isNotEmpty) {
      final dialog = dialogInfo!.first;

      String? destination;
      if (dialog.remoteDisplayName != null && dialog.remoteNumber != null) {
        destination = '${dialog.remoteDisplayName} <${dialog.remoteNumber}>';
      } else if (dialog.remoteDisplayName != null) {
        destination = dialog.remoteDisplayName!;
      } else if (dialog.remoteNumber != null) {
        destination = dialog.remoteNumber!;
      }

      if (destination != null) {
        subtitle = Text(
          context.l10n.contacts_ContactTile_inCall(destination),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: contentColor.withValues(alpha: 0.7)),
        );
      }
    }

    final presenceNote = (presenceInfo ?? []).primaryNote;

    if (subtitle == null && presenceParams.hybridPresenceSupport && presenceNote != null && presenceNote.isNotEmpty) {
      subtitle = Text(
        presenceNote,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall,
      );
    }

    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16.0),
      leading: LeadingAvatar(
        username: displayName,
        thumbnail: thumbnail,
        thumbnailUrl: thumbnailUrl,
        registered: registered,
        smart: smart,
        presenceInfo: presenceInfo,
        dialogInfo: dialogInfo,
      ),
      title: Text(title),
      subtitle: subtitle,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onMessagePressed != null)
            IconButton(splashRadius: 24, icon: const Icon(Icons.messenger_outline), onPressed: onMessagePressed),
        ],
      ),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
