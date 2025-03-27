import 'package:flutter/material.dart';

class MediaStaggerWrap extends StatelessWidget {
  const MediaStaggerWrap({
    required this.buildElement,
    required this.count,
    required this.space,
    super.key,
  });

  final Widget Function(int index, double size) buildElement;
  final int count;
  final double space;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(count, (i) => i).map((int index) {
        double width = space;
        if (count == 2) {
          width = width / 2;
        }

        if (count == 3) {
          if (index == 0) {
            width = width;
          } else {
            width = width / 2;
          }
        }

        if (count == 4) {
          if (index == 0) {
            width = width;
          } else {
            width = width / 3;
          }
        }

        if (count > 4) {
          if (index < 2) {
            width = width / 2;
          } else {
            int rest = count - 2;

            if (rest % 5 == 0) {
              width = width / 5;
            } else if (rest % 3 == 0) {
              width = width / 3;
            } else if (rest % 2 == 0) {
              width = width / 4;
            }
          }
        }

        // return imagePreview(attachment, size: width);
        return buildElement(index, width);
      }).toList(),
    );
  }
}
