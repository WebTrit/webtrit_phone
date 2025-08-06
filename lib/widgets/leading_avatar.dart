import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';

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
    this.loadingPadding = const EdgeInsets.all(2),
  });

  final String? username;
  final Uint8List? thumbnail;
  final Uri? thumbnailUrl;
  final IconData placeholderIcon;
  final bool? registered;
  final bool smart;
  final double radius;
  final bool showLoading;
  final EdgeInsets loadingPadding;

  @override
  State<LeadingAvatar> createState() => _LeadingAvatarState();
}

class _LeadingAvatarState extends State<LeadingAvatar> {
  late final diameter = widget.radius * 2;
  late final registeredPosition = Rect.fromLTWH(diameter * 0.8, diameter * 0.8, diameter * 0.2, diameter * 0.2);
  late final smartPosition = Rect.fromLTWH(diameter * -0.1, diameter * -0.1, diameter * 0.4, diameter * 0.4);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;

    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorScheme.secondaryContainer,
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
              child: _buildAvatarContent(),
            ),
          ),
          if (widget.smart)
            Positioned.fromRect(rect: smartPosition, child: smartIndicator())
          else if (widget.registered != null)
            Positioned.fromRect(rect: registeredPosition, child: registeredIndicator()),
          if (widget.showLoading) _buildLoadingOverlay(context),
        ],
      ),
    );
  }

  Widget _buildAvatarContent() {
    if (widget.thumbnailUrl != null) {
      return ClipOval(
        key: ValueKey('remote:${widget.thumbnailUrl}'),
        child: remoteImage(),
      );
    } else if (widget.thumbnail != null) {
      return ClipOval(
        key: const ValueKey('local'),
        child: localImage(),
      );
    } else {
      return ClipOval(
        key: const ValueKey('placeholder'),
        child: placeholder(),
      );
    }
  }

  Widget _buildLoadingOverlay(BuildContext context) {
    final hasAvatarData = widget.username != null && (widget.thumbnail != null || widget.thumbnailUrl != null);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: hasAvatarData
          // Hide loading indicator if avatar data is available
          ? const SizedBox.shrink()
          // Show loading indicator if avatar data is missing
          : SizedBox(
              key: const ValueKey('loading'),
              width: kMinInteractiveDimension,
              height: kMinInteractiveDimension,
              child: Padding(
                padding: widget.loadingPadding,
                child: const CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              ),
            ),
    );
  }

  Widget remoteImage() {
    return SafeNetworkImage(
      widget.thumbnailUrl.toString(),
      fit: BoxFit.cover,
      placeholderBuilder: placeholder,
      errorBuilder: () {
        if (widget.thumbnail != null) return localImage();
        return placeholder();
      },
    );
  }

  Widget localImage() {
    return Image.memory(
      widget.thumbnail!,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => placeholder(),
    );
  }

  Widget placeholder() {
    final username = widget.username;
    final placeholderIcon = widget.placeholderIcon;
    return username != null
        ? Center(
            child: Text(
              username.initialism,
              softWrap: false,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: diameter * 0.35,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : Icon(placeholderIcon, size: diameter * 0.5);
  }

  Widget registeredIndicator() {
    final themeData = Theme.of(context);
    final registeredStatusStyle = themeData.extension<RegisteredStatusStyles>()!.primary;

    final registered = widget.registered!;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: registered ? registeredStatusStyle.registered : registeredStatusStyle.unregistered,
      ),
    );
  }

  Widget smartIndicator() {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;

    return CircleAvatar(
      backgroundColor: colorScheme.surfaceContainerLowest,
      child: Icon(Icons.person, size: diameter * 0.4 * 0.9),
    );
  }
}
