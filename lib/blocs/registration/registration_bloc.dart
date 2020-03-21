import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:webtrit_phone/blocs/app/app.dart';

import './registration.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AppBloc appBloc;

  @override
  RegistrationState get initialState => RegistrationInitial();

  RegistrationBloc({
    @required this.appBloc,
  });

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is RegistrationStarted) {
      yield* _mapRegistrationStartedToState(event);
    }
  }

  Stream<RegistrationState> _mapRegistrationStartedToState(RegistrationStarted event) async* {
    yield RegistrationInProgress();
    try {
      // TODO: temporary code
      await Future.delayed(Duration(seconds: 1));
      if (event.username.startsWith('e')) {
        throw Exception('Username can\'t start with \'e\'');
      }

      appBloc.add(AppRegistered());
      yield RegistrationInitial();
    } catch (error) {
      yield RegistrationFailure(
        reason: error.toString(),
      );
    }
  }
}
