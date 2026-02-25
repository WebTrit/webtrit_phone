import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/mocks/mocks.dart';

class PermissionsScreenScreenshot extends StatefulWidget {
  const PermissionsScreenScreenshot({super.key});

  @override
  State<PermissionsScreenScreenshot> createState() => _PermissionsScreenScreenshotState();
}

class _PermissionsScreenScreenshotState extends State<PermissionsScreenScreenshot> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (!mounted) return;

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, __) {
            return BlocProvider<PermissionsCubit>(
              create: (_) => MockPermissionsCubit.initial(),
              child: const PermissionsScreen(),
            );
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          fullscreenDialog: true,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
