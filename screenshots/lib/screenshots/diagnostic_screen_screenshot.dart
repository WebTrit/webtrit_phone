import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/features/settings/features/diagnostic/bloc/diagnostic_cubit.dart';
import 'package:webtrit_phone/features/settings/features/diagnostic/models/diagnostic_context.dart';
import 'package:webtrit_phone/features/settings/features/diagnostic/view/diagnostic_screen.dart';

import 'package:screenshots/mocks/mocks.dart';

class DiagnosticScreenScreenshot extends StatefulWidget {
  const DiagnosticScreenScreenshot({super.key});

  @override
  State<DiagnosticScreenScreenshot> createState() => _DiagnosticScreenScreenshotState();
}

class _DiagnosticScreenScreenshotState extends State<DiagnosticScreenScreenshot> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (!mounted) return;

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, _) {
            return MultiProvider(
              providers: [
                Provider<DiagnosticScreenContext>(
                  create: (_) => DiagnosticScreenContext(isLocalContactsFeatureEnabled: true),
                ),
              ],
              child: BlocProvider<DiagnosticCubit>(
                create: (_) => MockDiagnosticCubit.initial(),
                child: const DiagnosticScreen(),
              ),
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
