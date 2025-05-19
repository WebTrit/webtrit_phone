import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../system_notifications.dart';

@RoutePage()
class SystemNotificationsPage extends StatelessWidget {
  const SystemNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SystemNotificationsScreen();
  }
}
