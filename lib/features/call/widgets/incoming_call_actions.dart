import 'dart:math';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

export 'call_actions_style.dart';
export 'call_actions_styles.dart';

/// Decline / Answer buttons for the focused ringing call.
///
/// Always at most two actions: what happens to the other calls on answer is
/// decided by the caller (see [CallControlEvent.answerFocused]) and explained
/// by the hint above the buttons, not by extra combined-icon buttons.
class IncomingCallActions extends StatefulWidget {
  const IncomingCallActions({
    super.key,
    required this.remoteVideo,
    required this.inviteToAttendedTransfer,
    this.onHangupPressed,
    this.onAcceptPressed,
    this.style,
  });

  final bool remoteVideo;
  final bool inviteToAttendedTransfer;
  final void Function()? onHangupPressed;
  final void Function()? onAcceptPressed;

  final CallScreenActionsStyle? style;

  @override
  State<IncomingCallActions> createState() => _IncomingCallActionsState();
}

class _IncomingCallActionsState extends State<IncomingCallActions> {
  late MediaQueryData _mediaQueryData;
  late ThemeData _themeData;

  double? _iconSize;

  late bool _isOrientationPortrait;
  late double _dimension;
  late double _horizontalPadding;

  @override
  void didUpdateWidget(covariant IncomingCallActions oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.remoteVideo != widget.remoteVideo) computeDimensions();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mediaQueryData = MediaQuery.of(context);
    _themeData = Theme.of(context);
    computeDimensions();
  }

  void computeDimensions() {
    _iconSize = _themeData.textTheme.headlineLarge?.fontSize;

    _isOrientationPortrait = _mediaQueryData.orientation == Orientation.portrait;
    _dimension = min(_mediaQueryData.size.width, _mediaQueryData.size.height) / 5;
    if (_isOrientationPortrait) {
      _horizontalPadding = _dimension / 2;
    } else {
      _horizontalPadding = _dimension * 3;
    }
    if (mounted) setState(() {});
  }

  /// Wraps an action button with its short label below, as in the redesign.
  Widget _labeled(Widget action, String label) {
    final labelStyle = _themeData.textTheme.bodySmall?.copyWith(color: _themeData.colorScheme.surface);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        action,
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(label, style: labelStyle),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final onAcceptPressed = widget.onAcceptPressed;
    final onHangupPressed = widget.onHangupPressed;

    // Icons
    final actionPadIconSize = themeData.textTheme.headlineMedium!.fontSize;

    final TextButtonsTable buttonsTable;

    final buttons = [
      _labeled(
        Tooltip(
          message: widget.inviteToAttendedTransfer
              ? context.l10n.call_CallActionsTooltip_decline_inviteToAttendedTransfer
              : context.l10n.call_CallActionsTooltip_hangup,
          child: TextButton(
            key: callActionsHangupKey,
            onPressed: onHangupPressed,
            style: widget.style?.hangup,
            child: Icon(Icons.call_end, size: actionPadIconSize),
          ),
        ),
        context.l10n.call_CallActions_decline,
      ),
      if (widget.onAcceptPressed != null)
        _labeled(
          Tooltip(
            message: widget.inviteToAttendedTransfer
                ? context.l10n.call_CallActionsTooltip_accept_inviteToAttendedTransfer
                : context.l10n.call_CallActionsTooltip_accept,
            child: TextButton(
              onPressed: onAcceptPressed,
              style: widget.style?.callStart,
              child: Icon(widget.remoteVideo ? Icons.videocam : Icons.call, size: actionPadIconSize),
            ),
          ),
          context.l10n.call_CallActions_answer,
        ),
    ];

    buttonsTable = TextButtonsTable(
      minimumSize: Size.square(_dimension),
      keyButtonsInTableRowCount: buttons.length,
      children: buttons,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
      child: IconTheme(
        data: IconThemeData(size: _iconSize),
        child: Column(children: [buttonsTable]),
      ),
    );
  }
}
