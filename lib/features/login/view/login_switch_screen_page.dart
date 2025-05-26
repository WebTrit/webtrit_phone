import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/widgets/widgets.dart';
import 'package:webtrit_phone/app/constants.dart';

@RoutePage()
class LoginSwitchScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginSwitchScreenPage({
    this.forceLoginTypes,
    this.isLogoVisible = true,
    this.isAppBarVisible = true,
  });

  final List<LoginType>? forceLoginTypes;
  final bool isLogoVisible;
  final bool isAppBarVisible;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          whenLoginSwitchScreenPageActive(current) && previous.supportedLoginTypes != current.supportedLoginTypes,
      builder: (context, state) {
        final supportedLoginTypes = forceLoginTypes ?? state.supportedLoginTypes!;
        return AutoTabsRouter(
          routes: supportedLoginTypes.map((e) => e.toPageRouteInfo()).toList(growable: false),
          duration: Duration.zero,
          builder: (context, child) {
            final tabsRouter = AutoTabsRouter.of(context);
            return LoginSwitchScreen(
              appBar: isAppBarVisible
                  ? AppBar(
                      leading: ExtBackButton(disabled: state.processing),
                      backgroundColor: Colors.transparent,
                    )
                  : null,
              header: isLogoVisible
                  ? const Column(
                      children: [
                        OnboardingLogo(),
                        SizedBox(height: kInset),
                      ],
                    )
                  : null,
              body: child,
              currentLoginType: supportedLoginTypes[tabsRouter.activeIndex],
              supportedLoginTypes: supportedLoginTypes,
              onLoginTypeChanged: (loginType) => tabsRouter.setActiveIndex(supportedLoginTypes.indexOf(loginType)),
            );
          },
        );
      },
    );
  }
}
