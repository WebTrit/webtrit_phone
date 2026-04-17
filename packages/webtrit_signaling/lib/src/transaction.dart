import 'dart:async';
import 'dart:math';

import 'package:logging/logging.dart';

import 'exceptions.dart';

final _logger = Logger('Transaction');

/// Represents a single in-flight signaling request and its expected response.
///
/// A [Transaction] is created for every request sent to the signaling server.
/// It holds a [Completer] that resolves when one of three terminal events occurs:
///
/// - [handleResponse] — the server replied within the timeout window.
/// - [terminateByDisconnect] — the WebSocket closed before a reply arrived.
/// - The internal timeout timer fires (after [timeoutDuration]).
///
/// Only the **first** terminal event takes effect. Subsequent calls to any of
/// the three completion paths are logged at [Level.WARNING] and ignored via
/// the [_isDone] guard, preventing a `StateError: Future already completed`
/// if, for example, a late server response arrives after the timeout has
/// already fired.
class Transaction {
  /// Cryptographically random session prefix, initialized once per isolate run.
  ///
  /// Each push-notification isolate gets a different value so the server
  /// cannot match IDs from a previous session against the current one.
  /// [Random.secure] draws from OS entropy, reducing the risk of two isolates
  /// receiving the same prefix compared to [Random].
  static final _sessionId = Random.secure().nextInt(1000000000);

  static int _createCounter = 0;

  /// Generates a transaction ID unique across Dart isolate restarts.
  ///
  /// Format: `transaction-{sessionId}{counter}`
  ///
  /// [_sessionId] is a random 9-digit number fixed for the lifetime of this
  /// isolate. [_createCounter] increments with each call, ensuring uniqueness
  /// within a single isolate run.
  ///
  /// The ID contains only digits after the `transaction-` prefix — empirically
  /// required by the server; non-digit separators cause audio dropout.
  static String generateId() => 'transaction-$_sessionId${_createCounter++}';

  final int signalingClientId;
  late final String id;
  late final bool isIdGenerate;

  final _completer = Completer<Map<String, dynamic>>();
  late final Timer _timer;

  /// `true` once any terminal path ([handleResponse], [terminateByDisconnect],
  /// or timeout) has run. Guards against double-completion of [_completer].
  var _isDone = false;

  Transaction({required this.signalingClientId, String? id, required Duration timeoutDuration}) {
    if (id != null) {
      this.id = id;
      isIdGenerate = false;
    } else {
      this.id = generateId();
      isIdGenerate = true;
    }

    _timer = Timer(timeoutDuration, _onTimeout);
  }

  Future<Map<String, dynamic>> get future => _completer.future;

  /// Called when the server sends a response matching this transaction's [id].
  ///
  /// Completes [future] with [responseMessage]. No-op if the transaction has
  /// already been resolved by a timeout or disconnect.
  void handleResponse(Map<String, dynamic> responseMessage) {
    if (_isDone) {
      _logger.warning(
        '$signalingClientId handleResponse called on already-completed transaction $id — ignoring late response',
      );
      return;
    }
    _finish();
    _completer.complete(responseMessage);
  }

  /// Called when the WebSocket disconnects before a response is received.
  ///
  /// Completes [future] with a
  /// [WebtritSignalingTransactionTerminateByDisconnectException]. No-op if the
  /// transaction has already been resolved.
  void terminateByDisconnect([int? closeCode, String? closeReason]) {
    if (_isDone) {
      _logger.warning(
        '$signalingClientId terminateByDisconnect called on already-completed transaction $id — ignoring (code: $closeCode reason: $closeReason)',
      );
      return;
    }
    _finish();
    _completer.completeError(
      WebtritSignalingTransactionTerminateByDisconnectException(signalingClientId, id, closeCode, closeReason),
    );
  }

  void _onTimeout() {
    if (_isDone) {
      _logger.warning(
        '$signalingClientId _onTimeout fired on already-completed transaction $id — ignoring late timeout',
      );
      return;
    }
    _finish();
    _completer.completeError(WebtritSignalingTransactionTimeoutException(signalingClientId, id), StackTrace.current);
  }

  /// Marks the transaction as done and cancels the timeout timer.
  ///
  /// Must be called before completing [_completer] in every terminal path.
  void _finish() {
    _isDone = true;
    _timer.cancel();
  }
}
