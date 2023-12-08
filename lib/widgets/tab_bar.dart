import 'package:flutter/material.dart';

class ExtTabBar extends StatelessWidget {
  const ExtTabBar({
    super.key,
    this.width,
    this.height,
    required this.tabs,
    this.controller,
  });

  final double? width;
  final double? height;
  final List<Widget> tabs;
  final TabController? controller;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final height = this.height;
    final borderRadius = height == null ? null : BorderRadius.circular(height / 2);
    return SizedBox(
      width: width,
      height: height,
      child: TabBar(
        tabs: tabs,
        controller: controller,
        indicator: BoxDecoration(
          borderRadius: borderRadius,
          color: themeData.colorScheme.primary,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: themeData.colorScheme.onPrimary,
        unselectedLabelColor: themeData.colorScheme.onSurface,
        splashBorderRadius: borderRadius,
      ),
    );
  }
}
