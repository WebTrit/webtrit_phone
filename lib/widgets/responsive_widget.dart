import 'package:flutter/material.dart';

import 'package:responsive_framework/responsive_breakpoints.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    Key? key,
    required this.desktopScreen,
    required this.mobileScreen,
  }) : super(key: key);

  final Widget desktopScreen;
  final Widget mobileScreen;

  @override
  Widget build(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).isDesktop) {
      return desktopScreen;
    }

    return mobileScreen;
  }
}
