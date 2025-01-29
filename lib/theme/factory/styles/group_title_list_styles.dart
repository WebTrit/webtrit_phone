import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class GroupTitleListStyleFactory implements ThemeStyleFactory<GroupTitleListStyles> {
  GroupTitleListStyleFactory(this.config);

  final GroupTitleListTileWidgetConfig? config;

  @override
  GroupTitleListStyles create() {
    final textColor = config?.textColor?.toColor();
    final backgroundColor = config?.backgroundColor?.toColor();

    final textStyle = TextStyle(
      color: textColor,
    );

    return GroupTitleListStyles(
      primary: GroutTitleListStyle(
        textStyle: textStyle,
        background: backgroundColor,
      ),
    );
  }
}
