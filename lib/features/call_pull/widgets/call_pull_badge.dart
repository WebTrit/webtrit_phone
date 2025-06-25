import 'dart:math';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:webtrit_phone/features/call/bloc/call_bloc.dart';
import 'package:webtrit_phone/models/call_pull_dialog.dart';

class CallPullBadge extends StatefulWidget {
  const CallPullBadge({required this.dialogs, super.key});

  final List<CallPullDialog> dialogs;

  @override
  State<CallPullBadge> createState() => _CallPullBadgeState();
}

class _CallPullBadgeState extends State<CallPullBadge> with TickerProviderStateMixin {
  late final controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
    Future.doWhile(() async {
      if (!mounted) return false;
      controller.repeat(max: 0.38, reverse: true, count: 4);
      await Future.delayed(Duration(seconds: 1 + Random().nextInt(5)));
      return true;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onCall() {
    final dialog = widget.dialogs.first;

    final callBloc = context.read<CallBloc>();
    callBloc.add(CallControlEvent.started(
      number: dialog.remoteNumber,
      video: false,
      replaces: '${dialog.callId};from-tag=${dialog.localTag};to-tag=${dialog.remoteTag}',
      displayName: dialog.remoteDisplayName,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;

      final dialog = widget.dialogs.first;
      final name = dialog.remoteDisplayName ?? dialog.remoteNumber;
      final contentColor = colorScheme.onPrimary;

      return Material(
        color: colorScheme.tertiary,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: onCall,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RotationTransition(
                  turns: controller.drive(
                    Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: Curves.elasticInOut)),
                  ),
                  child: Stack(
                    children: [
                      Icon(Icons.call_outlined, size: 16, color: contentColor),
                      Positioned(
                        right: 1,
                        top: 1,
                        child: switch (dialog.direction) {
                          CallPullDialogDirection.initiator => Icon(Icons.call_made, size: 8, color: contentColor),
                          CallPullDialogDirection.recipient => Icon(Icons.call_received, size: 8, color: contentColor),
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  name,
                  style: TextStyle(fontSize: 12, color: contentColor),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
