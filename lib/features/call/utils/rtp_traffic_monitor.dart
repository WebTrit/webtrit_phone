import 'dart:async';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logging/logging.dart';

enum RtpDirection {
  inbound('inbound-rtp'),
  outbound('outbound-rtp');

  const RtpDirection(this.value);

  final String value;

  static RtpDirection? tryParse(String? value) => values.where((e) => e.value == value).firstOrNull;
}

enum MediaKind {
  audio,
  video,
  unknown;

  static MediaKind from(String? value) => switch (value) {
    'audio' => audio,
    'video' => video,
    _ => unknown,
  };
}

final _logger = Logger('RtpTrafficMonitor');

/// Describes the stream context for the received data report.
class RtpTrafficContext {
  const RtpTrafficContext({required this.trackId, required this.direction, required this.kind});

  final String? trackId;
  final RtpDirection direction;
  final MediaKind kind;

  @override
  String toString() => '${direction.name} ${kind.name}';
}

class RtpTrafficMetrics {
  const RtpTrafficMetrics({
    required this.deltaBytes,
    required this.deltaFrames,
    required this.totalBytes,
    required this.totalFrames,
    required this.isFlowing,
  });

  final num deltaBytes;
  final num deltaFrames;
  final num totalBytes;
  final num totalFrames;
  final bool isFlowing;

  @override
  String toString() => 'RtpTrafficMetrics(flow: $isFlowing, delta bytes: $deltaBytes, delta frames: $deltaFrames)';
}

abstract interface class RtpTrafficMonitorDelegate {
  void onStatsUpdated(RtpTrafficContext context, StatsReport report, RtpTrafficMetrics metrics);
}

class RtpTrafficMonitor {
  RtpTrafficMonitor({
    required this.peerConnection,
    this.checkInterval = const Duration(seconds: 5),
    List<RtpTrafficMonitorDelegate>? delegates,
  }) : _delegates = delegates ?? [];

  final RTCPeerConnection peerConnection;
  final Duration checkInterval;
  final List<RtpTrafficMonitorDelegate> _delegates;

  Timer? _timer;
  final Map<String, RtpTrafficMetrics> _previousMetrics = {};

  void addDelegate(RtpTrafficMonitorDelegate delegate) => _delegates.add(delegate);

  void removeDelegate(RtpTrafficMonitorDelegate delegate) => _delegates.remove(delegate);

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(checkInterval, (_) => _checkStats());
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _previousMetrics.clear();
  }

  /// Periodically fetches and processes WebRTC statistics.
  ///
  /// This method performs a safety check on the [peerConnection] state:
  /// if the connection is closed, it automatically stops the monitor to prevent
  /// unnecessary native calls and potential memory leaks.
  ///
  /// It iterates through the stats report, filters for valid RTP traffic
  /// (inbound/outbound), and delegates processing to [_processRtpReport].
  ///
  /// Any errors during the fetch or parse process are caught and logged
  /// to ensure the monitoring loop does not crash the application.
  Future<void> _checkStats() async {
    try {
      // Safety check: Stop monitoring if the connection is dead.
      // This prevents "PlatformException" on native layers when accessing closed objects.
      if (peerConnection.connectionState == RTCPeerConnectionState.RTCPeerConnectionStateClosed) {
        stop();
        _logger.info('WebRTC connection is closed. Stopping monitoring.');
        return;
      }

      final stats = await peerConnection.getStats();
      for (final report in stats) {
        final direction = RtpDirection.tryParse(report.type);
        if (direction != null) {
          _processRtpReport(report, direction);
        }
      }
    } catch (e, stack) {
      _logger.info('Error fetching WebRTC stats', e, stack);
    }
  }

  void _processRtpReport(StatsReport report, RtpDirection direction) {
    final trackId = report.values['trackIdentifier']?.toString();
    final kind = MediaKind.from(report.values['kind']);

    final context = RtpTrafficContext(trackId: trackId, direction: direction, kind: kind);

    final metrics = _calculateMetrics(report, context);

    _previousMetrics[report.id] = metrics;
    for (final delegate in _delegates) {
      delegate.onStatsUpdated(context, report, metrics);
    }
  }

  RtpTrafficMetrics _calculateMetrics(StatsReport report, RtpTrafficContext context) {
    final (byteKey, frameKey) = switch ((context.direction, context.kind)) {
      (RtpDirection.inbound, MediaKind.video) => ('bytesReceived', 'framesDecoded'),
      (RtpDirection.inbound, _) => ('bytesReceived', null),
      (RtpDirection.outbound, MediaKind.video) => ('bytesSent', 'framesEncoded'),
      (RtpDirection.outbound, _) => ('bytesSent', null),
    };

    final currentBytes = _safeParseNum(report.values[byteKey]);
    final currentFrames = frameKey != null ? _safeParseNum(report.values[frameKey]) : 0;

    final prev = _previousMetrics[report.id];

    final deltaBytes = prev == null ? 0 : currentBytes - prev.totalBytes;
    final deltaFrames = prev == null ? 0 : currentFrames - prev.totalFrames;
    final isFlowing = prev != null && deltaBytes > 0;

    return RtpTrafficMetrics(
      deltaBytes: deltaBytes,
      deltaFrames: deltaFrames,
      totalBytes: currentBytes,
      totalFrames: currentFrames,
      isFlowing: isFlowing,
    );
  }

  num _safeParseNum(dynamic value) => value is num ? value : 0;
}
