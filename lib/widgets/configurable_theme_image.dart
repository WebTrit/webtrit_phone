import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../theme/styles/theme_image_style.dart';

class ConfigurableThemeImage extends StatelessWidget {
  const ConfigurableThemeImage({super.key, this.style, this.defaultScale = 0.5});

  final ThemeImageStyle? style;

  /// Used when [style.widthFactor] is null.
  final double defaultScale;

  @override
  Widget build(BuildContext context) {
    final asset = style?.picture;
    if (asset == null) return const SizedBox.shrink();

    final mediaQuery = MediaQuery.of(context);
    final widthFactor = style?.widthFactor ?? defaultScale;
    final imageWidth = mediaQuery.size.width * widthFactor;
    final imageHeight = style?.heightFactor != null ? mediaQuery.size.height * style!.heightFactor! : null;

    final svg = asset.svg(
      width: imageWidth,
      height: imageHeight,
      fit: style?.fit ?? BoxFit.contain,
      alignment: Alignment.center,
    );

    final content = style?.color != null
        ? ColorFiltered(colorFilter: ColorFilter.mode(style!.color!, style!.blendMode ?? BlendMode.srcIn), child: svg)
        : svg;

    final borderRadius = style?.borderRadius;

    final wrapper = Container(
      padding: style?.padding ?? EdgeInsets.zero,
      decoration: BoxDecoration(color: style?.backgroundColor, borderRadius: borderRadius),
      child: borderRadius != null ? ClipRRect(borderRadius: borderRadius, child: content) : content,
    );

    if (style?.alignment != null) {
      return Align(alignment: style!.alignment!, child: wrapper);
    }

    return wrapper;
  }
}
