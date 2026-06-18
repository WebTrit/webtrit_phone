import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

/// A single contact/number action.
///
/// This is the one source of truth for both the inline actions bar and the
/// popup menu, so the set, labels, icons and ordering of actions never diverge
/// between the two surfaces (or between different screens that reuse them).
class NumberAction {
  const NumberAction({required this.icon, required this.label, required this.onTap, this.primary = false});

  /// Icon used when the action is rendered in the inline actions bar.
  final IconData icon;

  /// Single source label, shared by the inline bar and the popup menu.
  final String label;

  final VoidCallback onTap;

  /// Whether the action belongs to the inline bar. Non-primary actions are kept
  /// in the overflow menu only, so an action never shows up in both places.
  final bool primary;
}

/// Builds the ordered list of available actions from the provided callbacks.
///
/// Only the actions whose callback is non-null are included, so each caller
/// gets exactly the affordances it wires up. Primary actions lead the list.
List<NumberAction> buildNumberActions(
  BuildContext context, {
  required List<String> callNumbers,
  VoidCallback? onAudioCallPressed,
  VoidCallback? onVideoCallPressed,
  VoidCallback? onChatPressed,
  VoidCallback? onCallLogPressed,
  VoidCallback? onViewContactPressed,
  VoidCallback? onTransferPressed,
  VoidCallback? onSendSmsPressed,
  void Function(String)? onCallFrom,
  String? copyNumber,
  String? copyCallId,
  VoidCallback? onDelete,
}) {
  final l10n = context.l10n;
  return [
    // Primary actions: surfaced inline when expanded.
    if (onAudioCallPressed != null)
      NumberAction(
        icon: Icons.call_outlined,
        label: l10n.numberActions_audioCall,
        onTap: onAudioCallPressed,
        primary: true,
      ),
    if (onVideoCallPressed != null)
      NumberAction(
        icon: Icons.videocam_outlined,
        label: l10n.numberActions_videoCall,
        onTap: onVideoCallPressed,
        primary: true,
      ),
    if (onChatPressed != null)
      NumberAction(icon: Icons.chat_outlined, label: l10n.callTileActions_message, onTap: onChatPressed, primary: true),
    if (onCallLogPressed != null)
      NumberAction(icon: Icons.history, label: l10n.callTileActions_history, onTap: onCallLogPressed, primary: true),
    if (onViewContactPressed != null)
      NumberAction(
        icon: Icons.person_outline,
        label: l10n.callTileActions_contact,
        onTap: onViewContactPressed,
        primary: true,
      ),
    // Overflow actions: kept in the menu only.
    if (callNumbers.length > 1 && onCallFrom != null)
      for (final number in callNumbers)
        NumberAction(
          icon: Icons.call_outlined,
          label: l10n.numberActions_callFrom(number),
          onTap: () => onCallFrom(number),
        ),
    if (onTransferPressed != null)
      NumberAction(icon: Icons.phone_forwarded_outlined, label: l10n.numberActions_transfer, onTap: onTransferPressed),
    if (onSendSmsPressed != null)
      NumberAction(icon: Icons.sms_outlined, label: l10n.numberActions_sendSms, onTap: onSendSmsPressed),
    if (copyNumber != null)
      NumberAction(
        icon: Icons.copy_outlined,
        label: l10n.numberActions_copyNumber,
        onTap: () => Clipboard.setData(ClipboardData(text: copyNumber)),
      ),
    if (copyCallId != null)
      NumberAction(
        icon: Icons.copy_outlined,
        label: l10n.numberActions_copyCallId,
        onTap: () => Clipboard.setData(ClipboardData(text: copyCallId)),
      ),
    if (onDelete != null) NumberAction(icon: Icons.delete_outline, label: l10n.numberActions_delete, onTap: onDelete),
  ];
}

/// Converts actions into popup menu entries (text-only, icons are not shown).
List<PopupMenuEntry<dynamic>> numberActionsToMenu(List<NumberAction> actions) {
  return [for (final action in actions) PopupMenuItem(onTap: action.onTap, child: Text(action.label))];
}
