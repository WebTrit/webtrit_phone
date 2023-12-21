import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_phone/features/auth/auth.dart';

part 'mode_select_state.dart';

part 'mode_select_cubit.freezed.dart';

class ModeSelectCubit extends Cubit<ModeSelectState> {
  ModeSelectCubit(this.authCubit) : super(ModeSelectState(demo: authCubit.state.demo));

  final AuthCubit authCubit;

  void signUp() async {
    emit(state.copyWith(status: ModeSelectStatus.processing));
    try {
      await authCubit.checkSystemInfo();
      emit(state.copyWith(direction: ModeSelectDirection.signUp));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: ModeSelectStatus.error,
        error: e,
      ));
    }
    emit(state.copyWith(direction: null, status: null));
  }

  void customUrl() {
    emit(state.copyWith(direction: ModeSelectDirection.coreUrl));
    emit(state.copyWith(direction: null));
  }
}
