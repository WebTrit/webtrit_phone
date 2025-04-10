import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import 'package:webtrit_phone/extensions/duration.dart';

class AudioRecorderBottomSheet extends StatefulWidget {
  const AudioRecorderBottomSheet({super.key});

  @override
  State<AudioRecorderBottomSheet> createState() => _AudioRecorderBottomSheetState();
}

class _AudioRecorderBottomSheetState extends State<AudioRecorderBottomSheet> with SingleTickerProviderStateMixin {
  late final record = AudioRecorder();
  late final refreshTicker = createTicker((_) => setState(() {}));
  DateTime? startTime;

  @override
  initState() {
    super.initState();
    refreshTicker.start();
    onRecord();
  }

  onRecord() {
    record.hasPermission().then((value) async {
      if (!mounted) return;
      if (value == false) {
        showCupertinoDialog(
          context: context,
          builder: (ctx) => const AlertDialog(
            title: Text('Permission denied'),
            content: Text('Please allow microphone access in settings'),
          ),
        );
      } else {
        final dir = await getTemporaryDirectory();
        final time = DateTime.now().millisecondsSinceEpoch;
        final path = '${dir.path}/rec_$time.m4a';
        File(path).createSync(recursive: true);
        const recordConfig = RecordConfig(
          numChannels: 1,
          autoGain: true,
          echoCancel: true,
          noiseSuppress: true,
        );
        await record.start(recordConfig, path: path);
        setState(() => startTime = DateTime.now());
      }
    });
  }

  onStop() async {
    final path = await record.stop();
    if (!mounted) return;
    context.router.maybePop(path);
  }

  onCancel() async {
    await record.cancel();
    if (!mounted) return;
    context.router.maybePop();
  }

  @override
  void dispose() {
    refreshTicker.dispose();
    super.dispose();
    record.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: 220,
      width: MediaQuery.of(context).size.width - 32,
      decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          )),
      // color: Colors.white,
      child: Column(
        spacing: 16,
        children: [
          const SizedBox(height: 8),
          IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.mic,
              size: 64,
              color: startTime == null ? Colors.grey.shade400 : colorScheme.secondary,
            ),
            onPressed: () {
              if (startTime == null) {
                onRecord();
              } else {
                onStop();
              }
            },
          ),
          if (startTime != null) ...[
            SizedBox(
              width: 70,
              child: Text(
                DateTime.now().difference(startTime!).toHMSMs(),
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
                softWrap: false,
                overflow: TextOverflow.fade,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.check_circle_rounded, size: 48),
                  color: colorScheme.primary,
                  onPressed: onStop,
                ),
                const SizedBox(width: 32),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.cancel, size: 48),
                  color: Colors.red,
                  onPressed: onCancel,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
