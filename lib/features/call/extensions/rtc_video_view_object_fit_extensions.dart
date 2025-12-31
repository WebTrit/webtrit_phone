import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

extension RTCVideoViewObjectFitExtensions on RTCVideoViewObjectFit {
  bool get isCover => this == RTCVideoViewObjectFit.RTCVideoViewObjectFitCover;

  bool get isContain => this == RTCVideoViewObjectFit.RTCVideoViewObjectFitContain;

  IconData get toggleIcon => isCover ? Icons.zoom_in_map : Icons.zoom_out_map;

  RTCVideoViewObjectFit get toggled =>
      isCover ? RTCVideoViewObjectFit.RTCVideoViewObjectFitContain : RTCVideoViewObjectFit.RTCVideoViewObjectFitCover;
}
