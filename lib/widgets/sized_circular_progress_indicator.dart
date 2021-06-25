import 'package:flutter/material.dart';

class SizedCircularProgressIndicator extends StatelessWidget {
  const SizedCircularProgressIndicator({
    Key key,
    @required this.size,
    this.outerSize,
    this.color,
    this.strokeWidth,
  })  : assert(size != null),
        super(key: key);

  final double size;
  final double outerSize;
  final Color color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final result = SizedBox.fromSize(
      size: Size.square(size),
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
    if (outerSize == null) {
      return result;
    } else {
      return SizedBox.fromSize(
        size: Size.square(outerSize),
        child: Center(
          child: result,
        ),
      );
    }
  }
}
