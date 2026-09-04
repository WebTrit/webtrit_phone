import 'dart:math';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import '../view/call_screen_style.dart';
import '../view/call_screen_styles.dart';
import 'call_action_area.dart';
import 'call_action_button.dart';
import 'call_controls.dart';
import 'call_info_block.dart';
import 'call_remote_avatar.dart';

/// The landscape arrangement of the call screen body: three zones in one row.
///
/// The info zone (avatar beside the left-ranged call info, or the roster with
/// several calls) takes the width the other zones leave over; the action grid
/// stands beside it; the hangup button stands apart behind a fading rule, so
/// the destructive control is the hardest one to hit by accident. A ringing
/// focus offers nothing but Decline/Answer, so the grid and hangup zones stand
/// down and the two decisions (with the "Acting on" hint) take their place.
///
/// It only places the shared pieces ([CallInfoBlock], [CallActionArea]) - what
/// each control does arrives in [params] as callbacks, and the toolbar belongs
/// to [CallControls], which picks this layout or the portrait one by
/// orientation.
class CallControlsLandscape extends StatelessWidget {
  const CallControlsLandscape({super.key, required this.params});

  final CallControlsParams params;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: _buildZones);
  }

  Widget _buildZones(BuildContext context, BoxConstraints constraints) {
    final mediaQueryData = MediaQuery.of(context);
    final style = Theme.of(context).extension<CallScreenStyles>()?.primary;

    final focusedIsRinging = params.focusedCall.isIncomingRinging;

    // The base unit the action grids size their buttons with. It comes
    // from the screen's short side, which in landscape is the height - so
    // on a wide-but-low surface (a split-screen window, a resized web
    // viewport) the zones it produces can outgrow the width. The zone
    // widths below are therefore budgeted from what is actually left
    // after the padding and the gaps, with a floor under every tap
    // target: the zones shrink, the buttons do not.
    final dimension = mediaQueryData.size.shortestSide / 5;
    final naturalAreaWidth = dimension * 3.4;
    // The zone width at which the scaled grid buttons reach the minimum
    // tap size; the grid zone never shrinks past it while the width
    // still holds it. A grid whose natural buttons are already at or
    // under the minimum is not scaled down at all.
    final minAreaWidth = dimension > kMinInteractiveDimension
        ? naturalAreaWidth * (kMinInteractiveDimension / dimension)
        : naturalAreaWidth;

    // Whether the isolated hangup zone (with its rule and gaps) fits
    // beside a grid at its minimum scale. Where it does not, the hangup
    // moves back into the grid's own row - one scale then carries every
    // control down together, so ending the call is never out of reach
    // while the rest of the grid still renders.
    final fullAvailable = constraints.maxWidth - (64.0 + 24.0 + 24.0 + 1.0 + 24.0);
    final tight = !focusedIsRinging && fullAvailable < kMinInteractiveDimension + minAreaWidth;
    final hangupZoneShown = !focusedIsRinging && !tight;

    final chrome = 64.0 + 24.0 + (hangupZoneShown ? 24.0 + 1.0 + 24.0 : 0.0);
    final available = max(0.0, constraints.maxWidth - chrome);
    // The isolated hangup never drops below the minimum tap target: it
    // is the only way to end the call, so it is the last thing allowed
    // to shrink - and the zone stands only while that floor fits.
    final hangupZoneWidth = hangupZoneShown ? min(dimension, max(kMinInteractiveDimension, available * 0.13)) : 0.0;
    final gridBudget = available - hangupZoneWidth;
    final areaZoneWidth = min(naturalAreaWidth, max(gridBudget * 0.58, min(gridBudget, minAreaWidth)));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          Expanded(
            child: _InfoZone(params: params, style: style),
          ),
          const SizedBox(width: 24),
          if (focusedIsRinging)
            // The two ringing decisions (and the "Acting on" hint) at
            // their natural size: the hint wraps and tall content
            // scrolls, so growing text - long names, a raised font
            // scale - can never shrink Decline and Answer, the two most
            // time-critical buttons on screen.
            SizedBox(
              width: areaZoneWidth,
              child: Center(
                child: SingleChildScrollView(
                  child: CallActionArea(params: params, hangupRowShown: false, padded: false),
                ),
              ),
            )
          else
            // The action grid at its natural size, scaled down into the
            // zone when the zone is capped; the table inside splits the
            // width evenly. In the tight fallback the grid keeps its own
            // hangup row instead of the isolated zone.
            SizedBox(
              width: areaZoneWidth,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: SizedBox(
                  width: naturalAreaWidth,
                  // The hangup lives in a zone of its own here, and the
                  // zones place the area themselves - no self-centering
                  // padding.
                  child: CallActionArea(params: params, hangupRowShown: !hangupZoneShown, padded: false),
                ),
              ),
            ),
          // A ringing focus keeps Decline/Answer inside the area - there
          // is no separate hangup to set apart.
          if (hangupZoneShown) ...[
            const SizedBox(width: 24),
            _FadingRule(height: min(dimension * 1.8, constraints.maxHeight * 0.6), style: style),
            const SizedBox(width: 24),
            SizedBox(
              width: hangupZoneWidth,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: _HangupZone(
                  dimension: dimension,
                  style: style,
                  onHangup: params.onHangup,
                  keypadShown: params.keypadShown,
                  onKeypadToggle: params.onKeypadToggle,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// The landscape info zone: the roster with several calls (scrolling past two
/// rows rather than shrinking them), or the avatar beside the left-ranged call
/// info with a single one. While the keypad is open the typed digits stand
/// here too, under the caller they are being sent to. Content that outgrows
/// the zone (a long roster, a doubled font scale) scrolls instead of
/// overflowing.
class _InfoZone extends StatelessWidget {
  const _InfoZone({required this.params, required this.style});

  final CallControlsParams params;
  final CallScreenStyle? style;

  @override
  Widget build(BuildContext context) {
    if (params.activeCalls.length > 1) {
      return Center(child: SingleChildScrollView(child: _buildInfoBlock(context)));
    }

    return LayoutBuilder(builder: _buildSingleCallZone);
  }

  /// The lines about the call: the roster or the single-call info, with the
  /// typed digits under them while the keypad is open. Only once there is
  /// something to show: an empty underlined strip reads as a stray line, not
  /// as a display waiting for input. The display listens to the buffer
  /// itself, so a keypress repaints it alone rather than the whole layout.
  Widget _buildInfoBlock(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CallInfoBlock(
          activeCalls: params.activeCalls,
          focusedCall: params.focusedCall,
          onCallSelected: params.onCallSelected,
          textAlign: TextAlign.start,
        ),
        if (params.keypadShown)
          ValueListenableBuilder<String>(
            valueListenable: params.dtmfInput,
            builder: (context, digits, _) =>
                digits.isEmpty ? const SizedBox.shrink() : _DtmfDisplay(digits: digits, style: style),
          ),
      ],
    );
  }

  Widget _buildSingleCallZone(BuildContext context, BoxConstraints constraints) {
    final infoBlock = _buildInfoBlock(context);
    final mediaQueryData = MediaQuery.of(context);
    // Landscape heights leave no room for the portrait-sized avatar; the
    // design ranges a smaller one beside the info instead of above it.
    final avatarRadius = (mediaQueryData.size.shortestSide * 0.18).clamp(24.0, 84.0);

    // A zone squeezed by the tap-target floors of its neighbours can get
    // too narrow for the picture and the gap beside it. The lines saying
    // who the call is with matter more than the portrait, so the avatar
    // gives way rather than overflow.
    final avatarShown = !params.focusedFrameRenderable && constraints.maxWidth >= avatarRadius * 2 + 24 + 48;
    if (!avatarShown) {
      return Center(child: SingleChildScrollView(child: infoBlock));
    }

    return Center(
      child: SingleChildScrollView(
        child: Row(
          children: [
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                // The focused call, not the derived current one: whatever
                // the info lines describe, the picture shows the same person.
                child: CallRemoteAvatar(
                  activeCall: params.focusedCall,
                  radius: avatarRadius,
                  contactResolver: params.contactResolver,
                ),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(child: infoBlock),
          ],
        ),
      ),
    );
  }
}

/// The digits typed on the open landscape keypad, underlined the way a dial
/// display is, in the info zone's own text color.
class _DtmfDisplay extends StatelessWidget {
  const _DtmfDisplay({required this.digits, required this.style});

  final String digits;
  final CallScreenStyle? style;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final base = style?.callInfo?.callStatus?.color ?? themeData.colorScheme.surface;
    final textStyle = (style?.callInfo?.userInfo ?? themeData.textTheme.headlineSmall?.copyWith(color: base))?.copyWith(
      fontFeatures: [const FontFeature.tabularFigures()],
      letterSpacing: 2,
    );

    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.only(bottom: 4),
      constraints: const BoxConstraints(minWidth: 120),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: base.withValues(alpha: 0.35))),
      ),
      // The newest digits matter most: a long dial shows its tail, the way
      // the portrait field keeps its caret at the end.
      child: Text(_tail(digits), style: textStyle, maxLines: 1, softWrap: false),
    );
  }

  static const _maxVisibleDigits = 18;

  static String _tail(String digits) {
    if (digits.length <= _maxVisibleDigits) return digits;
    return '...${digits.substring(digits.length - _maxVisibleDigits)}';
  }
}

/// The isolated hangup zone: the destructive control alone past the rule, so
/// reaching it is always a deliberate move. While the keypad is open the way
/// to close it stands here too, under the hangup - in portrait that button
/// lives in the grid's hangup row, which this zone replaces.
class _HangupZone extends StatelessWidget {
  const _HangupZone({
    required this.dimension,
    required this.style,
    required this.onHangup,
    required this.keypadShown,
    required this.onKeypadToggle,
  });

  final double dimension;
  final CallScreenStyle? style;
  final VoidCallback onHangup;
  final bool keypadShown;
  final ValueChanged<bool> onKeypadToggle;

  @override
  Widget build(BuildContext context) {
    // The grids hand their buttons the table's themed style with a size
    // fallback; the standalone pair gets the same resolution order, so a
    // brand theme styles this zone exactly as it styles the grid.
    final tableStyle = Theme.of(context).extension<TextButtonsTableStyles>()?.primary;
    TextButtonThemeData themed(double size) => TextButtonThemeData(
      style: TextButton.styleFrom(minimumSize: Size.square(size))
          .merge(tableStyle?.buttonStyle)
          .merge(TextButtonTheme.of(context).style),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButtonTheme(
          data: themed(dimension),
          child: CallHangupButton(onPressed: onHangup, style: style?.actions?.hangup),
        ),
        if (keypadShown) ...[
          SizedBox(height: dimension / 5),
          TextButtonTheme(
            data: themed(dimension * 0.7),
            child: CallHideKeypadButton(onPressed: () => onKeypadToggle(false), style: style?.actions?.key),
          ),
        ],
      ],
    );
  }
}

/// The vertical rule fading out at both ends, standing between the action
/// grid and the hangup zone.
class _FadingRule extends StatelessWidget {
  const _FadingRule({required this.height, required this.style});

  final double height;
  final CallScreenStyle? style;

  @override
  Widget build(BuildContext context) {
    // Derived from the info text color the same way the roster derives its
    // row overlays, so an unthemed harness stays legible without fixed colors.
    final base = style?.callInfo?.callStatus?.color ?? Theme.of(context).colorScheme.surface;
    final midColor = base.withValues(alpha: 0.22);
    final endColor = base.withValues(alpha: 0);

    return Container(
      width: 1,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [endColor, midColor, endColor],
        ),
      ),
    );
  }
}
