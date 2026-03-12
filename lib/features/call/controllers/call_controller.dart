import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/notifications/bloc/notifications_bloc.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call_routing/cubit/call_routing_cubit.dart';

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
        _createCallAsync(destination: destination, displayName: displayName, video: video, fromNumber: fromNumber),
      );

  Future<void> _createCallAsync({
    required String destination,
    String? displayName,
    bool video = false,
    String? fromNumber,
  }) async {
    final callRoutingState =
        callRoutingCubit.state ?? await callRoutingCubit.stream.firstWhere((s) => s != null, orElse: () => null);

    if (callRoutingState == null) return;

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

  /// Submits a blind transfer for the given destination.
  ///
  /// Optionally calls [onTransferSubmitted] (e.g. for popping router stack).
  void submitTransfer(String destination) {
    _logger.info('Submitting blind transfer to $destination');
    callBloc.add(CallControlEvent.blindTransferSubmitted(number: destination));
  }
}
