import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_phone/utils/utils.dart';

import '../models/models.dart';

part 'orientations_bloc.freezed.dart';

part 'orientations_event.dart';

part 'orientations_state.dart';

class OrientationsBloc extends Bloc<OrientationsEvent, OrientationsState> {
  OrientationsBloc() : super(const OrientationsState()) {
    on<OrientationsChanged>(_onChanged, transformer: sequential());
  }

  void _onChanged(OrientationsChanged event, Emitter<OrientationsState> emit) async {
    if (state.lastOrientation == event.orientation) return;

    switch (event.orientation) {
      case PreferredOrientation.regular:
        await setRegularPreferredOrientations();
        break;
      case PreferredOrientation.call:
        await setCallPreferredOrientations();
        break;
    }

    emit(state.copyWith(lastOrientation: event.orientation));
  }
}
