import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class FavoriteTile extends StatelessWidget {
  const FavoriteTile({
    super.key,
    required this.favorite,
    this.contact,
    required this.callNumbers,
    this.onTap,
    this.expanded = false,
    this.onDialPressed,
    this.onAudioCallPressed,
    this.onVideoCallPressed,
    this.onTransferPressed,
    this.onChatPressed,
    this.onSendSmsPressed,
    this.onViewContactPressed,
    this.onCallLogPressed,
    this.onDelete,
    this.onCallFrom,
    this.gesturesEnabled = true,
  });

  final Favorite favorite;
  final Contact? contact;
  final List<String> callNumbers;
  final Function()? onTap;
  final bool expanded;
  final Function()? onDialPressed;
  final Function()? onAudioCallPressed;
  final Function()? onVideoCallPressed;
  final Function()? onTransferPressed;
  final Function()? onChatPressed;
  final Function()? onSendSmsPressed;
  final Function()? onViewContactPressed;
  final Function()? onCallLogPressed;
  final Function()? onDelete;
  final Function(String)? onCallFrom;
  final bool gesturesEnabled;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final presenceParams = PresenceViewParams.of(context);

    final name = contact?.maybeName ?? favorite.number;
    final title = switch (presenceParams.hybridPresenceSupport) {
      true => '$name ${contact?.presenceInfo.primaryStatusIcon ?? ''}',
      false => name,
    };

    return CallTile(
      dismissibleObject: favorite,
      leading: LeadingAvatar(
        username: name,
        thumbnail: contact?.thumbnail,
        thumbnailUrl: contact?.thumbnailUrl,
        registered: contact?.registered,
        presenceInfo: contact?.presenceInfo,
        dialogInfo: contact?.dialogInfo,
      ),
      name: title,
      subName: '${favorite.label.capitalize}: ${favorite.number}',
      dismissible: true,
      dismissBackground: Container(
        color: themeData.colorScheme.error,
        padding: const EdgeInsets.only(right: 16),
        child: const Align(alignment: Alignment.centerRight, child: Icon(Icons.delete_outline)),
      ),
      confirmDismiss: (direction) => ConfirmDialog.showDangerous(
        context,
        title: context.l10n.favorites_DeleteConfirmDialog_title,
        content: context.l10n.favorites_DeleteConfirmDialog_content,
      ),
      onDismiss: onDelete,
      onTap: onTap,
      expanded: expanded,
      onDialPressed: onDialPressed,
      gesturesEnabled: gesturesEnabled,
      callNumbers: callNumbers,
      onAudioCallPressed: onAudioCallPressed,
      onVideoCallPressed: onVideoCallPressed,
      onTransferPressed: onTransferPressed,
      onChatPressed: onChatPressed,
      onSendSmsPressed: onSendSmsPressed,
      onViewContactPressed: onViewContactPressed,
      onCallLogPressed: onCallLogPressed,
      onCallFrom: onCallFrom,
      copyNumber: favorite.number,
      onDelete: onDelete,
    );
  }
}
