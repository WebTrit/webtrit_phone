import 'dart:typed_data';

import 'package:flutter/material.dart';

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
    final presenceSource = PresenceViewParams.of(context).viewSource;

    final title = switch (presenceSource) {
      PresenceViewSource.sipPresence => '$displayName ${presenceInfo?.primaryStatusIcon ?? ''}',
      PresenceViewSource.contactInfo => displayName,
    };

    final subtitle = switch (presenceSource) {
      PresenceViewSource.sipPresence => presenceInfo?.primaryNote,
      PresenceViewSource.contactInfo => null,
    };

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
      subtitle: subtitle?.isNotEmpty == true
          ? Text(subtitle!, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12))
          : null,
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
