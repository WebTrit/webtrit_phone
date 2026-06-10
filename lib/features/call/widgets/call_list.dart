import 'dart:async';

import 'package:flutter/material.dart';

import 'package:clock/clock.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import '../bloc/call_bloc.dart';
import '../view/call_screen_style.dart';

/// The list-of-calls roster for the call screen.
///
/// Renders every active call as a tappable [CallRow] (name + status badge +
/// timer) and, when more than one call is in progress, a "N calls - tap to
/// choose" header. Tapping a row reports the call id via [onCallTap] so the
/// caller can focus it (see [CallControlEvent.callSelected]); the focused row
/// is highlighted.
class CallList extends StatelessWidget {
  const CallList({super.key, required this.calls, required this.focusedCallId, required this.onCallTap, this.style});

  final List<ActiveCall> calls;
  final String focusedCallId;
  final ValueChanged<String> onCallTap;
  final CallInfoStyle? style;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (calls.length > 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              context.l10n.call_CallList_header(calls.length).toUpperCase(),
              style: (style?.callStatus ?? const TextStyle()).copyWith(fontSize: 11, letterSpacing: 1.2),
            ),
          ),
        for (final call in calls)
          CallRow(
            key: ValueKey('CallRow-${call.callId}'),
            call: call,
            focused: call.callId == focusedCallId,
            onTap: () => onCallTap(call.callId),
            style: style,
          ),
      ],
    );
  }
}

/// One call in the [CallList]: status badge, name/number and a live duration
/// for answered calls (or the call direction while it is still ringing).
class CallRow extends StatefulWidget {
  const CallRow({super.key, required this.call, required this.focused, required this.onTap, this.style});

  final ActiveCall call;
  final bool focused;
  final VoidCallback onTap;
  final CallInfoStyle? style;

  @override
  State<CallRow> createState() => _CallRowState();
}

class _CallRowState extends State<CallRow> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _syncTicker();
  }

  @override
  void didUpdateWidget(covariant CallRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncTicker();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  // Keeps the duration label ticking only while the call is answered.
  void _syncTicker() {
    if (widget.call.wasAccepted && _ticker == null) {
      _ticker = Timer.periodic(const Duration(seconds: 1), (_) => setState(() {}));
    } else if (!widget.call.wasAccepted && _ticker != null) {
      _ticker?.cancel();
      _ticker = null;
    }
  }

  String _statusBadge(BuildContext context) {
    final call = widget.call;
    if (!call.wasAccepted) return context.l10n.callProcessingStatus_ringing;
    if (call.held) return context.l10n.call_description_held;
    return context.l10n.call_CallList_statusOnCall;
  }

  String _trailing(BuildContext context) {
    final call = widget.call;
    final acceptedTime = call.acceptedTime;
    if (acceptedTime != null) return clock.now().difference(acceptedTime).format();
    return call.isIncoming ? context.l10n.call_CallList_incoming : context.l10n.call_CallList_outgoing;
  }

  Color _statusDotColor() {
    final call = widget.call;
    if (!call.wasAccepted) return Colors.amber.shade300;
    if (call.held) return Colors.blueGrey.shade200;
    return Colors.lightGreen.shade400;
  }

  @override
  Widget build(BuildContext context) {
    final nameStyle = widget.style?.number ?? const TextStyle();
    final statusStyle = widget.style?.callStatus ?? const TextStyle();

    // Rows are light overlay tints of the on-screen text color (white on the
    // standard call gradient): the FOCUSED row is the brighter one with a
    // light border, unfocused rows stay dimmer - matching the design's
    // polarity regardless of what colorScheme.surface resolves to.
    final overlayColor = statusStyle.color ?? Theme.of(context).colorScheme.surface;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Material(
        color: overlayColor.withValues(alpha: widget.focused ? 0.26 : 0.10),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: widget.focused ? Border.all(color: overlayColor.withValues(alpha: 0.55)) : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: _statusDotColor()),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _statusBadge(context).toUpperCase(),
                        style: statusStyle.copyWith(fontSize: 10, letterSpacing: 1.1),
                      ),
                      Text(
                        widget.call.displayName ?? widget.call.handle.value,
                        style: nameStyle.copyWith(fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Text(_trailing(context), style: statusStyle.copyWith(fontSize: 13)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
