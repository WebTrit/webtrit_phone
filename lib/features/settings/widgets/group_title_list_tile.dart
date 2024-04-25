import 'package:flutter/material.dart';

import 'group_title_list_style.dart';
import 'group_title_list_styles.dart';

export 'group_title_list_style.dart';
export 'group_title_list_styles.dart';

class GroupTitleListTile extends StatelessWidget {
  const GroupTitleListTile({
    super.key,
    required this.titleData,
    this.style,
  });

  final String titleData;

  final GroutTitleListStyle? style;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final localStyle = style ?? themeData.extension<GroupTitleListStyles>()?.primary;

    return Container(
      color: localStyle?.background ?? Colors.transparent,
      child: ListTile(
        title: Text(
          titleData,
          style: themeData.textTheme.bodyMedium?.merge(localStyle?.textStyle),
        ),
        tileColor: themeData.colorScheme.surface,
      ),
    );
  }
}
