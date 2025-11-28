import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

part 'push_tokens_bloc.freezed.dart';

part 'push_tokens_event.dart';

part 'push_tokens_state.dart';

final _logger = Logger('PushTokensBloc');

// TODO: Refactor PushTokensBloc by extracting push token logic into dedicated services and repositories for better separation of concerns and testability.
class PushTokensBloc extends Bloc<PushTokensEvent, PushTokensState> implements PushRegistryDelegate {
  PushTokensBloc({
    required this.pushTokensRepository,
    required this.secureStorage,
    required this.firebaseMessaging,
    required this.callkeep,
    required this.pushEnvironment,
  }) : super(PushTokensState.initial()) {
    _onTokenRefreshSubscription = firebaseMessaging.onTokenRefresh.listen((fcmToken) {
      add(PushTokensEventInsertedOrUpdated(AppPushTokenType.fcm, fcmToken));
    });
    callkeep.setPushRegistryDelegate(this);

    on<PushTokensEventStarted>(_onStarted);
    on<PushTokensEventInsertedOrUpdated>(_onInsertedOrUpdated);
    on<PushTokensEventError>(_onError);
  }

  final PushTokensRepository pushTokensRepository;
  final SecureStorage secureStorage;
  final FirebaseMessaging firebaseMessaging;
  final Callkeep callkeep;
  final PushEnvironment pushEnvironment;

  late StreamSubscription _onTokenRefreshSubscription;

  // TODO: Move to repository when repository is ready
  bool get _isSignedIn => secureStorage.readToken() != null;

  // Retry handler with exponential backoff to handle scenarios where Google or Apple services
  // throw exceptions, such as when there is no internet connection, or in cases where
  // services are disabled by the user (e.g., Google Play Services on Android).
  final _backoffRetries = BackoffRetries();

  /// Closes the bloc and releases push/FCM resources in a safe order.
  @override
  Future<void> close() async {
    try {
      callkeep.setPushRegistryDelegate(null);

      await _cancelInternalDisposables();
      await _deleteFcmTokenIfSignedOut();
    } finally {
      await super.close();
    }
  }

  Future<void> _cancelInternalDisposables() async {
    try {
      await _onTokenRefreshSubscription.cancel();
    } catch (e, stackTrace) {
      _logger.warning('Failed to cancel token refresh subscription', e, stackTrace);
    }

    try {
      _backoffRetries.cancel();
    } catch (e, stackTrace) {
      _logger.warning('Failed to cancel backoff retries', e, stackTrace);
    }
  }

  Future<void> _deleteFcmTokenIfSignedOut() async {
    if (_isSignedIn) {
      _logger.finest('Skipping FCM token deletion because a user token is still present.');
      return;
    }

    try {
      await firebaseMessaging.deleteToken();
      _logger.fine('FCM token deleted successfully.');
    } catch (e, stackTrace) {
      _logger.warning('Failed to delete FCM token', e, stackTrace);
    }
  }

  void _onStarted(PushTokensEvent event, Emitter<PushTokensState> emit) async {
    if (Platform.isAndroid || Platform.isIOS) {
      unawaited(_retrieveAndStoreFcmToken());
    }
    if (Platform.isIOS) {
      unawaited(_retrieveAndStoreApnsToken());
    }
  }

  Future<void> _retrieveAndStoreFcmToken() async {
    const vapidKey = EnvironmentConfig.FCM_VAPID_KEY;

    final initialStatus = await pushEnvironment.getAvailability();

    if (initialStatus.isTerminal) {
      _logger.warning('GMS status is terminal ($initialStatus). Aborting.');
      return;
    }

    final fcmToken = await _backoffRetries.execute<String?>(
      (_) => firebaseMessaging.getToken(vapidKey: vapidKey),
      shouldRetry: (e, attempt) async {
        _logger.warning('Attempt $attempt failed: $e');

        final retryStatus = await pushEnvironment.getAvailability();

        if (retryStatus.isTerminal) {
          _logger.warning('Stopping retries. GMS became terminal: $retryStatus');
          return false;
        }

        return true;
      },
    );

    if (fcmToken != null) {
      add(PushTokensEventInsertedOrUpdated(AppPushTokenType.fcm, fcmToken));
    } else {
      _logger.severe('_retrieveAndStoreFcmToken failed after max attempts');
    }
  }

  Future<void> _retrieveAndStoreApnsToken() async {
    final apnsToken = await _backoffRetries.execute<String?>(
      (attempt) => firebaseMessaging.getAPNSToken(),
      shouldRetry: (e, attempt) {
        add(PushTokensEventError('Failed to retrieve APNS token: $e at attempt $attempt'));
        return true;
      },
    );

    if (apnsToken != null) {
      add(PushTokensEventInsertedOrUpdated(AppPushTokenType.apns, apnsToken));
    } else {
      _logger.severe('_retrieveAndStoreApnsToken failed after max attempts');
    }
  }

  void _onInsertedOrUpdated(PushTokensEventInsertedOrUpdated event, Emitter<PushTokensState> emit) async {
    try {
      await _backoffRetries.execute<void>(
        (attempt) async {
          _logger.fine('_onInsertedOrUpdated attempt $attempt');
          await pushTokensRepository.insertOrUpdatePushToken(event.type, event.value);
        },
        shouldRetry: (e, attempt) {
          _logger.warning('Retrying insertOrUpdatePushToken due to: $e (attempt: $attempt)');
          return true;
        },
      );

      emit(state.copyWith(pushToken: event.value));

      if (event.type == AppPushTokenType.fcm) {
        secureStorage.writeFCMPushToken(event.value);
      }

      _logger.fine('Push token inserted or updated: ${event.type} ${event.value}');
    } catch (e, stackTrace) {
      _logger.warning('_onInsertedOrUpdated', e, stackTrace);
    }
  }

  void _onError(PushTokensEventError event, Emitter<PushTokensState> emit) async {
    emit(PushTokensState.uploadFailure(event.errorMessage));
  }

  @override
  void didUpdatePushTokenForPushTypeVoIP(String? token) {
    if (token != null) {
      add(PushTokensEventInsertedOrUpdated(AppPushTokenType.apkvoip, token));
    } else {
      // TODO: null mean that the system invalidated the push token for VoIP type
    }
  }
}
