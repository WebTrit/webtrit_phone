import 'dart:ui';

import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key, required this.body, required this.bottomNavigationBar})
    : super(key: key ?? const ValueKey<String>('MainScreen'));

  final Widget body;
  final Widget bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: body,
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), child: bottomNavigationBar),
      ),
    );
  }
}
