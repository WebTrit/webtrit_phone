import 'package:collection/collection.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

extension CallLineLogsExtension on Iterable<Line?> {
  /// Finds the first event of type [T] inside the CallEventLog wrappers.
  T? findEvent<T extends CallEvent>(String callId) {
    // Find the correct line
    final line = firstWhereOrNull((it) => it?.callId == callId);
    if (line == null) return null;

    // Look through callLogs, find CallEventLogs, and check the inner event type
    return line.callLogs.whereType<CallEventLog>().map((log) => log.callEvent).whereType<T>().firstOrNull;
  }
}

extension IncomingCallVideoExtension on IncomingCallEvent {
  /// Returns true if the JSEP payload contains a video media description.
  bool get isVideo {
    final sdp = jsep?['sdp'] as String?;
    if (sdp == null) return false;

    // m=video is the standard SDP prefix for video streams
    return sdp.contains('m=video');
  }
}
