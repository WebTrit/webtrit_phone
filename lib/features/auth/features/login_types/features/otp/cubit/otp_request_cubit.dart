import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_phone/features/auth/auth.dart';

import '../models/models.dart';

part 'otp_request_state.dart';

part 'otp_request_cubit.freezed.dart';

class OtpRequestCubit extends Cubit<OtpRequestState> {
  OtpRequestCubit(AuthCubit authCubit) : super(OtpRequestState(demo: authCubit.state.demo));

  void loginOptRequestEmailInputChanged(String value) {
    emit(state.copyWith(
      emailInput: EmailInput.dirty(value),
    ));
  }

  void loginOptRequestPhoneInputChanged(String value) {
    emit(state.copyWith(
      phoneInput: PhoneInput.dirty(value),
    ));
  }

  void loginOptRequestSubmitted() async {
    if (!(state.demo ? state.emailInput.isValid : state.phoneInput.isValid)) {
      return;
    }

    emit(state.copyWith(status: OtpRequestStatus.ok));
    emit(state.copyWith(status: null));
  }
}
