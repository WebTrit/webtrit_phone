import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'push_tokens_event.dart';

part 'push_tokens_state.dart';

final _logger = Logger('$PushTokensBloc');

class PushTokensBloc extends Bloc<PushTokensEvent, PushTokensState> implements PushRegistryDelegate {
  PushTokensBloc({
    required this.pushTokensRepository,
    required this.firebaseMessaging,
    required this.callkeep,
  }) : super(const PushTokensInitial()) {
    _onTokenRefreshSubscription = firebaseMessaging.onTokenRefresh.listen((fcmToken) {
      add(PushTokensInsertedOrUpdated(AppPushTokenType.fcm, fcmToken));
    });
    callkeep.setPushRegistryDelegate(this);

    on<PushTokensStarted>(_onStarted);
    on<PushTokensInsertedOrUpdated>(_onInsertedOrUpdated);
  }

  final PushTokensRepository pushTokensRepository;
  final FirebaseMessaging firebaseMessaging;
  final Callkeep callkeep;

  late StreamSubscription _onTokenRefreshSubscription;

  @override
  Future<void> close() async {
    callkeep.setPushRegistryDelegate(null);
    _onTokenRefreshSubscription.cancel();
    await super.close();
  }

  void _onStarted(PushTokensEvent event, Emitter<PushTokensState> emit) async {
    final vapidKey = EnvironmentConfig.FCM_VAPID_KEY.isEmpty ? null : EnvironmentConfig.FCM_VAPID_KEY;
    final fcmToken = await firebaseMessaging.getToken(vapidKey: vapidKey);
    if (fcmToken != null) {
      add(PushTokensInsertedOrUpdated(AppPushTokenType.fcm, fcmToken));
    }

    final apnsToken = await firebaseMessaging.getAPNSToken();
    if (apnsToken != null) {
      add(PushTokensInsertedOrUpdated(AppPushTokenType.apns, apnsToken));
    }

    emit(const PushTokensUploadSuccess());
  }

  void _onInsertedOrUpdated(PushTokensInsertedOrUpdated event, Emitter<PushTokensState> emit) async {
    try {
      await pushTokensRepository.insertOrUpdatePushToken(event.type, event.value);
    } catch (e, stackTrace) {
      _logger.warning('_onInsertedOrUpdated', e, stackTrace);

      rethrow;
    }
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
