import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

class LeadingAvatar extends StatelessWidget {
  const LeadingAvatar({
    super.key,
    required this.username,
    this.placeholderIcon = Icons.person_outline,
    this.radius,
    this.minRadius,
    this.maxRadius,
  });

  final String? username;
  final IconData placeholderIcon;

  final double? radius;
  final double? minRadius;
  final double? maxRadius;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final username = this.username;
    return CircleAvatar(
      radius: radius,
      minRadius: minRadius,
      maxRadius: maxRadius,
      backgroundColor: themeData.colorScheme.secondaryContainer,
      foregroundColor: themeData.colorScheme.onSecondaryContainer,
      child: username != null
          ? Text(
              username.initialism,
              softWrap: false,
              overflow: TextOverflow.fade,
            )
          : Icon(
              placeholderIcon,
            ),
    );
  }
}
