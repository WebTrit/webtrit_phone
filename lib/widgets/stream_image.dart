import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:webtrit_phone/theme/theme.dart';

class StreamImage extends StatelessWidget {
  const StreamImage({
    super.key,
    required this.stream,
    this.width,
    this.height,
  });

  final SvgNotifier? stream;

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: stream!,
      builder: (BuildContext context, Widget? child) {
        if (stream?.svg != null) {
          return SvgPicture(
            stream!.svg!,
            height: height,
            width: width,
          );
        } else {
          return SizedBox(
            height: height,
          );
        }
      },
    );
  }
}
