import 'package:flutter/material.dart';
import 'package:webtrit_phone/features/settings/widgets/group_title_list_tile.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class GroupTitleListStyleFactory implements ThemeStyleFactory<GroupTitleListStyles> {
  GroupTitleListStyleFactory(this.colors, this.config);

  final ColorScheme colors;
  final GroupTitleListTileWidgetConfig? config;

  @override
  GroupTitleListStyles create() {
    final backgroundColor = config?.backgroundColor?.toColor() ?? colors.surface;

    final textStyle = config?.textStyle?.toTextStyle();

    return GroupTitleListStyles(
      primary: GroutTitleListStyle(textStyle: textStyle, background: backgroundColor),
    );
  }
}
