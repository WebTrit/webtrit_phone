import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class MessagingRouterPage extends StatefulWidget {
  const MessagingRouterPage({super.key});

  @override
  State<MessagingRouterPage> createState() => _MessagingRouterPageState();
}

class _MessagingRouterPageState extends State<MessagingRouterPage> {
  @override
  Widget build(BuildContext context) {
    return const MessagingStateWrapper(child: AutoRouter());
  }
}
