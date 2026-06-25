/// How the pull of a video call is handled (resolved app-runtime value).
enum CallPullVideoStrategy {
  /// Default. Video calls stay pullable and the pull offer carries a recvonly
  /// video m-line so it matches the server's video answer. No backend dependency.
  softMute,

  /// Video calls are excluded from the pull list. Requires the backend to report
  /// media type via dialog-info `has_video`.
  hideVideo,

  /// The pull mirrors the real media: a video dialog is pulled as a video call
  /// (the offer carries a real, camera-backed video m-line), an audio dialog as
  /// audio. Requires the backend to report media type via dialog-info `has_video`
  /// and relies on the server answering a matching video answer. Unlike softMute,
  /// it opens the local camera on pull of a video call.
  mirror;

  /// Parses a configurator/Remote-Config string (by enum name) into a strategy,
  /// or null when unknown/absent.
  static CallPullVideoStrategy? tryParse(String? name) {
    if (name == null) return null;
    for (final value in CallPullVideoStrategy.values) {
      if (value.name == name) return value;
    }
    return null;
  }
}
