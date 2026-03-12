import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/notifications/bloc/notifications_bloc.dart';
import 'package:webtrit_phone/app/notifications/models/notification.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call_routing/cubit/call_routing_cubit.dart';

// TODO(Serdun): Provide CallController as a singleton via RepositoryProvider in MainShell scope
// instead of instantiating it in each StatefulWidget. All call sites should use context.read<CallController>().
class CallController {
  CallController({
    required this.callBloc,
    required this.callRoutingCubit,
    required this.notificationsBloc,
    Logger? logger,
  }) : _logger = logger ?? Logger('CallController');

  final CallBloc callBloc;
  final CallRoutingCubit callRoutingCubit;
  final NotificationsBloc notificationsBloc;
  final Logger _logger;

  /// Creates a new call using the current call routing state.
  ///
  /// If the routing state is not yet available (app just launched, internet
  /// not yet connected), the call is held as pending and automatically
  /// proceeds once the routing state becomes available.
  void createCall({required String destination, String? displayName, bool video = false, String? fromNumber}) =>
      unawaited(
        _createCallAsync(
          destination: destination,
          displayName: displayName,
          video: video,
          fromNumber: fromNumber,
        ).catchError(
          (Object e, StackTrace st) => _logger.severe('createCall: unexpected error for $destination', e, st),
        ),
      );

  Future<void> _createCallAsync({
    required String destination,
    String? displayName,
    bool video = false,
    String? fromNumber,
  }) async {
    // Use current state if available, otherwise wait for the first non-null emission.
    // Timeout guards against indefinite wait when there is no network on startup.
    // orElse returns null only if the cubit is closed while waiting (e.g. logout).
    final CallRoutingState? callRoutingState;
    try {
      callRoutingState = callRoutingCubit.state ?? await _waitForRoutingState();
    } on TimeoutException {
      _logger.warning(
        'createCall: routing state not available after ${kCallRoutingStateTimeout.inSeconds}s, no network',
      );
      notificationsBloc.add(const NotificationsSubmitted(NoInternetConnectionNotification()));
      return;
    }

    if (callRoutingState == null) {
      _logger.warning(
        'createCall: callRoutingCubit closed before routing state became available, dropping call to $destination',
      );
      return;
    }

    // Determine fromNumber based on routing settings
    final shouldUseMainLine = fromNumber == callRoutingState.mainNumber;
    if (shouldUseMainLine) {
      fromNumber = null;
    } else {
      fromNumber ??= callRoutingCubit.getFromNumber(destination);
    }

    // Check line availability
    final hasIdleMainLine = callRoutingState.hasIdleMainLine;
    final hasIdleGuestLine = callRoutingState.hasIdleGuestLine;

    final noIdleMain = fromNumber == null && !hasIdleMainLine;
    final noIdleGuest = fromNumber != null && !hasIdleGuestLine;

    if (noIdleMain || noIdleGuest) {
      _logger.warning('Cannot create call: no idle lines available.');
      notificationsBloc.add(const NotificationsSubmitted(CallUndefinedLineNotification()));
      return;
    }

    callBloc.add(
      CallControlEvent.started(number: destination, video: video, displayName: displayName, fromNumber: fromNumber),
    );
  }

  /// Waits for the first non-null [CallRoutingState] from the cubit stream.
  ///
  /// Returns null if the cubit is closed before any state arrives (e.g. logout).
  /// Throws [TimeoutException] if no state arrives within [kCallRoutingStateTimeout].
  Future<CallRoutingState?> _waitForRoutingState() =>
      callRoutingCubit.stream.firstWhere((s) => s != null, orElse: () => null).timeout(kCallRoutingStateTimeout);

  /// Submits a blind transfer for the given destination.
  ///
  /// Optionally calls [onTransferSubmitted] (e.g. for popping router stack).
  void submitTransfer(String destination) {
    _logger.info('Submitting blind transfer to $destination');
    callBloc.add(CallControlEvent.blindTransferSubmitted(number: destination));
  }
}
