import 'package:flutter/material.dart';

import 'package:webtrit_phone/styles/styles.dart';

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
    return CircleAvatar(
      radius: radius,
      minRadius: minRadius,
      maxRadius: maxRadius,
      backgroundColor: AppColors.darkBlue30,
      foregroundColor: AppColors.darkBlueSecondary,
      child: Text(_usernameInitialism),
    );
  }

  String get _usernameInitialism {
    final username = this.username.trim();
    return username.isEmpty ? '' : username.split(' ').map((v) => v[0]).take(3).join();
  }
}
