import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/settings/widgets/group_title_list_style.dart';

class GroupTitleListStyles extends ThemeExtension<GroupTitleListStyles> {
  const GroupTitleListStyles({required this.primary});

  final GroupTitleListStyle? primary;

  @override
  ThemeExtension<GroupTitleListStyles> copyWith({GroupTitleListStyle? primary}) {
    return GroupTitleListStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<GroupTitleListStyles> lerp(ThemeExtension<GroupTitleListStyles>? other, double t) {
    if (other == null || primary == null || other is! GroupTitleListStyles) {
      return this;
    }

    return GroupTitleListStyles(primary: GroupTitleListStyle.lerp(primary, other.primary, t));
  }
}
