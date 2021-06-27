import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppUnregister());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppRegistered) {
      yield AppRegister();
    }
    if (event is AppUnregistered) {
      yield AppUnregister();
    }
  }
}
