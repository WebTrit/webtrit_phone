import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/extensions/logger_extensions.dart';

import 'rtp_traffic_monitor.dart';

/// Standard WebRTC stats keys to avoid hardcoding strings.
enum StatsField {
  ssrc('ssrc'),
  kind('kind'),
  transportId('transportId'),
  timestamp('timestamp'),
  id('id'),
  type('type'),
  bytesReceived('bytesReceived'),
  packetsReceived('packetsReceived'),
  packetsLost('packetsLost'),
  jitter('jitter'),
  framesDecoded('framesDecoded'),
  framesDropped('framesDropped'),
  audioLevel('audioLevel'),
  totalAudioEnergy('totalAudioEnergy'),
  totalSamplesDuration('totalSamplesDuration'),
  bytesSent('bytesSent'),
  packetsSent('packetsSent'),
  retransmittedPacketsSent('retransmittedPacketsSent'),
  framesEncoded('framesEncoded'),
  totalPacketSendDelay('totalPacketSendDelay'),
  targetBitrate('targetBitrate');

  const StatsField(this.key);

  final String key;
}

/// Defines a filtering rule for logging scope.
class LogScope {
  const LogScope({required this.kind, this.direction, this.allowedFields});

  final MediaKind kind;

  /// If null, matches any direction (both inbound and outbound).
  final RtpDirection? direction;

  /// List of specific fields (keys) to log from the report.
  ///
  /// If null or empty, the full map will be logged.
  final List<StatsField>? allowedFields;

  bool matches(RtpTrafficContext context) {
    return kind == context.kind && (direction == null || direction == context.direction);
  }
}

class LoggingRtpTrafficMonitorDelegate implements RtpTrafficMonitorDelegate {
  LoggingRtpTrafficMonitorDelegate({required this.logger, required this.scopes, this.prettyPrintData = true});

  final Logger logger;

  final List<LogScope> scopes;

  final bool prettyPrintData;

  @override
  void onStatsUpdated(RtpTrafficContext context, StatsReport report, RtpTrafficMetrics metrics) {
    final scope = _findMatchingScope(context);
    if (scope == null) return;

    _logSummary(context, metrics);

    if (prettyPrintData) {
      _logDetails(context, report, scope);
    }
  }

  LogScope? _findMatchingScope(RtpTrafficContext context) {
    for (final scope in scopes) {
      if (scope.matches(context)) {
        return scope;
      }
    }
    return null;
  }

  void _logSummary(RtpTrafficContext context, RtpTrafficMetrics metrics) {
    final directionStr = context.direction.name.toUpperCase();
    final kindStr = context.kind.name.toUpperCase();
    final statusStr = metrics.isFlowing ? 'Flowing' : 'STALLED';
    final sign = metrics.deltaBytes > 0 ? '+' : '';

    logger.finer(
      '[$directionStr $kindStr] '
      'Bytes: $sign${metrics.deltaBytes} | '
      'Frames: ${metrics.deltaFrames} | '
      'Status: $statusStr',
    );
  }

  void _logDetails(RtpTrafficContext context, StatsReport report, LogScope scope) {
    final tag = '${context.kind.name} ${context.direction.name}-rtp data';
    final data = _filterReportData(report, scope);

    logger.logPretty(tag, data, level: Level.INFO);
  }

  Map<dynamic, dynamic> _filterReportData(StatsReport report, LogScope scope) {
    if (scope.allowedFields == null || scope.allowedFields!.isEmpty) {
      return report.values;
    }

    final filteredData = <String, dynamic>{};

    for (final field in scope.allowedFields!) {
      final key = field.key;
      if (report.values.containsKey(key)) {
        filteredData[key] = report.values[key];
      }
    }

    return filteredData;
  }
}
