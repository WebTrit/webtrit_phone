import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

class StreamImage extends StatelessWidget {
  const StreamImage({
    super.key,
    required this.stream,
    this.width,
    this.height,
  });

  final Stream<SvgLoader?>? stream;

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return StreamBuilder<SvgLoader?>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<SvgLoader?> snapshot) {
        if (snapshot.hasError) {
          return SizedBox(
            height: height,
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return SizedBox(
              height: height,
            );
          case ConnectionState.waiting:
            return SizedCircularProgressIndicator(
              size: themeData.textTheme.bodyMedium!.fontSize!,
              strokeWidth: 2,
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.data != null) {
              return SvgPicture(
                snapshot.data!,
                height: height,
                width: width,
              );
            } else {
              return SizedBox(
                height: height,
              );
            }
        }
      },
    );
  }
}
