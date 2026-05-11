import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

List<PopupMenuEntry<dynamic>> buildNumberActions(
  BuildContext context, {
  required List<String> callNumbers,
  VoidCallback? onAudioCallPressed,
  VoidCallback? onVideoCallPressed,
  VoidCallback? onTransferPressed,
  VoidCallback? onChatPressed,
  VoidCallback? onSendSmsPressed,
  VoidCallback? onViewContactPressed,
  VoidCallback? onCallLogPressed,
  void Function(String)? onCallFrom,
  String? copyNumber,
  String? copyCallId,
  VoidCallback? onDelete,
}) {
  final l10n = context.l10n;
  return [
    if (onAudioCallPressed != null) PopupMenuItem(onTap: onAudioCallPressed, child: Text(l10n.numberActions_audioCall)),
    if (onVideoCallPressed != null) PopupMenuItem(onTap: onVideoCallPressed, child: Text(l10n.numberActions_videoCall)),
    if (callNumbers.length > 1)
      for (final number in callNumbers)
        PopupMenuItem(onTap: () => onCallFrom?.call(number), child: Text(l10n.numberActions_callFrom(number))),
    if (onTransferPressed != null) PopupMenuItem(onTap: onTransferPressed, child: Text(l10n.numberActions_transfer)),
    if (onChatPressed != null) PopupMenuItem(onTap: onChatPressed, child: Text(l10n.numberActions_chat)),
    if (onSendSmsPressed != null) PopupMenuItem(onTap: onSendSmsPressed, child: Text(l10n.numberActions_sendSms)),
    if (onViewContactPressed != null)
      PopupMenuItem(onTap: onViewContactPressed, child: Text(l10n.numberActions_viewContact)),
    if (onCallLogPressed != null) PopupMenuItem(onTap: onCallLogPressed, child: Text(l10n.numberActions_callLog)),
    if (copyNumber != null)
      PopupMenuItem(
        onTap: () => Clipboard.setData(ClipboardData(text: copyNumber)),
        child: Text(l10n.numberActions_copyNumber),
      ),
    if (copyCallId != null)
      PopupMenuItem(
        onTap: () => Clipboard.setData(ClipboardData(text: copyCallId)),
        child: Text(l10n.numberActions_copyCallId),
      ),
    if (onDelete != null) PopupMenuItem(onTap: onDelete, child: Text(l10n.numberActions_delete)),
  ];
}
