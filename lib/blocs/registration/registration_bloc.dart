import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:janus_client/janus_client.dart';

import 'package:webtrit_phone/repositories/call_repository.dart';
import 'package:webtrit_phone/blocs/app/app.dart';

import './registration.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final CallRepository callRepository;
  final AppBloc appBloc;

  @override
  RegistrationState get initialState => RegistrationInitial();

  RegistrationBloc({
    @required this.callRepository,
    @required this.appBloc,
  });

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is RegistrationStarted) {
      yield* _mapRegistrationStartedToState(event);
    } else if (event is RegistrationProcessed) {
      yield* _mapRegistrationProcessedToState(event);
    }
  }

  Stream<RegistrationState> _mapRegistrationStartedToState(RegistrationStarted event) async* {
    yield RegistrationInitial();

    if (callRepository.isAttached) {
      await callRepository.detach();
    }
  }

  Stream<RegistrationState> _mapRegistrationProcessedToState(RegistrationProcessed event) async* {
    yield RegistrationInProgress();
    try {
      await callRepository.attach();
      await callRepository.register(event.username);

      appBloc.add(AppRegistered());
    } on JanusPluginHandleErrorException catch (e) {
      yield RegistrationFailure(
        reason: e.error,
      );
    } on JanusErrorException catch(e) {
      yield RegistrationFailure(
        reason: e.reason,
      );
    } on Exception catch (e) {
      yield RegistrationFailure(
        reason: e.toString(),
      );
    }
  }
}
