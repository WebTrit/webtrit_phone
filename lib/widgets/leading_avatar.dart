import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';

import '../utils/utils.dart';
import 'safe_network_image.dart';

class LeadingAvatar extends StatefulWidget {
  const LeadingAvatar({
    super.key,
    required this.username,
    this.thumbnail,
    this.thumbnailUrl,
    this.placeholderIcon = Icons.person_outline,
    this.smart = false,
    this.radius, // value of private _defaultRadius variable in CircleAvatar class
    this.showLoading = false,
    this.loadingPadding,
    this.style,
    this.badge,
  });

  final String? username;
  final Uint8List? thumbnail;
  final Uri? thumbnailUrl;
  final IconData placeholderIcon;
  final bool smart;
  final double? radius;
  final bool showLoading;
  final EdgeInsets? loadingPadding;
  final LeadingAvatarStyle? style;

  /// Status badge overlay (e.g. `AvatarStatusBadge`); it receives the whole
  /// avatar square and positions itself within it.
  final Widget? badge;

  @override
  State<LeadingAvatar> createState() => _LeadingAvatarState();
}

class _LeadingAvatarState extends State<LeadingAvatar> {
  late LeadingAvatarStyle _style;
  late double _radius;
  late double _diameter;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _recompute();
  }

  @override
  void didUpdateWidget(covariant LeadingAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.style != widget.style || oldWidget.radius != widget.radius) {
      _recompute();
    }
  }

  // The resolved style always carries the app's own values underneath, so the
  // fields it fills are read without a fallback of their own here.
  void _recompute() {
    _style = LeadingAvatarStyle.merge(LeadingAvatarStyles.of(context), widget.style);

    _radius = widget.radius ?? _style.radius!;
    _diameter = _radius * 2;
  }

  /// Name-derived background, or null when disabled / not applicable (photo shown, no name).
  Color? _nameBackgroundColor(BuildContext context) {
    final nameColors = _style.nameColors!;
    if (!nameColors.enabled) return null;
    if (widget.thumbnail != null || widget.thumbnailUrl != null) return null;

    return AvatarColors.background(widget.username, Theme.of(context).brightness, palette: nameColors.palette);
  }

  @override
  Widget build(BuildContext context) {
    final nameBackgroundColor = _nameBackgroundColor(context);

    return Container(
      width: _diameter,
      height: _diameter,
      decoration: BoxDecoration(shape: BoxShape.circle, color: nameBackgroundColor ?? _style.backgroundColor),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              // The default layout builder stacks the children loosely, which lets an image
              // size itself to its intrinsic pixels and float in the middle of the circle
              // instead of covering it; expand so the content always fills the avatar.
              layoutBuilder: (currentChild, previousChildren) => Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [...previousChildren, ?currentChild],
              ),
              child: _buildAvatarContent(_diameter, _style),
            ),
          ),
          if (widget.badge != null) Positioned.fill(child: widget.badge!),
          if (widget.smart)
            Positioned.fromRect(
              rect: BadgeLayout.topLeftSquare(
                size: _diameter,
                sizeFactor: _style.smartIndicator!.sizeFactor!,
                dxFactor: -0.1,
                dyFactor: -0.1,
              ),
              child: _smartIndicator(_diameter, _style),
            ),
          if (widget.showLoading) _buildLoadingOverlay(_style),
        ],
      ),
    );
  }

  Widget _buildAvatarContent(double diameter, LeadingAvatarStyle style) {
    if (widget.thumbnailUrl != null) {
      // Gravatar serves 80x80 unless asked otherwise, which is soft on a list row and
      // visibly pixelated on a large avatar, so ask for the resolution actually painted.
      final devicePixels = (diameter * MediaQuery.devicePixelRatioOf(context)).round();
      final url = gravatarUrlWithSize(widget.thumbnailUrl, devicePixels) ?? widget.thumbnailUrl!;

      // Keyed by the sized url, not by the contact's: the image provider is resolved once
      // per mount, so a new size has to arrive as a new child.
      return ClipOval(key: ValueKey('remote:$url'), child: _remoteImage(url, diameter, style));
    } else if (widget.thumbnail != null) {
      return const ClipOval(key: ValueKey('local'), child: _LocalImage());
    } else {
      return ClipOval(key: ValueKey('placeholder:${widget.username ?? ""}'), child: _placeholder(diameter, style));
    }
  }

  Widget _buildLoadingOverlay(LeadingAvatarStyle style) {
    final hasAvatarData = widget.username != null || (widget.thumbnail != null || widget.thumbnailUrl != null);

    final padding = widget.loadingPadding ?? style.loadingOverlay!.padding!;
    final strokeWidth = style.loadingOverlay!.strokeWidth!;
    final color = style.initialsTextStyle?.color;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
      child: hasAvatarData
          ? const SizedBox.shrink()
          : SizedBox(
              key: const ValueKey('loading'),
              width: kMinInteractiveDimension,
              height: kMinInteractiveDimension,
              child: Padding(
                padding: padding,
                child: CircularProgressIndicator(strokeWidth: strokeWidth, color: color),
              ),
            ),
    );
  }

  Widget _remoteImage(Uri url, double diameter, LeadingAvatarStyle style) {
    return SafeNetworkImage(
      url.toString(),
      fit: BoxFit.cover,
      placeholderBuilder: () => _placeholder(diameter, style),
      errorBuilder: () {
        if (widget.thumbnail != null) return const _LocalImage();
        return _placeholder(diameter, style);
      },
    );
  }

  Widget _placeholder(double diameter, LeadingAvatarStyle style) {
    final username = widget.username;
    final icon = style.placeholderIcon ?? widget.placeholderIcon;
    final brightness = Theme.of(context).brightness;
    final nameBackgroundColor = _nameBackgroundColor(context);
    final color = nameBackgroundColor != null
        ? AvatarColors.foreground(nameBackgroundColor, brightness)
        : style.initialsTextStyle?.color;

    if (username != null) {
      final defaultTs = TextStyle(fontSize: diameter * 0.35, fontWeight: FontWeight.bold);

      return Center(
        child: Text(
          username.initialism,
          softWrap: false,
          overflow: TextOverflow.fade,
          textAlign: TextAlign.center,
          style: defaultTs.merge(style.initialsTextStyle).copyWith(color: color),
        ),
      );
    }

    return Icon(icon, size: diameter * 0.5, color: color);
  }

  Widget _smartIndicator(double diameter, LeadingAvatarStyle style) {
    final smart = style.smartIndicator!;
    final bg = smart.backgroundColor;
    final icon = smart.icon;
    final sizeFactor = smart.sizeFactor!;
    final color = style.initialsTextStyle?.color;

    return CircleAvatar(
      backgroundColor: bg,
      child: Icon(icon, size: diameter * sizeFactor * 0.9, color: color),
    );
  }
}

class _LocalImage extends StatelessWidget {
  const _LocalImage();

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_LeadingAvatarState>()!;
    final thumbnail = state.widget.thumbnail!;
    return Image.memory(
      thumbnail,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => state._placeholder(state._diameter, state._style),
    );
  }
}
