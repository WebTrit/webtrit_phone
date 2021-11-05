import 'package:flutter/material.dart';

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
      backgroundColor: Colors.blue.shade100,
      child: Text(username.trim().split(' ').map((v) => v[0]).join()),
    );
  }
}
