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
          if (widget.thumbnailUrl != null)
            Positioned.fill(child: ClipOval(child: remoteImage()))
          else if (widget.thumbnail != null)
            Positioned.fill(child: ClipOval(child: localImage()))
          else
            Positioned.fill(child: placeholder()),
          if (widget.smart)
            Positioned.fromRect(rect: smartPosition, child: smartIndicator())
          else if (widget.registered != null)
            Positioned.fromRect(rect: registeredPosition, child: registeredIndicator()),
        ],
      ),
    );
  }

  Widget remoteImage() {
    return Image.network(
      widget.thumbnailUrl.toString(),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
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
