import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';

bool whenLoginRouterPageChange(LoginState previous, LoginState current) {
  return (previous.mode != current.mode) ||
      (previous.coreUrl != current.coreUrl || previous.supportedLoginTypes != current.supportedLoginTypes);
}

bool whenLoginCoreUrlAssignScreenPageActive(LoginState state) {
  return state.mode == LoginMode.customCore;
}

bool whenLoginSwitchScreenPageActive(LoginState state) {
  return state.coreUrl != null && state.supportedLoginTypes != null;
}

@RoutePage()
class LoginRouterPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginRouterPage();

  @override
  Widget build(BuildContext context) {
    final declarativeAutoRouter = BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        final errorL10n = state.errorL10n(context);
        if (errorL10n != null) {
          context.showErrorSnackBar(errorL10n);
          context.read<LoginCubit>().dismissError();
        }

        if (state.coreUrl != null && state.tenantId != null && state.token != null) {
          context.read<AppBloc>().add(AppLogined(
                coreUrl: state.coreUrl!,
                tenantId: state.tenantId!,
                token: state.token!,
              ));
        }
      },
      buildWhen: whenLoginRouterPageChange,
      builder: (context, state) {
        return AutoRouter.declarative(
          navigatorObservers: () => [_HideCurrentSnackBarNavigatorObserver(context)],
          routes: (handler) {
            return [
              const LoginModeSelectScreenPageRoute(),
              if (whenLoginCoreUrlAssignScreenPageActive(state)) const LoginCoreUrlAssignScreenPageRoute(),
              if (whenLoginSwitchScreenPageActive(state)) const LoginSwitchScreenPageRoute(),
            ];
          },
          onPopRoute: (route, results) {
            switch (route.name) {
              case LoginCoreUrlAssignScreenPageRoute.name:
                _onCoreUrlAssignBack(context);
                break;
              case LoginSwitchScreenPageRoute.name:
                _onSwitchBack(context);
                break;
            }
          },
        );
      },
    );

    final provider = BlocProvider(
      create: (context) => LoginCubit(),
      child: declarativeAutoRouter,
    );
    return provider;
  }

  void _onCoreUrlAssignBack(BuildContext context) {
    context.read<LoginCubit>().loginCoreUrlAssignBack();
  }

  void _onSwitchBack(BuildContext context) {
    context.read<LoginCubit>().loginSwitchBack();
  }
}

class _HideCurrentSnackBarNavigatorObserver extends NavigatorObserver {
  _HideCurrentSnackBarNavigatorObserver(this.context);

  final BuildContext context;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    context.hideCurrentSnackBar();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    context.hideCurrentSnackBar();
  }
}
