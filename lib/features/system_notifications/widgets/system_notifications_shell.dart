import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/data/app_lifecycle.dart';
import 'package:webtrit_phone/data/feature_access.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class SystemNotificationsShell extends StatefulWidget {
  const SystemNotificationsShell({required this.child, super.key});

  final Widget child;

  @override
  State<SystemNotificationsShell> createState() => _SystemNotificationsShellState();
}

class _SystemNotificationsShellState extends State<SystemNotificationsShell> {
  late final featureAceess = FeatureAccess();
  late final appLifecycle = AppLifecycle();

  SystemNotificationsPushService? pushService;
  SystemNotificationsSyncWorker? syncWorker;
  SystemNotificationsOutboxWorker? outboxWorker;

  @override
  void initState() {
    super.initState();

    /// Init feature watcher
    Future.doWhile(() async {
      if (!mounted) return false;
      upsertServices();
      return await Future.delayed(const Duration(seconds: 1), () => true);
    });
  }

  upsertServices() {
    const featureEnabled = true; // TODO: integrate feature access
    final appState = appLifecycle.getLifecycleState();

    if (featureEnabled == true) {
      pushService ??= SystemNotificationsPushService(
        context.read<RemotePushRepository>(),
        context.read<LocalPushRepository>(),
        context.read<SystemNotificationsLocalRepository>(),
        openNotifications: openNotificationsScreen,
      )..init();

      // Initialize data sync workers only in foreground
      // If app is in background, [SystemNotificationBackgroundWorker] will be used instead
      if (appState == AppLifecycleState.resumed) {
        syncWorker ??= SystemNotificationsSyncWorker(
          context.read<SystemNotificationsLocalRepository>(),
          context.read<SystemNotificationsRemoteRepository>(),
        )..init();

        outboxWorker ??= SystemNotificationsOutboxWorker(
          context.read<SystemNotificationsLocalRepository>(),
          context.read<SystemNotificationsRemoteRepository>(),
        )..init();
      } else {
        syncWorker?.dispose();
        syncWorker = null;

        outboxWorker?.dispose();
        outboxWorker = null;
      }
    } else {
      pushService?.dispose();
      pushService = null;

      syncWorker?.dispose();
      syncWorker = null;

      outboxWorker?.dispose();
      outboxWorker = null;
    }
  }

  openNotificationsScreen() {
    final alreadyOpened = context.router.topRoute is SystemNotificationsPageRoute;
    if (alreadyOpened) return;
    context.router.push(const SystemNotificationsPageRoute());
  }

  @override
  void dispose() {
    pushService?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
