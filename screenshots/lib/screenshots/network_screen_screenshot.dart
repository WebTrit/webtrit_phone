import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/settings/features/network/bloc/network_cubit.dart';
import 'package:webtrit_phone/features/settings/features/network/view/network_screen.dart';

import 'package:screenshots/mocks/mocks.dart';

class NetworkScreenScreenshot extends StatefulWidget {
  const NetworkScreenScreenshot({super.key});

  @override
  State<NetworkScreenScreenshot> createState() => _NetworkScreenScreenshotState();
}

class _NetworkScreenScreenshotState extends State<NetworkScreenScreenshot> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (!mounted) return;

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, __) {
            return BlocProvider<NetworkCubit>(
              create: (_) => MockNetworkCubit.initial(),
              child: const NetworkScreen(),
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
