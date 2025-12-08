import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/notifications/models/notification.dart';

import '../models/notification.dart';
import 'user_media_builder.dart';

final _logger = Logger('CallBloc:SignalingErrorReporter');

/// Interface for reporting errors that occur during call processing.
///
/// This abstraction allows injecting different error reporting strategies,
/// such as production or mock implementations.
abstract interface class CallErrorReporter {
  /// Handles an error that occurred during the call lifecycle.
  ///
  /// The [error] is the caught exception or object.
  /// The [stack] is the optional stack trace associated with the error.
  /// The [context] describes where or why the error occurred — useful for logging.
  void handle(Object error, StackTrace? stack, String context);
}

/// Default implementation of [CallErrorReporter] for handling and reporting
/// call-related and signaling-related errors.
///
/// This class logs every error, determines whether to notify the user,
/// and sends the appropriate [Notification] via the injected [submitNotification] function.
class DefaultCallErrorReporter implements CallErrorReporter {
  /// Creates a new instance of [DefaultCallErrorReporter].
  ///
  /// Requires a [submitNotification] callback that handles user notifications.
  const DefaultCallErrorReporter(this.submitNotification);

  /// A function used to dispatch user-facing notifications.
  final void Function(Notification) submitNotification;

  @override
  void handle(Object error, StackTrace? stack, String context) {
    // Always log the error with context and stack trace
    _logger.warning('[$context] $error', error, stack);

    if (error is WebtritSignalingTransactionTerminateByDisconnectException) {
      final code = SignalingDisconnectCode.values.byCode(error.closeCode ?? SignalingDisconnectCode.unmappedCode.code);
      if (_shouldNotifyOnDisconnect(code)) {
        submitNotification(DefaultErrorNotification(error));
      }
      return;
    }

    if (error is UserMediaError) {
      submitNotification(const CallUserMediaErrorNotification());
    } else if (error is SDPConfigurationError) {
      submitNotification(const CallSdpConfigurationErrorNotification());
    } else if (error is TimeoutException) {
      submitNotification(const CallNegotiationTimeoutNotification());
    } else {
      submitNotification(DefaultErrorNotification(error));
    }
  }

  /// Determines whether a disconnect code should trigger user notification.
  ///
  /// Only specific disconnect reasons are considered important enough to notify the user.
  bool _shouldNotifyOnDisconnect(SignalingDisconnectCode code) {
    return switch (code) {
      SignalingDisconnectCode.requestExecuteError => true,
      SignalingDisconnectCode.controllerBillingError => true,
      SignalingDisconnectCode.controllerBillingAccountMissedError => true,
      SignalingDisconnectCode.controllerBillingAccountCredentialsMissedError => true,
      SignalingDisconnectCode.signalingMessageError => true,
      _ => false,
    };
  }
}
