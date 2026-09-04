import 'package:flutter/material.dart';

/// Picks which of a screen's two arrangements to show.
///
/// The one place where the adaptation axis is decided: today the axis is the
/// window orientation, read from the ambient [MediaQuery]. Should it ever
/// change - say, window size classes once tablet arrangements exist - only
/// this widget changes, and every screen that selects an arrangement through
/// it follows.
///
/// The screen using it stays the owner of both arrangements; this widget only
/// switches between them, and rebuilds exactly when the orientation flips.
class OrientationLayoutSelector extends StatelessWidget {
  const OrientationLayoutSelector({super.key, required this.portrait, required this.landscape});

  /// The arrangement for an upright window.
  final Widget portrait;

  /// The arrangement for a window lying down.
  final Widget landscape;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.portrait ? portrait : landscape;
  }
}
