import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/iterable.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'package:screenshots/mocks/mocks.dart';

/// Single, parameterized and interactive login screenshot.
///
/// Replaces the former one-screenshot-per-tab duplication: [initialLoginType]
/// selects which tab is shown first, and tapping a tab actually switches the
/// body when pointer interaction is enabled (snapshot mode just renders the
/// initial tab).
class LoginScreenshot extends StatefulWidget {
  const LoginScreenshot({
    super.key,
    this.initialLoginType = LoginType.otpSignin,
    this.supportedLoginTypes = const [LoginType.otpSignin, LoginType.passwordSignin, LoginType.signup],
  });

  final LoginType initialLoginType;
  final List<LoginType> supportedLoginTypes;

  @override
  State<LoginScreenshot> createState() => _LoginScreenshotState();
}

class _LoginScreenshotState extends State<LoginScreenshot> {
  late LoginType _type = widget.initialLoginType;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final localStyle = themeData.extension<LoginSwitchScreenStyles>()?.primary;

    final embedded =
        context.watch<FeatureAccess?>()?.loginConfig.actions.firstWhereOrNull(
              (element) => element.flavor == LoginFlavor.embedded,
            )
            as LoginEmbeddedModeButton?;

    return BlocProvider<LoginCubit>(
      create: (context) => MockLoginCubit.loginSwitchScreen(embedded: embedded?.customLoginFeature),
      child: LoginSwitchScreen(
        appBar: AppBar(leading: const ExtBackButton(disabled: false), backgroundColor: Colors.transparent),
        header: Column(
          children: [
            ConfigurableThemeImage(style: localStyle?.pictureLogoStyle),
            const SizedBox(height: kInset),
          ],
        ),
        body: _bodyFor(context, _type, embedded),
        currentLoginType: _type,
        supportedLoginTypes: widget.supportedLoginTypes,
        onLoginTypeChanged: (type) => setState(() => _type = type),
      ),
    );
  }

  Widget _bodyFor(BuildContext context, LoginType type, LoginEmbeddedModeButton? embedded) {
    switch (type) {
      case LoginType.otpSignin:
        return const LoginOtpSigninRequestScreen();
      case LoginType.passwordSignin:
        return const LoginPasswordSigninScreen();
      case LoginType.signup:
        return _signupBody(context, embedded);
    }
  }

  Widget _signupBody(BuildContext context, LoginEmbeddedModeButton? embedded) {
    if (embedded == null) {
      return const Center(child: Text('Embedded page not set up'));
    }

    final appMetadataProvider = context.read<AppMetadataProvider>();
    return LoginSignupEmbeddedRequestScreen(
      initialUrl: embedded.customLoginFeature.uri,
      userAgent: appMetadataProvider.userAgent,
      mediaQueryMetricsData: null,
      deviceInfoData: null,
      pageInjectionStrategyBuilder: () => DefaultPayloadInjectionStrategy(),
      connectivityRecoveryStrategyBuilder: () => NoneConnectivityRecoveryStrategy(),
    );
  }
}
