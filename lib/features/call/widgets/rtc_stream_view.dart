import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

class RTCStreamView extends StatefulWidget {
  const RTCStreamView({required this.stream, this.mirror = false, this.placeholderBuilder, super.key});

  final MediaStream? stream;
  final bool mirror;
  final Widget Function(BuildContext)? placeholderBuilder;

  @override
  State<RTCStreamView> createState() => _RTCStreamViewState();
}

class _RTCStreamViewState extends State<RTCStreamView> {
  late final RTCVideoRenderer renderer = RTCVideoRenderer();

  @override
  initState() {
    super.initState();
    renderer.initialize().then((value) {
      if (!mounted) return;
      renderer.srcObject = widget.stream;
    });
  }

  @override
  dispose() {
    super.dispose();
    renderer.srcObject = null;
    renderer.dispose();
  }

  @override
  didUpdateWidget(RTCStreamView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.stream != widget.stream) {
      renderer.srcObject = widget.stream;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RTCVideoView(renderer, mirror: widget.mirror, placeholderBuilder: widget.placeholderBuilder);
  }
}
