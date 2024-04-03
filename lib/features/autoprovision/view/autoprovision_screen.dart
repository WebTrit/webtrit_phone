import 'package:flutter/material.dart';

class AutoprovisionScreen extends StatelessWidget {
  const AutoprovisionScreen({required this.configToken, super.key});

  final String configToken;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(configToken));
  }
}
