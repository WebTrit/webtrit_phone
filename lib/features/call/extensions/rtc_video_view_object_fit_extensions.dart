import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

extension RTCVideoViewObjectFitExtensions on RTCVideoViewObjectFit {
  bool get isCover => this == RTCVideoViewObjectFit.RTCVideoViewObjectFitCover;

  IconData get toggleIcon => isCover ? Icons.zoom_in_map : Icons.zoom_out_map;

  RTCVideoViewObjectFit get toggled =>
      isCover ? RTCVideoViewObjectFit.RTCVideoViewObjectFitContain : RTCVideoViewObjectFit.RTCVideoViewObjectFitCover;
}
