import 'package:equatable/equatable.dart';

enum DialogDirection { initiator, recipient }

enum DialogState { trying, proceeding, early, confirmed, terminated, unknown }

class DialogInfo extends Equatable {
  const DialogInfo({
    required this.id,
    required this.entityNumber,
    required this.state,
    required this.callId,
    required this.direction,
    required this.localTag,
    required this.localNumber,
    required this.localDisplayName,
    required this.remoteTag,
    required this.remoteNumber,
    required this.remoteDisplayName,
    required this.arrivalVersion,
    required this.arrivalTime,
    this.hasVideo,
  });

  final String id;
  final String entityNumber;
  final DialogState state;
  final String? callId;
  final DialogDirection? direction;
  final String? localTag;
  final String? localNumber;
  final String? localDisplayName;
  final String? remoteTag;
  final String? remoteNumber;
  final String? remoteDisplayName;
  final String arrivalVersion;
  final DateTime arrivalTime;

  /// Whether the dialog currently has an active video stream. Null when the
  /// backend does not report media type yet (treated as unknown, not audio).
  final bool? hasVideo;

  String? get displayName => remoteDisplayName ?? remoteNumber;

  /// Whether this dialog is a conversation rather than a phone ringing.
  ///
  /// A dialog exists from the first ring, and `early` - ringing - is the most
  /// common state of all in production, so every read site that means "they
  /// are talking to someone" has to say so through this getter. Answering it
  /// on its own is how the status mark and the contact list once ended up
  /// describing the same person differently at the same moment.
  bool get isEstablished => state == DialogState.confirmed;

  bool get pullable {
    if (!isEstablished) return false;
    if (remoteNumber == null || callId == null || localTag == null || remoteTag == null) return false;
    // This getter stays media-agnostic: video calls are pullable as well, and
    // whether a video dialog is offered is decided downstream by the configured
    // CallPullVideoStrategy (see CallPullCubit, which reads `hasVideo`). Under the
    // soft-mute strategy the pull offer carries a video m-line so it matches the
    // server's video answer (no setRemoteDescription m-line mismatch).
    return true;
  }

  @override
  List<Object?> get props => [
    id,
    entityNumber,
    state,
    callId,
    direction,
    localTag,
    localNumber,
    localDisplayName,
    remoteTag,
    remoteNumber,
    remoteDisplayName,
    arrivalVersion,
    arrivalTime,
    hasVideo,
  ];

  @override
  String toString() {
    return 'DialogInfo{id: $id, entityNumber: $entityNumber, state: $state, callId: $callId, direction: $direction, localTag: $localTag, localNumber: $localNumber, localDisplayName: $localDisplayName, remoteTag: $remoteTag, remoteNumber: $remoteNumber, remoteDisplayName: $remoteDisplayName, arrivalVersion: $arrivalVersion, arrivalTime: $arrivalTime, hasVideo: $hasVideo}';
  }
}

extension DialogInfoListExtension on Iterable<DialogInfo> {
  /// The call the contact is actually in, if any.
  ///
  /// Callers get the dialog itself and not just an answer to "are they busy",
  /// because whoever shows the state usually also names the other party.
  DialogInfo? get established {
    for (final dialog in this) {
      if (dialog.isEstablished) return dialog;
    }
    return null;
  }
}
