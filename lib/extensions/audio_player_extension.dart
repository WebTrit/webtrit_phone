import 'package:just_audio/just_audio.dart';

extension AudioPlayerExtension on AudioPlayer {
  /// Stops playback and safely disposes the player.
  ///
  /// This method is intended to avoid race conditions or crashes that may occur
  /// when `dispose` is called while the player is still active.
  /// See: https://github.com/ryanheise/just_audio/issues/1428
  Future<void> stopAndDispose() async {
    await stop();
    await dispose();
  }
}
