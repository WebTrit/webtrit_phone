import 'package:flutter/material.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

/// Extensions for [RTCVideoViewObjectFit] to simplify UI logic and state toggling.
extension RTCVideoViewObjectFitExtensions on RTCVideoViewObjectFit {
  /// Returns `true` if the fit mode is currently set to [RTCVideoViewObjectFit.RTCVideoViewObjectFitCover].
  bool get isCover => this == RTCVideoViewObjectFit.RTCVideoViewObjectFitCover;

  /// Returns `true` if the fit mode is currently set to [RTCVideoViewObjectFit.RTCVideoViewObjectFitContain].
  bool get isContain => this == RTCVideoViewObjectFit.RTCVideoViewObjectFitContain;

  /// Returns the label describing the action to be taken when toggled.
  ///
  /// Example: If currently [isContain], returns 'Cover'.
  String get actionLabel => isContain ? 'Cover' : 'Fit';

  /// Returns the icon representing the action to be taken when toggled.
  ///
  /// Example: If currently [isCover], returns [Icons.zoom_in_map] to indicate switching to contain.
  IconData get actionIcon => isCover ? Icons.zoom_in_map : Icons.zoom_out_map;

  /// Returns the opposite fit mode.
  ///
  /// Switches between [RTCVideoViewObjectFit.RTCVideoViewObjectFitContain] and
  /// [RTCVideoViewObjectFit.RTCVideoViewObjectFitCover].
  RTCVideoViewObjectFit get toggled =>
      isCover ? RTCVideoViewObjectFit.RTCVideoViewObjectFitContain : RTCVideoViewObjectFit.RTCVideoViewObjectFitCover;
}
