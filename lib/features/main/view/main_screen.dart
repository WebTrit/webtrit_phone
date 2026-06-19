import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key, required this.body, required this.bottomNavigationBar})
    : super(key: key ?? const ValueKey<String>('MainScreen'));

  final Widget body;
  final BottomNavigationBar bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body, bottomNavigationBar: bottomNavigationBar);
  }
}
