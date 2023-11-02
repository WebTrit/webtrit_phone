import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/data.dart';

part 'login_types_state.dart';

part 'login_types_cubit.freezed.dart';

class LoginTypesCubit extends Cubit<LoginTypesState> {
  LoginTypesCubit(AppPreferences appPreferences)
      : super(LoginTypesState(supportedLogin: appPreferences.getSupportedLoginType()));
}
