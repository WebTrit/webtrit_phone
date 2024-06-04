import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

class LeadingAvatar extends StatelessWidget {
  const LeadingAvatar({
    super.key,
    required this.username,
    this.thumbnail,
    this.placeholderIcon = Icons.person_outline,
    this.registered,
    this.smart = false,
    this.radius = 20.0, // value of private _defaultRadius variable in CircleAvatar class
  });

  final String? username;
  final Uint8List? thumbnail;
  final IconData placeholderIcon;
  final bool? registered;
  final bool smart;

  final double radius;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;

    final username = this.username;
    final Uint8List? thumbnail = this.thumbnail;

    final ImageProvider? foregroundImage;
    final Widget? child;

    if (thumbnail != null) {
      foregroundImage = MemoryImage(thumbnail);
      child = null;
    } else {
      foregroundImage = null;
      if (username != null) {
        child = Text(
          username.initialism,
          softWrap: false,
          overflow: TextOverflow.fade,
        );
      } else {
        child = Icon(
          placeholderIcon,
        );
      }
    }

    final bool? registered = this.registered;

    final diameter = radius * 2;

    return SizedBox(
      width: diameter,
      height: diameter,
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: radius,
              backgroundColor: colorScheme.secondaryContainer,
              foregroundColor: colorScheme.onSecondaryContainer,
              foregroundImage: foregroundImage,
              child: child,
            ),
            if (smart)
              Positioned(
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
              ),
            if (registered != null)
              Positioned(
                right: 0,
                bottom: 0,
                width: diameter * 0.2,
                height: diameter * 0.2,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: registered ? colorScheme.tertiary : colorScheme.surface,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
