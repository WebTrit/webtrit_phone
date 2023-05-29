import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

class CallOverlayDialog extends StatefulWidget {
  const CallOverlayDialog({
    super.key,
    required this.createdTime,
    required this.name,
    required this.remoteStream,
    required this.isVideoCall,
    required this.onTap,
  });

  final DateTime createdTime;
  final MediaStream? remoteStream;
  final String name;
  final bool isVideoCall;
  final Function() onTap;

  @override
  State<CallOverlayDialog> createState() => _CallOverlayDialogState();
}

class _CallOverlayDialogState extends State<CallOverlayDialog> {
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  late Future<List<void>> _renderersInitialized;

  @override
  void initState() {
    _renderersInitialized = _renderersInitialize();
    super.initState();
  }

  @override
  void dispose() {
    _renderersDispose();
    super.dispose();
  }

  Future<List<void>> _renderersInitialize() {
    return Future.wait([
      _remoteRenderer.initialize(),
    ]);
  }

  Future<List<void>> _renderersDispose() {
    return Future.wait([
      _remoteRenderer.dispose(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder(
      future: _renderersInitialized,
      builder: (context, AsyncSnapshot<List<void>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _remoteRenderer.srcObject = widget.remoteStream;
          return Card(
            color: Colors.blue,
            margin: EdgeInsets.zero,
            child: InkWell(
              onTap: widget.onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  widget.isVideoCall
                      ? Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.background,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(90),
                            ),
                          ),
                          width: 64,
                          height: 64,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(90.0),
                            child: RTCVideoView(
                              _remoteRenderer,
                              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                            ),
                          ),
                        )
                      : LeadingAvatar(
                          maxRadius: 24,
                          username: widget.name,
                        ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Spacer(),
                  DurationTimer(
                    createdTime: widget.createdTime,
                  ),
                  const Divider(),
                  const Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
