import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/extensions/logger_extensions.dart';

import 'rtp_traffic_monitor.dart';

class LoggingRtpTrafficMonitorDelegate implements RtpTrafficMonitorDelegate {
  LoggingRtpTrafficMonitorDelegate({required this.logger, this.prettyPrintData = true});

  final Logger logger;

  final bool prettyPrintData;

  @override
  void onStatsUpdated(RtpTrafficContext context, StatsReport report, RtpTrafficMetrics metrics) {
    _logSummary(context, metrics);

    if (prettyPrintData) {
      _logDetails(context, report);
    }
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

  void _logDetails(RtpTrafficContext context, StatsReport report) {
    final tag = '${context.kind.name} ${context.direction.name}-rtp data';

    logger.logPretty(tag, report.values, level: Level.INFO);
  }
}
