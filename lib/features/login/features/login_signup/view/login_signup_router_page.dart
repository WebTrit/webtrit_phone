import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';

import 'package:webtrit_phone/features/features.dart';

bool whenLoginSignupRouterPageChange(LoginState previous, LoginState current) {
  return previous.signupSessionOtpProvisionalWithDateTime != current.signupSessionOtpProvisionalWithDateTime;
}

bool whenLoginSignupVerifyScreenPageActive(LoginState state) {
  return state.signupSessionOtpProvisionalWithDateTime != null;
}

@RoutePage()
class LoginSignupRouterPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginSignupRouterPage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: whenLoginSignupRouterPageChange,
      builder: (context, state) {
        return AutoRouter.declarative(
          routes: (handler) {
            return [
              const LoginSignupRequestScreenPageRoute(),
              if (whenLoginSignupVerifyScreenPageActive(state)) const LoginSignupVerifyScreenPageRoute(),
            ];
          },
          onPopRoute: (route, results) {
            switch (route.name) {
              case LoginSignupVerifyScreenPageRoute.name:
                _onLoginSignupVerifyBack(context);
                break;
            }
          },
        );
      },
    );
  }

  void _onLoginSignupVerifyBack(BuildContext context) {
    context.read<LoginCubit>().loginSignupVerifyBack();
  }
}
