import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/mocks/mocks.dart';

class CallScreenScreenshot extends StatefulWidget {
  const CallScreenScreenshot(
    this.video, {
    super.key,
    this.localePlaceholderImageUrl = 'https://dummyimage.com/600x800/00e326/fff.jpg&text=locale',
    this.remotePlaceholderImageUrl = 'https://dummyimage.com/600x800/0048e3/fff.jpg&text=remote',
  });

  final bool video;
  final String localePlaceholderImageUrl;
  final String remotePlaceholderImageUrl;

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
                  widget.localePlaceholderImageUrl,
                  fit: BoxFit.fitHeight,
                ),
                remotePlaceholderBuilder: (context) => Image.network(
                  widget.remotePlaceholderImageUrl,
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
