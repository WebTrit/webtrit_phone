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
    this.registered,
    this.smart = false,
    this.radius = 20.0, // value of private _defaultRadius variable in CircleAvatar class
    this.showLoading = false,
    this.loadingPadding,
    this.style,
  });

  final String? username;
  final Uint8List? thumbnail;
  final Uri? thumbnailUrl;
  final IconData placeholderIcon;
  final bool? registered;
  final bool smart;
  final double radius;
  final bool showLoading;
  final EdgeInsets? loadingPadding;
  final LeadingAvatarStyle? style;

  @override
  State<LeadingAvatar> createState() => _LeadingAvatarState();
}

class _LeadingAvatarState extends State<LeadingAvatar> {
  late LeadingAvatarStyle _style;
  late double _radius;
  late double _diameter;
  late Rect _registeredRect;
  late Rect _smartRect;

  @override
  void initState() {
    super.initState();
    _style = const LeadingAvatarStyle();
    _radius = widget.radius;
    _diameter = _radius * 2;
    _updateBadgeRects();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _recompute();
  }

  @override
  void didUpdateWidget(covariant LeadingAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.style != widget.style ||
        oldWidget.radius != widget.radius ||
        oldWidget.smart != widget.smart ||
        oldWidget.registered != widget.registered ||
        oldWidget.thumbnailUrl != widget.thumbnailUrl ||
        oldWidget.thumbnail != widget.thumbnail ||
        oldWidget.username != widget.username) {
      _recompute();
    }
  }

  void _recompute() {
    final theme = Theme.of(context);
    final themeStyle = theme.extension<LeadingAvatarStyles>()?.primary;

    _style = LeadingAvatarStyle.merge(themeStyle, widget.style);

    _radius = _style.radius ?? widget.radius;
    _diameter = _radius * 2;

    _updateBadgeRects();
  }

  void _updateBadgeRects() {
    final registeredSizeFactor = _style.registeredBadge?.sizeFactor ?? 0.2;
    final smartSizeFactor = _style.smartIndicator?.sizeFactor ?? 0.4;

    _registeredRect = BadgeLayout.bottomRightSquare(
      size: _diameter,
      sizeFactor: registeredSizeFactor,
    );

    _smartRect = BadgeLayout.topLeftSquare(
      size: _diameter,
      sizeFactor: smartSizeFactor,
      dxFactor: -0.1,
      dyFactor: -0.1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: _diameter,
      height: _diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _style.backgroundColor ?? scheme.secondaryContainer,
      ),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: [
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: _buildAvatarContent(_diameter, _style),
            ),
          ),
          if (widget.smart)
            Positioned.fromRect(rect: _smartRect, child: _smartIndicator(_diameter, _style, scheme))
          else if (widget.registered != null)
            Positioned.fromRect(rect: _registeredRect, child: _registeredIndicator(_style)),
          if (widget.showLoading) _buildLoadingOverlay(_style),
        ],
      ),
    );
  }

  Widget _buildAvatarContent(double diameter, LeadingAvatarStyle style) {
    if (widget.thumbnailUrl != null) {
      return ClipOval(
        key: ValueKey('remote:${widget.thumbnailUrl?.hashCode}'),
        child: _remoteImage(diameter, style),
      );
    } else if (widget.thumbnail != null) {
      return const ClipOval(
        key: ValueKey('local'),
        child: _LocalImage(),
      );
    } else {
      return ClipOval(
        key: ValueKey('placeholder:${widget.username ?? ""}'),
        child: _placeholder(diameter, style),
      );
    }
  }

  Widget _buildLoadingOverlay(LeadingAvatarStyle style) {
    final hasAvatarData = widget.username != null || (widget.thumbnail != null || widget.thumbnailUrl != null);

    final padding = widget.loadingPadding ?? style.loadingOverlay?.padding ?? EdgeInsets.zero;
    final strokeWidth = style.loadingOverlay?.strokeWidth ?? 1.0;

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
                child: CircularProgressIndicator(strokeWidth: strokeWidth),
              ),
            ),
    );
  }

  Widget _remoteImage(double diameter, LeadingAvatarStyle style) {
    return SafeNetworkImage(
      widget.thumbnailUrl.toString(),
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

    if (username != null) {
      final defaultTs = TextStyle(
        fontSize: diameter * 0.35,
        fontWeight: FontWeight.bold,
      );

      return Center(
        child: Text(
          username.initialism,
          softWrap: false,
          overflow: TextOverflow.fade,
          textAlign: TextAlign.center,
          style: defaultTs.merge(style.initialsTextStyle),
        ),
      );
    }

    return Icon(icon, size: diameter * 0.5);
  }

  Widget _registeredIndicator(LeadingAvatarStyle style) {
    final registered = widget.registered!;
    final rs = Theme.of(context).extension<RegisteredStatusStyles>()?.primary;

    final color = registered
        ? (style.registeredBadge?.registeredColor ?? rs?.registered)
        : (style.registeredBadge?.unregisteredColor ?? rs?.unregistered);

    return Container(decoration: BoxDecoration(shape: BoxShape.circle, color: color));
  }

  Widget _smartIndicator(double diameter, LeadingAvatarStyle style, ColorScheme scheme) {
    final bg = style.smartIndicator?.backgroundColor ?? scheme.surfaceContainerLowest;
    final icon = style.smartIndicator?.icon ?? Icons.person;
    final sizeFactor = style.smartIndicator?.sizeFactor ?? 0.4;

    return CircleAvatar(
      backgroundColor: bg,
      child: Icon(icon, size: diameter * sizeFactor * 0.9),
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
