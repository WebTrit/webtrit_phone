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

/// Represents  signup route.
///
/// If no `switchEmbedded` is provided, it uses the standard UI with
/// [LoginSignupRequestScreenPageRoute] (e.g., email signup).
///
/// If `switchEmbedded` is provided, it uses [LoginSignupEmbeddedRequestScreenPageRoute] instead.
@RoutePage()
class LoginSignupRouterPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginSignupRouterPage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: whenLoginSignupRouterPageChange,
      builder: (context, state) {
        final embedded = state.embedded;
        return AutoRouter.declarative(
          routes: (handler) {
            return [
              if (embedded == null) const LoginSignupRequestScreenPageRoute(),
              if (embedded != null) LoginSignupEmbeddedRequestScreenPageRoute(embeddedData: embedded),

              // In embedded flow, the webview occupies the full screen, including tabs and logo.
              // For the next native screen (e.g., OTP verification), a safe area is required to avoid UI overlap.
              if (whenLoginSignupVerifyScreenPageActive(state))
                LoginSignupVerifyScreenPageRoute(
                  bodySafeAreaSides: embedded != null ? SafeAreaSide.values.toSet() : {},
                ),
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
