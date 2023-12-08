import 'package:flutter/material.dart';

class ListTileSeparator extends StatelessWidget {
  const ListTileSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      indent: 15,
      endIndent: 15,
    );
  }
}
