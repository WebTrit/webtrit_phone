import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

bool whenLoginRouterPageChange(LoginState previous, LoginState current) {
  return (previous.mode != current.mode) ||
      (previous.coreUrl != current.coreUrl || previous.supportedLoginTypes != current.supportedLoginTypes) ||
      previous.embedded != current.embedded;
}

bool whenLoginEmbeddedScreenPageActive(LoginState state) {
  return state.embedded != null;
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
  const LoginRouterPage({
    LoginEmbedded? launchLoginEmbedded,
  }) : _launchLoginEmbedded = launchLoginEmbedded;

  final LoginEmbedded? _launchLoginEmbedded;

  bool get isLaunchLoginEmbedded => _launchLoginEmbedded != null;

  @override
  Widget build(BuildContext context) {
    final declarativeAutoRouter = BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        final [coreUrl, tenantId, token, userId] = [state.coreUrl, state.tenantId, state.token, state.userId];

        if (coreUrl != null && tenantId != null && token != null && userId != null) {
          final event = AppLogined(coreUrl: coreUrl, tenantId: tenantId, token: token, userId: userId);
          context.read<AppBloc>().add(event);
        }
      },
      buildWhen: whenLoginRouterPageChange,
      builder: (context, state) {
        return AutoRouter.declarative(
          navigatorObservers: () => [_HideCurrentSnackBarNavigatorObserver(context)],
          routes: (handler) {
            return [
              if (!isLaunchLoginEmbedded) const LoginModeSelectScreenPageRoute(),
              if (whenLoginCoreUrlAssignScreenPageActive(state)) const LoginCoreUrlAssignScreenPageRoute(),
              if (whenLoginEmbeddedScreenPageActive(state))
                LoginEmbeddedScreenPageRoute(loginEmbedded: state.embedded!),
              if (whenLoginSwitchScreenPageActive(state)) const LoginSwitchScreenPageRoute(),
            ];
          },
          onPopRoute: (route, results) {
            switch (route.name) {
              case LoginCoreUrlAssignScreenPageRoute.name:
                _onCoreUrlAssignBack(context);
                break;
              case LoginEmbeddedScreenPageRoute.name:
                _onEmbeddedPageAssignBackAssignBack(context);
                break;
              case LoginSwitchScreenPageRoute.name:
                _onSwitchBack(context);
                break;
            }
          },
        );
      },
    );

    final login = LoginCubit(notificationsBloc: context.read<NotificationsBloc>());
    if (_launchLoginEmbedded != null) {
      login.setCustomLogin(_launchLoginEmbedded);
    }
    final provider = BlocProvider(
      create: (context) => login,
      child: declarativeAutoRouter,
    );
    return provider;
  }

  void _onCoreUrlAssignBack(BuildContext context) {
    context.read<LoginCubit>().loginCoreUrlAssignBack();
  }

  void _onEmbeddedPageAssignBackAssignBack(BuildContext context) {
    context.read<LoginCubit>().embeddedPageAssignBack();
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
