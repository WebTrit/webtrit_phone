import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
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

class PushTokensBloc extends Bloc<PushTokensEvent, PushTokensState> implements PushRegistryDelegate {
  PushTokensBloc({
    required this.pushTokensRepository,
    required this.secureStorage,
    required this.firebaseMessaging,
    required this.callkeep,
  }) : super(PushTokensState.initial()) {
    _onTokenRefreshSubscription = firebaseMessaging.onTokenRefresh.listen((fcmToken) {
      add(PushTokensInsertedOrUpdated(AppPushTokenType.fcm, fcmToken));
    });
    callkeep.setPushRegistryDelegate(this);

    on<PushTokensStarted>(_onStarted);
    on<PushTokensInsertedOrUpdated>(_onInsertedOrUpdated);
    on<_PushTokensError>(_onError);
    on<PushTokensFcmTokenDeletionRequested>(_onFcmTokenDeletionRequested);
  }

  final PushTokensRepository pushTokensRepository;
  final SecureStorage secureStorage;
  final FirebaseMessaging firebaseMessaging;
  final Callkeep callkeep;

  late StreamSubscription _onTokenRefreshSubscription;

  // Retry handler with exponential backoff to handle scenarios where Google or Apple services
  // throw exceptions, such as when there is no internet connection, or in cases where
  // services are disabled by the user (e.g., Google Play Services on Android).
  final _backoffRetries = BackoffRetries();

  @override
  Future<void> close() async {
    callkeep.setPushRegistryDelegate(null);
    _onTokenRefreshSubscription.cancel();
    _backoffRetries.cancel();
    await super.close();
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

    final fcmToken = await _backoffRetries.execute<String?>(
      (attempt) async {
        _logger.fine('_retrieveAndStoreFcmToken attempt $attempt');
        return await firebaseMessaging.getToken(vapidKey: vapidKey);
      },
      shouldRetry: (e, attempt) {
        add(PushTokensEvent.error('Failed to retrieve FCM token: $e at attempt $attempt'));
        return true;
      },
    );

    if (fcmToken != null) {
      add(PushTokensInsertedOrUpdated(AppPushTokenType.fcm, fcmToken));
    } else {
      _logger.severe('_retrieveAndStoreFcmToken failed after max attempts');
    }
  }

  Future<void> _retrieveAndStoreApnsToken() async {
    final apnsToken = await _backoffRetries.execute<String?>(
      (attempt) async {
        _logger.fine('_retrieveAndStoreApnsToken attempt $attempt');
        return await firebaseMessaging.getAPNSToken();
      },
      shouldRetry: (e, attempt) {
        add(PushTokensEvent.error('Failed to retrieve APNS token: $e at attempt $attempt'));
        return true;
      },
    );

    if (apnsToken != null) {
      add(PushTokensInsertedOrUpdated(AppPushTokenType.apns, apnsToken));
    } else {
      _logger.severe('_retrieveAndStoreApnsToken failed after max attempts');
    }
  }

  void _onInsertedOrUpdated(PushTokensInsertedOrUpdated event, Emitter<PushTokensState> emit) async {
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

  Future<void> _onFcmTokenDeletionRequested(
    PushTokensFcmTokenDeletionRequested event,
    Emitter<PushTokensState> emit,
  ) async {
    try {
      await firebaseMessaging.deleteToken();
      _logger.fine('FCM token deleted successfully');
    } catch (e, stackTrace) {
      _logger.warning('Failed to delete FCM token', e, stackTrace);
      add(PushTokensEvent.error('Failed to delete FCM token: $e'));
    }
  }

  void _onError(_PushTokensError event, Emitter<PushTokensState> emit) async {
    emit(PushTokensState.uploadFailure(event.errorMessage));
  }

  @override
  void didUpdatePushTokenForPushTypeVoIP(String? token) {
    if (token != null) {
      add(PushTokensInsertedOrUpdated(AppPushTokenType.apkvoip, token));
    } else {
      // TODO: null mean that the system invalidated the push token for VoIP type
    }
  }
}
