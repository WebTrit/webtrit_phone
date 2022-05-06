import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:callkeep/callkeep.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

part 'push_tokens_event.dart';

part 'push_tokens_state.dart';

class PushTokensBloc extends Bloc<PushTokensEvent, PushTokensState> {
  PushTokensBloc({
    required this.pushTokensRepository,
    required this.firebaseMessaging,
    required this.callkeep,
  }) : super(const PushTokensInitial()) {
    _onTokenRefreshSubscription = firebaseMessaging.onTokenRefresh.listen((fcmToken) {
      add(PushTokensInsertedOrUpdated(PushTokenType.fcm, fcmToken));
    });

    callkeep.on(CallKeepPushKitToken(), _onCallKeepPushKitToken);

    on<PushTokensStarted>(_onStarted);
    on<PushTokensInsertedOrUpdated>(_onInsertedOrUpdated);
  }

  final PushTokensRepository pushTokensRepository;
  final FirebaseMessaging firebaseMessaging;
  final FlutterCallkeep callkeep;

  late StreamSubscription _onTokenRefreshSubscription;

  @override
  Future<void> close() async {
    callkeep.remove(CallKeepPushKitToken(), _onCallKeepPushKitToken);
    _onTokenRefreshSubscription.cancel();
    await super.close();
  }

  void _onStarted(PushTokensEvent event, Emitter<PushTokensState> emit) async {
    final fcmToken = await firebaseMessaging.getToken();
    if (fcmToken != null) {
      add(PushTokensInsertedOrUpdated(PushTokenType.fcm, fcmToken));
    }

    final apnsToken = await firebaseMessaging.getAPNSToken();
    if (apnsToken != null) {
      add(PushTokensInsertedOrUpdated(PushTokenType.apns, apnsToken));
    }

    emit(const PushTokensUploadSuccess());
  }

  void _onInsertedOrUpdated(PushTokensInsertedOrUpdated event, Emitter<PushTokensState> emit) async {
    pushTokensRepository.insertOrUpdatePushToken(event.type, event.value);
  }

  void _onCallKeepPushKitToken(CallKeepPushKitToken event) {
    final apkvoipToken = event.token;
    if (apkvoipToken != null) {
      add(PushTokensInsertedOrUpdated(PushTokenType.apkvoip, apkvoipToken));
    }
  }
}
