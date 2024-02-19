import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';

import 'package:webtrit_phone/features/features.dart';

bool whenLoginOtpSigninRouterPageChange(LoginState previous, LoginState current) {
  return previous.otpSigninSessionOtpProvisionalWithDateTime != current.otpSigninSessionOtpProvisionalWithDateTime;
}

bool whenLoginOtpSigninVerifyScreenPageActive(LoginState state) {
  return state.otpSigninSessionOtpProvisionalWithDateTime != null;
}

@RoutePage()
class LoginOtpSigninRouterPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginOtpSigninRouterPage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: whenLoginOtpSigninRouterPageChange,
      builder: (context, state) {
        return AutoRouter.declarative(
          routes: (handler) {
            return [
              const LoginOtpSigninRequestScreenPageRoute(),
              if (whenLoginOtpSigninVerifyScreenPageActive(state)) const LoginOtpSigninVerifyScreenPageRoute(),
            ];
          },
          onPopRoute: (route, results) {
            switch (route.name) {
              case LoginOtpSigninVerifyScreenPageRoute.name:
                _onLoginOtpSigninVerifyScreenPageBack(context);
                break;
            }
          },
        );
      },
    );
  }

  void _onLoginOtpSigninVerifyScreenPageBack(BuildContext context) {
    context.read<LoginCubit>().loginOptSigninVerifyBack();
  }
}
