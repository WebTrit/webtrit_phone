import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/notifications/bloc/notifications_bloc.dart';
import 'package:webtrit_phone/app/notifications/models/notification.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call_routing/cubit/call_routing_cubit.dart';
import 'package:webtrit_phone/services/connectivity_service.dart';

class CallController {
  CallController({
    required this.callBloc,
    required this.callRoutingCubit,
    required this.notificationsBloc,
    required this.connectivityService,
    Logger? logger,
  }) : _logger = logger ?? Logger('CallController') {
    _connectivitySubscription = connectivityService.connectionStream.listen((connected) {
      _netConnected = connected;
    });
  }

  final CallBloc callBloc;
  final CallRoutingCubit callRoutingCubit;
  final NotificationsBloc notificationsBloc;
  final ConnectivityService connectivityService;
  final Logger _logger;
  StreamSubscription? _connectivitySubscription;
  bool? _netConnected;
  DateTime? _createCallDebounceReleaseTime;

  /// Checks network connectivity status.
  ///
  /// don't get confused with signaling connectivity (SIP registration)
  /// this is needed to determine what notification to show
  Future<bool> get isNetworkConnected async {
    // If we already have a connectivity status from the stream, return it immediately.
    // For cases if app was initialized and we know our connectivity status, we can avoid the overhead of an additional checkConnection call.
    if (_netConnected != null) return _netConnected!;

    // But if its null its means app was just launched and we haven't received any connectivity updates yet,
    // so we should perform an active check to determine our connectivity status before proceeding with the call.
    _netConnected = await connectivityService.checkConnection().timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return false;
      },
    );

    return _netConnected!;
  }

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
    // Check network connectivity independently before attempting to get routing state,
    // to provide more accurate notifications to the user.
    final netConnected = await isNetworkConnected;
    if (!netConnected) {
      _logger.warning('Cannot create call: no network connectivity.');
      notificationsBloc.add(const NotificationsSubmitted(NoInternetConnectionNotification()));
      return;
    }

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
      notificationsBloc.add(const NotificationsSubmitted(GeneralUnableToCallNotification()));
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
      notificationsBloc.add(const NotificationsSubmitted(GeneralUnableToCallNotification()));
      return;
    }

    if (_isCreateCallDebounceActive) return;
    _createCallDebounceReleaseTime = DateTime.now().add(kDebounceDuration);

    callBloc.add(
      CallControlEvent.started(number: destination, video: video, displayName: displayName, fromNumber: fromNumber),
    );
  }

  /// Returns true if the create call debounce is currently active, preventing new calls from being initiated.
  bool get _isCreateCallDebounceActive {
    if (_createCallDebounceReleaseTime == null) return false;
    return DateTime.now().isBefore(_createCallDebounceReleaseTime!);
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

  void dispose() {
    _connectivitySubscription?.cancel();
  }
}
