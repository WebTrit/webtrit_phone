import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/widgets/widgets.dart';
import 'package:webtrit_phone/app/constants.dart';

export 'login_switch_screen_style.dart';
export 'login_switch_screen_styles.dart.dart';

enum SafeAreaSide { top, bottom, left, right }

@RoutePage()
class LoginSwitchScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginSwitchScreenPage({
    required this.bodySafeAreaSides,
    this.forceLoginTypes,
    this.isLogoVisible = true,
    this.isAppBarVisible = true,
    this.style,
  });

  final Set<SafeAreaSide> bodySafeAreaSides;
  final List<LoginType>? forceLoginTypes;
  final bool isLogoVisible;
  final bool isAppBarVisible;
  final LoginSwitchScreenStyle? style;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final LoginSwitchScreenStyles? loginPageStyles = themeData.extension<LoginSwitchScreenStyles>();
    final LoginSwitchScreenStyle? localStyle = style ?? loginPageStyles?.primary;

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
                  ? Column(
                      children: [
                        ConfigurableThemeImage(style: localStyle?.pictureLogoStyle),
                        const SizedBox(height: kInset),
                      ],
                    )
                  : null,
              body: SafeArea(
                top: bodySafeAreaSides.contains(SafeAreaSide.top),
                bottom: bodySafeAreaSides.contains(SafeAreaSide.bottom),
                left: bodySafeAreaSides.contains(SafeAreaSide.left),
                right: bodySafeAreaSides.contains(SafeAreaSide.right),
                child: child,
              ),
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
