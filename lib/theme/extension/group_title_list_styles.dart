import 'package:flutter/material.dart';

import '../style/style.dart';

class GroupTitleListStyles extends ThemeExtension<GroupTitleListStyles> {
  const GroupTitleListStyles({
    required this.primary,
  });

  final GroutTitleListStyle? primary;

  @override
  ThemeExtension<GroupTitleListStyles> copyWith({
    GroutTitleListStyle? primary,
  }) {
    return GroupTitleListStyles(
      primary: primary ?? this.primary,
    );
  }

  @override
  ThemeExtension<GroupTitleListStyles> lerp(ThemeExtension<GroupTitleListStyles>? other, double t) {
    if (other == null || primary == null || other is! GroupTitleListStyles) {
      return this;
    }

    return GroupTitleListStyles(primary: GroutTitleListStyle.lerp(primary, other.primary, t));
  }
}
