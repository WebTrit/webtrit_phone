import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

class CallOverlayDialog extends StatefulWidget {
  const CallOverlayDialog({
    super.key,
    required this.createdTime,
    required this.name,
    required this.remoteStream,
    required this.constraints,
    required this.isVideoCall,
    required this.onEndCall,
  });

  final DateTime createdTime;
  final MediaStream? remoteStream;
  final String name;
  final BoxConstraints constraints;
  final bool isVideoCall;
  final Function onEndCall;

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
          return ConstrainedBox(
            constraints: widget.constraints,
            child: Wrap(
              children: [
                Card(
                  color: Theme.of(context).colorScheme.primary,
                  margin: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 16,
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
                              username: widget.name,
                            ),
                      const SizedBox(
                        height: 8,
                      ),
                      DurationTimer(
                        createdTime: widget.createdTime,
                      ),
                      Text(
                        widget.name,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontFeatures: [
                            const FontFeature.tabularFigures(),
                          ],
                          color: Theme.of(context).colorScheme.background,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Divider(
                        color: Colors.white54,
                        height: 0,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => widget.onEndCall.call(),
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    color: Theme.of(context).colorScheme.error,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.call_end_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
