import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

extension RTCVideoViewObjectFitExtensions on RTCVideoViewObjectFit {
  bool get isCover => this == RTCVideoViewObjectFit.RTCVideoViewObjectFitCover;

  bool get isContain => this == RTCVideoViewObjectFit.RTCVideoViewObjectFitContain;

  /// Returns the label describing the action to be taken (e.g., if currently Contain, label is 'Cover').
  String get actionLabel => isContain ? 'Cover' : 'Fit';

  IconData get toggleIcon => isCover ? Icons.zoom_in_map : Icons.zoom_out_map;

  RTCVideoViewObjectFit get toggled =>
      isCover ? RTCVideoViewObjectFit.RTCVideoViewObjectFitContain : RTCVideoViewObjectFit.RTCVideoViewObjectFitCover;
}
