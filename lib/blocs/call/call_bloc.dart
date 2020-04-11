import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:webtrit_phone/repositories/call_repository.dart';

import './call.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  final CallRepository callRepository;

  StreamSubscription _onIncomingCallSubscription;
  StreamSubscription _onHangUpSubscription;

  @override
  CallState get initialState => CallInitial();

  CallBloc({
    @required this.callRepository,
  }) {
    _onIncomingCallSubscription = callRepository.onIncomingCall.listen((event) {
      add(CallReceived(username: event.username));
    });
    _onHangUpSubscription = callRepository.onHangup.listen((event) {
      add(CallHungUpRemote(reason: event.reason));
    });
  }

  @override
  Future<void> close() async {
    await _onIncomingCallSubscription.cancel();
    await _onHangUpSubscription.cancel();
    await super.close();
  }

  @override
  Stream<CallState> mapEventToState(CallEvent event) async* {
    if (event is CallReceived) {
      yield* _mapCallReceivedToState(event);
    } else if (event is CallHungUpRemote) {
      yield* _mapCallHungUpRemoteToState(event);
    } else if (event is CallHungUpLocal) {
      yield* _mapCallHungUpLocalToState(event);
    }
  }

  Stream<CallState> _mapCallReceivedToState(CallReceived event) async* {
    yield CallIncoming(username: event.username);
  }

  Stream<CallState> _mapCallHungUpRemoteToState(CallHungUpRemote event) async* {
    yield CallHangUp(reason: event.reason);
  }

  Stream<CallState> _mapCallHungUpLocalToState(CallHungUpLocal event) async* {
    await callRepository.hangup();

    yield CallHangUp(reason: event.reason);
  }
}
