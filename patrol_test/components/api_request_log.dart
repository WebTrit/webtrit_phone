import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

/// One HTTP request observed through the api client's request log line.
class ApiRequest {
  ApiRequest(this.time, this.attempt, this.path);

  final DateTime time;
  final int attempt;
  final String path;
}

/// In-process request oracle: parses the api client's own request log line
/// (`GET request(0) to ... with requestId: ...`) from [Logger.root], the same
/// signal the on-device duplicate-request investigation counted.
///
/// Subscribe only AFTER `bootstrap()`: AppLogger.init inside it clears all
/// root logger listeners, which silently drops an earlier subscription.
class ApiRequestLog {
  static final _requestLine = RegExp(r'([A-Z]+) request\((\d+)\) to (\S+) with requestId');

  final _requests = <ApiRequest>[];
  StreamSubscription<LogRecord>? _subscription;
  int recordsSeen = 0;
  int clientRecordsSeen = 0;

  void start() {
    _subscription = Logger.root.onRecord.listen((record) {
      recordsSeen++;
      if (record.loggerName != 'WebtritApiClient') return;
      clientRecordsSeen++;
      final match = _requestLine.firstMatch(record.message);
      if (match == null) return;
      _requests.add(ApiRequest(record.time, int.parse(match.group(2)!), Uri.parse(match.group(3)!).path));
    });
  }

  Future<void> stop() async => _subscription?.cancel();

  /// First-attempt requests whose path ends with [pathSuffix], within
  /// [since, until).
  List<ApiRequest> requestsFor(String pathSuffix, {DateTime? since, DateTime? until}) => _requests
      .where((r) => r.path.endsWith(pathSuffix) && r.attempt == 0)
      .where((r) => since == null || !r.time.isBefore(since))
      .where((r) => until == null || r.time.isBefore(until))
      .toList();

  /// Requests to [pathSuffix] that went through the transport retry loop.
  /// Other endpoints may legitimately retry (e.g. the login screen probing an
  /// unreachable preset core URL in the background).
  List<ApiRequest> retriedFor(String pathSuffix) =>
      _requests.where((r) => r.attempt > 0 && r.path.endsWith(pathSuffix)).toList();

  String describe(String pathSuffix) =>
      'records=$recordsSeen client=$clientRecordsSeen '
      '$pathSuffix=${requestsFor(pathSuffix).map((r) => r.time.toIso8601String()).toList()}';
}

/// The connect invariant, anchored to the requests themselves rather than to
/// UI timing: the phase saw at least one fetch of the endpoint, and no two
/// fetches arrived closer than the duplicate window. Legitimate periodic
/// ticks are 10+ seconds apart and pass; the duplicates from the
/// investigated bug arrived within 0.2-4 seconds of each other and fail.
void expectSingleConnectFetch(List<ApiRequest> requests, String phase, String endpoint) {
  expect(requests, isNotEmpty, reason: '$phase must fetch $endpoint');
  for (var i = 1; i < requests.length; i++) {
    final gap = requests[i].time.difference(requests[i - 1].time);
    expect(
      gap,
      greaterThanOrEqualTo(const Duration(seconds: 8)),
      reason:
          '$phase fired $endpoint requests ${gap.inMilliseconds} ms apart - '
          'a duplicate, not a periodic tick',
    );
  }
}
