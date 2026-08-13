import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/register_status/register_status.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

/// Account registration toggle.
///
/// The value is a server-side account setting, not a live connection state.
/// While a server request has no chance of succeeding (no network, session
/// still connecting) the cached value is neither trustworthy nor changeable,
/// so the row keeps the last known value but drops any claim about it: it
/// renders in the Material disabled treatment and explains itself in the
/// subtitle, instead of contradicting the connection status shown right above
/// it. A signaling error does NOT disable the row - the setting travels over
/// HTTP independently of the signaling channel, so the attempt is allowed and
/// a failure is reported by the caller of [onChanged].
class RegisterStatusListTile extends StatelessWidget {
  const RegisterStatusListTile({
    super.key,
    required this.sessionStatus,
    required this.registerStatus,
    required this.onChanged,
    required this.onUnavailableTap,
    this.textStyle,
    this.iconColor,
  });

  final SessionStatus sessionStatus;
  final RegisterStatus registerStatus;
  final ValueChanged<bool> onChanged;
  final VoidCallback onUnavailableTap;
  final TextStyle? textStyle;
  final Color? iconColor;

  /// Material disabled-state opacity, applied only to colors that come from
  /// the white-label theme: those override the defaults on the Text/Icon
  /// directly, so the built-in disabled treatment cannot reach them.
  static const _disabledOpacity = 0.38;

  @override
  Widget build(BuildContext context) {
    final available = sessionStatus.mayReachServer;

    final effectiveTextStyle = available || textStyle?.color == null
        ? textStyle
        : textStyle!.copyWith(color: textStyle!.color!.withValues(alpha: _disabledOpacity));
    final effectiveIconColor = available || iconColor == null
        ? iconColor
        : iconColor!.withValues(alpha: _disabledOpacity);
    final disabledColor = Theme.of(context).disabledColor;

    // TODO(Serdun): Rename the label to the action it controls, e.g. "Accept
    // calls", as proposed in the design. The English "Online" reads as the
    // user's presence while this switch is the account registration setting;
    // needs copy approval across all locales before changing.
    final title = Text(context.l10n.settings_ListViewTileTitle_registered, style: effectiveTextStyle);
    final icon = Icon(Icons.account_circle_outlined, color: effectiveIconColor);

    // A single subtitle line in every state: the row must keep its height when
    // the state changes, or the whole list below jumps.
    Text subtitle(String caption) => Text(caption, maxLines: 1, overflow: TextOverflow.ellipsis);

    // An update is in flight: the control itself is busy, so it gives way to a
    // progress indicator and the value stays put until the server answers.
    if (registerStatus.isUpdating) {
      return ListTile(
        leading: icon,
        title: title,
        subtitle: subtitle(context.l10n.settings_ListViewTileSubtitle_registeredUpdating),
        trailing: const SizedCircularProgressIndicator(size: 24, strokeWidth: 2),
      );
    }

    if (available) {
      return SwitchListTile(
        title: title,
        subtitle: subtitle(_subtitle(context, available: available)),
        value: registerStatus.value,
        onChanged: onChanged,
        secondary: icon,
      );
    }

    // Out of reach of the server: the row keeps the last known value but shows
    // it as a disabled switch, and the row itself takes the tap that explains
    // why. It used to be the whole tile behind an IgnorePointer, which took
    // the switch out of the accessibility tree altogether - leaving an
    // unnamed tappable strip that said nothing about the state or the reason.
    // One node for the row: the wording, the value and the tap that explains
    // why it cannot be changed belong together, or a screen reader lands on a
    // switch that says "on" without saying what is on.
    return MergeSemantics(
      child: ListTile(
        onTap: onUnavailableTap,
        leading: icon,
        // A ListTile only dims itself when it is disabled, and disabling it
        // would take away the tap that carries the explanation - so the row
        // wears the Material disabled treatment by hand.
        iconColor: effectiveIconColor ?? disabledColor,
        textColor: textStyle?.color == null ? disabledColor : null,
        title: title,
        subtitle: subtitle(_subtitle(context, available: available)),
        trailing: Switch(value: registerStatus.value, onChanged: null),
      ),
    );
  }

  String _subtitle(BuildContext context, {required bool available}) {
    if (!available) {
      return sessionStatus.signalingStatus == CallStatus.inProgress
          ? context.l10n.settings_ListViewTileSubtitle_registeredWaitingForConnection
          : context.l10n.settings_ListViewTileSubtitle_registeredNeedsConnection;
    }
    return registerStatus.value
        ? context.l10n.settings_ListViewTileSubtitle_registeredOn
        : context.l10n.settings_ListViewTileSubtitle_registeredOff;
  }
}
