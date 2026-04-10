import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/styles/styles.dart';

class GroupAvatar extends StatelessWidget {
  const GroupAvatar({super.key, required this.name, this.size = 24, this.style});

  final String name;
  final double size;
  final LeadingAvatarStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeStyle = theme.extension<LeadingAvatarStyles>()?.primary;
    final effectiveStyle = LeadingAvatarStyle.merge(themeStyle, style);

    final backgroundColor = effectiveStyle.backgroundColor ?? theme.colorScheme.secondaryContainer;
    final initialsStyle = effectiveStyle.initialsTextStyle;

    return SizedBox(
      width: size * 2,
      height: size * 2,
      child: Card(
        margin: EdgeInsets.zero,
        shape: const CircleBorder(),
        color: backgroundColor,
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.all(size * 0.2),
          child: Center(
            child: FittedBox(
              child: Text(
                _formatName(name).toUpperCase(),
                softWrap: true,
                textAlign: TextAlign.center,
                style: initialsStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatName(String rawName) {
    final segments = rawName.split(' ');

    final truncatedSegments = segments.map(_truncateSegment).toList();

    final limitedSegments = truncatedSegments.length > 3 ? truncatedSegments.sublist(0, 3) : truncatedSegments;

    final text = limitedSegments.join('\n');
    return text.isEmpty ? ' ' : text;
  }

  String _truncateSegment(String segment) => segment.length > 8 ? segment.substring(0, 8) : segment;
}
