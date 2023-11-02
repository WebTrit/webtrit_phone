import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:linkify/linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webtrit_phone/features/auth/auth.dart';

import '../models/models.dart';

part 'login_core_url_assign_state.dart';

part 'login_core_url_assign_cubit.freezed.dart';

class LoginCoreUrlAssignCubit extends Cubit<LoginCoreUrlAssignState> {
  LoginCoreUrlAssignCubit(this.authCubit) : super(const LoginCoreUrlAssignState());

  final AuthCubit authCubit;

  void loginCoreUrlAssignCoreUrlInputChanged(String value) {
    emit(state.copyWith(
      coreUrlInput: UrlInput.dirty(value),
    ));
  }

  void loginCoreUrlAssignSubmitted() async {
    if (!state.coreUrlInput.isValid) {
      return;
    }

    emit(state.copyWith(
      status: LoginCoreStatus.processing,
    ));

    var coreUrlInputValue = state.coreUrlInput.value;
    if (!coreUrlInputValue.startsWith(RegExp(r'(https|http)://'))) {
      coreUrlInputValue = 'https://$coreUrlInputValue';
    }
    authCubit.updateAuthCoreUrl(coreUrlInputValue);

    try {
      await authCubit.checkSystemInfo();
      emit(state.copyWith(
        status: LoginCoreStatus.ok,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: LoginCoreStatus.error,
        error: e,
      ));
    }
  }

  void launchLinkableElement(LinkableElement link) async {
    final url = Uri.parse(link.url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
