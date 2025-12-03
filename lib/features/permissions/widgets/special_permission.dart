import 'package:flutter/material.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../extensions/extensions.dart';

import 'permission_tips.dart';

class SpecialPermission extends StatefulWidget {
  const SpecialPermission({
    super.key,
    required this.specialPermissions,
    required this.onGoToAppSettings,
    required this.onPop,
    required this.onRequestPermission,
  });

  final CallkeepSpecialPermissions specialPermissions;

  final VoidCallback onGoToAppSettings;
  final VoidCallback? onPop;
  final VoidCallback onRequestPermission;

  @override
  State<SpecialPermission> createState() => _SpecialPermissionState();
}

class _SpecialPermissionState extends State<SpecialPermission> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Necessary to re-check the permissions status after the user has potentially
    // modified them in the app settings. The transition to the `resumed` lifecycle state
    // indicates that the user is returning to the app.
    if (state == AppLifecycleState.resumed) widget.onRequestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) return;
      },
      child: Builder(
        builder: (context) {
          switch (widget.specialPermissions) {
            case CallkeepSpecialPermissions.fullScreenIntent:
              return PermissionTips(
                title: context.l10n.permission_manageFullScreenNotificationPermissions,
                instruction: widget.specialPermissions.tips(context),
                onGoToAppSettings: widget.onGoToAppSettings,
                onPop: widget.onPop,
              );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
