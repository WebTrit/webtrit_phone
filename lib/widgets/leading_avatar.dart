import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';

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
  });

  final String? username;
  final Uint8List? thumbnail;
  final Uri? thumbnailUrl;
  final IconData placeholderIcon;
  final bool? registered;
  final bool smart;
  final double radius;

  @override
  State<LeadingAvatar> createState() => _LeadingAvatarState();
}

class _LeadingAvatarState extends State<LeadingAvatar> {
  bool _imageLoadFailed = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;

    final diameter = widget.radius * 2;
    final foregroundImage = _getImageProvider();

    final registeredStatusStyle = themeData.extension<RegisteredStatusStyles>()!.primary;

    return SizedBox(
      width: diameter,
      height: diameter,
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: widget.radius,
              backgroundColor: colorScheme.secondaryContainer,
              foregroundColor: colorScheme.onSecondaryContainer,
              foregroundImage: foregroundImage,
              // Conditionally set onForegroundImageError
              onForegroundImageError: foregroundImage != null
                  ? (_, __) {
                      setState(() {
                        _imageLoadFailed = true;
                      });
                    }
                  : null,
              child: _LeadingForegroundWidget(
                username: widget.username,
                foregroundImage: foregroundImage,
                placeholderIcon: widget.placeholderIcon,
              ),
            ),
            if (widget.smart) _SmartIndicator(diameter: diameter, colorScheme: colorScheme),
            if (widget.registered != null)
              _RegisteredIndicator(
                diameter: diameter,
                registered: widget.registered!,
                registeredStatusStyle: registeredStatusStyle,
              ),
          ],
        ),
      ),
    );
  }

  ImageProvider? _getImageProvider() {
    if (_imageLoadFailed) {
      return null;
    }
    if (widget.thumbnail != null) {
      return MemoryImage(widget.thumbnail!);
    } else if (widget.thumbnailUrl != null) {
      return NetworkImage(widget.thumbnailUrl.toString());
    }
    return null;
  }
}

class _LeadingForegroundWidget extends StatelessWidget {
  const _LeadingForegroundWidget({
    required this.username,
    required this.foregroundImage,
    required this.placeholderIcon,
  });

  final String? username;
  final ImageProvider? foregroundImage;
  final IconData placeholderIcon;

  @override
  Widget build(BuildContext context) {
    if (foregroundImage != null) return const SizedBox.shrink();

    if (username != null) {
      return Text(
        username!.initialism,
        softWrap: false,
        overflow: TextOverflow.fade,
      );
    }
    return Icon(placeholderIcon);
  }
}

class _SmartIndicator extends StatelessWidget {
  const _SmartIndicator({
    required this.diameter,
    required this.colorScheme,
  });

  final double diameter;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: diameter * -0.1,
      bottom: diameter * -0.1,
      width: diameter * 0.4,
      height: diameter * 0.4,
      child: CircleAvatar(
        backgroundColor: colorScheme.surfaceContainerLowest,
        child: Icon(
          Icons.person,
          size: diameter * 0.4 * 0.9,
        ),
      ),
    );
  }
}

class _RegisteredIndicator extends StatelessWidget {
  const _RegisteredIndicator({
    required this.diameter,
    required this.registered,
    required this.registeredStatusStyle,
  });

  final double diameter;
  final bool registered;

  final RegisteredStatusStyle registeredStatusStyle;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      width: diameter * 0.2,
      height: diameter * 0.2,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: registered ? registeredStatusStyle.registered : registeredStatusStyle.unregistered,
        ),
      ),
    );
  }
}
