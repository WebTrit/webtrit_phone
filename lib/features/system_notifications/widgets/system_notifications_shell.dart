import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';

import 'package:webtrit_phone/app/constants.dart';
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
  late final localRepository = context.read<SystemNotificationsLocalRepository>();
  late final remoteRepository = context.read<SystemNotificationsRemoteRepository>();
  late final remotePushRepository = context.read<RemotePushRepository>();
  late final localPushRepository = context.read<LocalPushRepository>();

  late final featureAceess = FeatureAccess();
  late final feature = featureAceess.systemNotificationsFeature;
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
    final featureEnabled = feature.systemNotificationsSupport;
    final pushSupported = feature.systemNotificationsPushSupport;
    final appState = appLifecycle.getLifecycleState();

    if (featureEnabled == true) {
      pushService ??= SystemNotificationsPushService(
        remotePushRepository,
        localPushRepository,
        localRepository,
        openNotifications: openNotificationsScreen,
      )..init();

      /// If push supported, init sync and outbox workers as normal
      if (pushSupported == true) {
        syncWorker ??= SystemNotificationsSyncWorker(localRepository, remoteRepository)..init();
        outboxWorker ??= SystemNotificationsOutboxWorker(localRepository, remoteRepository)..init();
      }

      /// If push not supported, register background worker
      /// that will fetch and produces push for new system notifications in background
      if (pushSupported == false) {
        Workmanager().registerPeriodicTask(
          kSystemNotificationsTaskId,
          kSystemNotificationsTask,
          constraints: Constraints(networkType: NetworkType.connected),
          existingWorkPolicy: ExistingWorkPolicy.keep,
          backoffPolicy: BackoffPolicy.linear,
          initialDelay: const Duration(seconds: 30),
        );

        /// Actively suspend/resume sync workers on app lifecycle changes
        /// To avoid inconsistency beetween foreground - background workers
        ///
        /// Background worker will also suspended itself but
        /// on task execution level, so no need to dispose it actively
        if (appState == AppLifecycleState.resumed) {
          syncWorker ??= SystemNotificationsSyncWorker(localRepository, remoteRepository)..init();
          outboxWorker ??= SystemNotificationsOutboxWorker(localRepository, remoteRepository)..init();
        } else {
          syncWorker?.dispose();
          syncWorker = null;

          outboxWorker?.dispose();
          outboxWorker = null;
        }
      }
    } else {
      pushService?.dispose();
      pushService = null;

      syncWorker?.dispose();
      syncWorker = null;

      outboxWorker?.dispose();
      outboxWorker = null;

      Workmanager().cancelByUniqueName(kSystemNotificationsTask);
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
    syncWorker?.dispose();
    outboxWorker?.dispose();
    Workmanager().cancelByUniqueName(kSystemNotificationsTask);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
