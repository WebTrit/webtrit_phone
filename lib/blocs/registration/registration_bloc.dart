import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/repositories/call_repository.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final CallRepository callRepository;
  final AppBloc appBloc;

  RegistrationBloc({
    required this.callRepository,
    required this.appBloc,
  }) : super(RegistrationInitial());

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is RegistrationStarted) {
      yield* _mapRegistrationStartedToState(event);
    } else if (event is RegistrationProcessed) {
      yield* _mapRegistrationProcessedToState(event);
    }
  }

  Stream<RegistrationState> _mapRegistrationStartedToState(
      RegistrationStarted event) async* {
    yield RegistrationInitial();

    if (callRepository.isAttached) {
      await callRepository.detach();
    }
  }

  Stream<RegistrationState> _mapRegistrationProcessedToState(
      RegistrationProcessed event) async* {
    yield RegistrationInProgress();
    try {
      await callRepository.attach();
      await callRepository.register();

      appBloc.add(AppRegistered());
    } catch (e) {
      yield RegistrationFailure(
        reason: e.toString(),
      );
    }
  }
}
