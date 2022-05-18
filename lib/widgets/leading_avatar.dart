import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

class LeadingAvatar extends StatelessWidget {
  const LeadingAvatar({
    Key? key,
    required this.username,
    this.radius,
    this.minRadius,
    this.maxRadius,
  }) : super(key: key);

  final String username;

  final double? radius;
  final double? minRadius;
  final double? maxRadius;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return CircleAvatar(
      radius: radius,
      minRadius: minRadius,
      maxRadius: maxRadius,
      backgroundColor: themeData.colorScheme.secondaryContainer,
      foregroundColor: themeData.colorScheme.onSecondaryContainer,
      child: Text(username.initialism),
    );
  }
}
