import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/mocks/mocks.dart';

class CallScreenScreenshot extends StatefulWidget {
  const CallScreenScreenshot({
    super.key,
    required this.video,
  });

  final bool video;

  @override
  State<CallScreenScreenshot> createState() => _CallScreenScreenshotState();
}

class _CallScreenScreenshotState extends State<CallScreenScreenshot> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (!mounted) {
        return;
      }

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, __) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<CallBloc>(
                  create: (context) => MockCallBloc.callScreen(widget.video),
                ),
              ],
              child: CallScreen(
                localePlaceholderBuilder: (context) => Image.network(
                  'https://dummyimage.com/600x800/00e326/fff.jpg&text=locale',
                  fit: BoxFit.fitHeight,
                ),
                remotePlaceholderBuilder: (context) => Image.network(
                  'https://dummyimage.com/600x800/0048e3/fff.jpg&text=remote',
                  fit: BoxFit.cover,
                ),
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
