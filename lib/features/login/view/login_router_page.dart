import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';

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
      buildWhen: (previous, current) =>
          previous.demo != current.demo ||
          previous.coreUrl != current.coreUrl ||
          previous.sessionOtpProvisional != current.sessionOtpProvisional,
      builder: (context, state) {
        final routes = <PageRouteInfo>[
          const LoginModeSelectScreenPageRoute(),
        ];
        if (state.demo != null) {
          if (state.demo == false) {
            routes.add(const LoginCoreUrlAssignScreenPageRoute());
          }
          if (state.coreUrl != null) {
            routes.add(const LoginOtpRequestScreenPageRoute());
            if (state.sessionOtpProvisional != null) {
              routes.add(const LoginOtpVerifyScreenPageRoute());
            }
          }
        }

        return AutoRouter.declarative(
          navigatorObservers: () => [_HideCurrentSnackBarNavigatorObserver(context)],
          routes: (handler) {
            return routes;
          },
          onPopRoute: (route, results) {
            switch (route.name) {
              case LoginCoreUrlAssignScreenPageRoute.name:
                _onCoreUrlAssignBack(context);
                break;
              case LoginOtpRequestScreenPageRoute.name:
                _onOtpRequestBack(context);
                break;
              case LoginOtpVerifyScreenPageRoute.name:
                _onOtpVerifyBack(context);
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

  void _onOtpRequestBack(BuildContext context) {
    context.read<LoginCubit>().loginOptRequestBack();
  }

  void _onOtpVerifyBack(BuildContext context) {
    context.read<LoginCubit>().loginOptVerifyBack();
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
