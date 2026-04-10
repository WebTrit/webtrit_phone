import 'package:flutter/material.dart';

export 'extended_text_style.dart';

import 'package:webtrit_phone/widgets/extended_text_style.dart';

class ExtendedText extends StatelessWidget {
  const ExtendedText(this.data, {super.key, this.extendedStyle, this.textAlign});

  final String data;
  final ExtendedTextStyle? extendedStyle;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final text = Text(data, style: extendedStyle?.textStyle, textAlign: textAlign);

    final decoration = extendedStyle?.decoration;
    if (decoration == null) return text;

    return DecoratedBox(
      decoration: BoxDecoration(color: decoration.color, borderRadius: decoration.borderRadius),
      child: Padding(padding: decoration.padding ?? EdgeInsets.zero, child: text),
    );
  }
}
