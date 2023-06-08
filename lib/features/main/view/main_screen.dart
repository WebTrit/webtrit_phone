import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import 'mobile/main_screen.dart' as mobile;
import 'web/main_screen.dart' as desktop;

import '../main.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
    required this.body,
    required this.navigationBarFlavor,
    this.onNavigationBarTap,
  }) : super(key: key);

  final Widget body;
  final MainFlavor navigationBarFlavor;
  final ValueChanged<int>? onNavigationBarTap;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobileScreen: mobile.MainScreen(
        key: key,
        body: body,
        navigationBarFlavor: navigationBarFlavor,
        onNavigationBarTap: onNavigationBarTap,
      ),
      desktopScreen: desktop.MainScreen(
        key: key,
        body: body,
        navigationBarFlavor: navigationBarFlavor,
        onNavigationBarTap: onNavigationBarTap,
      ),
    );
  }
}
