import 'package:flutter/material.dart';

class CircularProgressTemplate extends StatelessWidget {
  const CircularProgressTemplate({
    super.key,
    this.color,
    this.size = 20,
    this.width = 4,
  });

  final Color? color;
  final double? size;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(2),
      child: CircularProgressIndicator(color: color, strokeWidth: width),
    );
  }
}
