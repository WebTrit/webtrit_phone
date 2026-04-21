import 'package:logging/logging.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/utils/crashlytics_utils.dart';
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
  void handle(Object error, StackTrace? stack, String context, {bool recordError = true}) {
    // TODO: implement signaling request response mechanism and handle request specific result instead of catching global errors
    // In such case it will be just result of OutgoingCallRequest
    if (error is WebtritSignalingErrorException && error.code == 503 && error.reason.contains('busy line')) {
      submitNotification(const CallServiceBusyLineNotification());
      return;
    }
    if (error is UserMediaError) {
      submitNotification(const CallUserMediaErrorNotification());
      return;
    }

    _logger.severe('[$context] An error occurred: $error', error, stack);
    if (recordError) {
      // Record the error in Crashlytics or any other error tracking service
      CrashlyticsUtils.recordError(error, stack: stack, reason: 'CallErrorReporter: $context');
    }
  }
}
