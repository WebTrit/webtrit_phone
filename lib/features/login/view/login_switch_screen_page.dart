import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class LoginSwitchScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginSwitchScreenPage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          whenLoginSwitchScreenPageActive(current) && (previous.supportedLoginTypes != current.supportedLoginTypes),
      builder: (context, state) {
        final supportedLoginTypes = state.supportedLoginTypes!;
        return AutoTabsRouter(
          routes: supportedLoginTypes.map((loginType) => loginType.toPageRouteInfo()).toList(growable: false),
          duration: Duration.zero,
          builder: (context, child) {
            final tabsRouter = AutoTabsRouter.of(context);
            return LoginSwitchScreen(
              body: child,
              currentLoginType: supportedLoginTypes[tabsRouter.activeIndex],
              supportedLoginTypes: supportedLoginTypes,
              onLoginTypeChanged: (loginType) {
                tabsRouter.setActiveIndex(supportedLoginTypes.indexOf(loginType));
              },
            );
          },
        );
      },
    );
  }
}
