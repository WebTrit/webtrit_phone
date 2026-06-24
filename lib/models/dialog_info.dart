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

  bool get pullable {
    if (state != DialogState.confirmed) return false;
    if (remoteNumber == null || callId == null || localTag == null || remoteTag == null) return false;
    // Pulling a video call offers audio-only and crashes on the answer's video
    // m-line, so exclude known-video dialogs. Null (unknown) stays pullable to
    // preserve current behaviour until the backend reports media type.
    if (hasVideo == true) return false;
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
