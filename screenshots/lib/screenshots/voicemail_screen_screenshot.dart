import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/features/settings/features/voicemail/bloc/voicemail_cubit.dart';
import 'package:webtrit_phone/features/settings/features/voicemail/models/voicemail_screen_context.dart';
import 'package:webtrit_phone/features/settings/features/voicemail/view/voicemail_screen.dart';

import 'package:screenshots/mocks/mocks.dart';

class VoicemailScreenScreenshot extends StatefulWidget {
  const VoicemailScreenScreenshot({super.key});

  @override
  State<VoicemailScreenScreenshot> createState() => _VoicemailScreenScreenshotState();
}

class _VoicemailScreenScreenshotState extends State<VoicemailScreenScreenshot> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (!mounted) return;

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, __) {
            return Provider<VoicemailScreenContext>(
              create: (_) => VoicemailScreenContext(
                mediaCacheBasePath: '/tmp/screenshots_cache',
                dateFormat: DateFormat.yMMMd().add_Hm(),
                mediaHeaders: const {},
              ),
              child: BlocProvider<VoicemailCubit>(
                create: (_) => MockVoicemailCubit.withItems(),
                child: const VoicemailScreen(),
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
