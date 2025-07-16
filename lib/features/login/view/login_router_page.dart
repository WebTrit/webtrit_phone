import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
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
  }) : _launchEmbedded = launchLoginEmbedded;

  final LoginEmbedded? _launchEmbedded;

  @override
  Widget build(BuildContext context) {
    final declarativeAutoRouter = BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        final coreUrl = state.coreUrl;
        final tenantId = state.tenantId;
        final token = state.token;
        final userId = state.userId;
        final systemInfo = state.systemInfo;

        if (coreUrl != null && tenantId != null && token != null && userId != null && systemInfo != null) {
          final event = AppLogined(
            coreUrl: coreUrl,
            tenantId: tenantId,
            token: token,
            userId: userId,
            systemInfo: systemInfo,
          );
          context.read<AppBloc>().add(event);
        }
      },
      buildWhen: whenLoginRouterPageChange,
      builder: (context, state) {
        return AutoRouter.declarative(
          navigatorObservers: () => [_HideCurrentSnackBarNavigatorObserver(context)],
          routes: (handler) {
            return [
              // Embedded page was not provided as launch, so use the native UI.
              if (_launchEmbedded == null) const LoginModeSelectScreenPageRoute(),

              // Open the core URL assignment screen (used in demo mode).
              // Note: this should be refactored to rely on a dedicated flag instead of demo mode.
              if (whenLoginCoreUrlAssignScreenPageActive(state)) const LoginCoreUrlAssignScreenPageRoute(),

              // After receiving server-provided login types (triggered from LoginModeSelectScreenPageRoute),
              // open the login switch screen.
              if (_launchEmbedded == null && whenLoginSwitchScreenPageActive(state))
                LoginSwitchScreenPageRoute(bodySafeAreaSides: const {SafeAreaSide.bottom}),

              // Embedded page was provided, so use the embedded UI via LoginSwitchScreenPageRoute.
              // Force a single login type to disable rendering of other tabs.
              // Also hide the native logo if the server provides multiple login types.
              if (_launchEmbedded != null)
                LoginSwitchScreenPageRoute(
                  // For full-screen embedded pages, SafeArea handling is delegated to the embedded page itself.
                  bodySafeAreaSides: const {},
                  // Uses LoginSignupEmbeddedRequestScreenPage to render the embedded content when _launchEmbedded is provided.
                  forceLoginTypes: const [LoginType.signup],
                  isLogoVisible: false,
                  isAppBarVisible: false,
                ),
            ];
          },
          onPopRoute: (route, results) {
            switch (route.name) {
              case LoginCoreUrlAssignScreenPageRoute.name:
                _onCoreUrlAssignBack(context);
                break;
              case LoginSignupEmbeddedRequestScreenPageRoute.name:
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

    final login = LoginCubit(
      notificationsBloc: context.read<NotificationsBloc>(),
      packageInfo: context.read<PackageInfo>(),
      appInfo: context.read<AppInfo>(),
      platformInfo: context.read<PlatformInfo>(),
    );
    if (_launchEmbedded != null) {
      login.setEmbedded(_launchEmbedded);
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
