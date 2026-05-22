import 'dart:math';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

export 'call_actions_style.dart';
export 'call_actions_styles.dart';

class IncomingCallActions extends StatefulWidget {
  const IncomingCallActions({
    super.key,
    required this.enableInteractions,
    required this.remoteVideo,
    required this.inviteToAttendedTransfer,
    this.onHangupPressed,
    this.onHangupAndAcceptPressed,
    this.onHoldAndAcceptPressed,
    this.onAcceptPressed,
    this.style,
  });

  final bool enableInteractions;
  final bool remoteVideo;
  final bool inviteToAttendedTransfer;
  final void Function()? onHangupPressed;
  final void Function()? onHangupAndAcceptPressed;
  final void Function()? onHoldAndAcceptPressed;
  final void Function()? onAcceptPressed;

  final CallScreenActionsStyle? style;

  @override
  State<IncomingCallActions> createState() => _IncomingCallActionsState();
}

class _IncomingCallActionsState extends State<IncomingCallActions> {
  late TextEditingController _keypadTextEditingController;

  late MediaQueryData _mediaQueryData;
  late ThemeData _themeData;

  double? _iconSize;

  late bool _isOrientationPortrait;
  late double _dimension;
  late double _horizontalPadding;

  @override
  void initState() {
    super.initState();
    _keypadTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _keypadTextEditingController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final onHangupAndAcceptPressed = widget.enableInteractions ? widget.onHangupAndAcceptPressed : null;
    final onHoldAndAcceptPressed = widget.enableInteractions ? widget.onHoldAndAcceptPressed : null;

    final onAcceptPressed = widget.onAcceptPressed;
    final onHangupPressed = widget.onHangupPressed;

    // Icons
    final actionPadIconSize = themeData.textTheme.headlineMedium!.fontSize;

    final TextButtonsTable buttonsTable;

    final buttons = [
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
      if (widget.onAcceptPressed != null)
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
      if (widget.onHangupAndAcceptPressed != null)
        Tooltip(
          message: context.l10n.call_CallActionsTooltip_hangupAndAccept,
          child: TextButton(
            onPressed: onHangupAndAcceptPressed,
            style: widget.style?.callStart,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.call_end, size: actionPadIconSize),
                Icon(widget.remoteVideo ? Icons.videocam : Icons.call, size: actionPadIconSize),
              ],
            ),
          ),
        ),
      if (widget.onHoldAndAcceptPressed != null)
        Tooltip(
          message: context.l10n.call_CallActionsTooltip_holdAndAccept,
          child: TextButton(
            onPressed: onHoldAndAcceptPressed,
            style: widget.style?.callStart,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.pause, size: actionPadIconSize),
                Icon(widget.remoteVideo ? Icons.videocam : Icons.call, size: actionPadIconSize),
              ],
            ),
          ),
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
