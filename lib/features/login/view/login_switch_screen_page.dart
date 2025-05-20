import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class LoginSwitchScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginSwitchScreenPage({
    this.forceLoginTypes = const [],
    this.isLogoVisible = true,
  });

  final List<LoginType> forceLoginTypes;
  final bool isLogoVisible;

  @override
  Widget build(BuildContext context) {
    if (forceLoginTypes.isNotEmpty) {
      return _buildTabs(forceLoginTypes);
    }

    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
      whenLoginSwitchScreenPageActive(current) && previous.supportedLoginTypes != current.supportedLoginTypes,
      builder: (context, state) {
        final supportedLoginTypes = state.supportedLoginTypes!;
        return _buildTabs(supportedLoginTypes);
      },
    );
  }

  Widget _buildTabs(List<LoginType> types) {
    return AutoTabsRouter(
      routes: types.map((e) => e.toPageRouteInfo()).toList(growable: false),
      duration: Duration.zero,
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return LoginSwitchScreen(
          body: child,
          currentLoginType: types[tabsRouter.activeIndex],
          supportedLoginTypes: types,
          onLoginTypeChanged: (loginType) {
            tabsRouter.setActiveIndex(types.indexOf(loginType));
          },
          isLogoVisible: isLogoVisible,
        );
      },
    );
  }
}
