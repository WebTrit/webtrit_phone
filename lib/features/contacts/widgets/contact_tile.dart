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
    this.expanded = false,
    this.onDialPressed,
    this.presenceInfo,
    this.dialogInfo,
    this.callNumbers = const [],
    this.onAudioCallPressed,
    this.onVideoCallPressed,
    this.onTransferPressed,
    this.onChatPressed,
    this.onSendSmsPressed,
    this.onViewContactPressed,
    this.onCallLogPressed,
    this.onCallFrom,
    this.copyNumber,
  });

  final String displayName;
  final Uint8List? thumbnail;
  final Uri? thumbnailUrl;
  final bool? registered;
  final bool smart;
  final GestureTapCallback? onTap;
  final bool expanded;
  final VoidCallback? onDialPressed;
  final List<PresenceInfo>? presenceInfo;
  final List<DialogInfo>? dialogInfo;

  final List<String> callNumbers;
  final VoidCallback? onAudioCallPressed;
  final VoidCallback? onVideoCallPressed;
  final VoidCallback? onTransferPressed;
  final VoidCallback? onChatPressed;
  final VoidCallback? onSendSmsPressed;
  final VoidCallback? onViewContactPressed;
  final VoidCallback? onCallLogPressed;
  final void Function(String)? onCallFrom;
  final String? copyNumber;

  @override
  Widget build(BuildContext context) {
    final presenceParams = PresenceViewParams.of(context);

    final title = switch (presenceParams.hybridPresenceSupport) {
      true => '$displayName ${presenceInfo?.primaryStatusIcon ?? ''}',
      false => displayName,
    };

    String? subName;

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
        subName = context.l10n.contacts_ContactTile_inCall(destination);
      }
    }

    final presenceNote = (presenceInfo ?? []).primaryNote;

    if (subName == null && presenceParams.hybridPresenceSupport && presenceNote != null && presenceNote.isNotEmpty) {
      subName = presenceNote;
    }

    return CallTile(
      leading: LeadingAvatar(
        username: displayName,
        thumbnail: thumbnail,
        thumbnailUrl: thumbnailUrl,
        registered: registered,
        smart: smart,
        presenceInfo: presenceInfo,
        dialogInfo: dialogInfo,
      ),
      name: title,
      subName: subName,
      onTap: onTap,
      expanded: expanded,
      onDialPressed: onDialPressed,
      callNumbers: callNumbers,
      onAudioCallPressed: onAudioCallPressed,
      onVideoCallPressed: onVideoCallPressed,
      onTransferPressed: onTransferPressed,
      onChatPressed: onChatPressed,
      onSendSmsPressed: onSendSmsPressed,
      onViewContactPressed: onViewContactPressed,
      onCallLogPressed: onCallLogPressed,
      onCallFrom: onCallFrom,
      copyNumber: copyNumber,
    );
  }
}
