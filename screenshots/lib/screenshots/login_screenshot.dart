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
/// pins which tab is shown first (used by the per-tab snapshots); when it is
/// null the first tab of the configured order is selected, so the interactive
/// preview follows `signinOrder`. Tapping a tab actually switches the body when
/// pointer interaction is enabled (snapshot mode just renders the initial tab).
///
/// The tab order itself always follows the app config `signinOrder` (read from
/// [FeatureAccess]), mirroring the real app via [sortLoginTypes].
class LoginScreenshot extends StatefulWidget {
  const LoginScreenshot({
    super.key,
    this.initialLoginType,
    this.supportedLoginTypes = const [LoginType.otpSignin, LoginType.passwordSignin, LoginType.signup],
  });

  final LoginType? initialLoginType;
  final List<LoginType> supportedLoginTypes;

  @override
  State<LoginScreenshot> createState() => _LoginScreenshotState();
}

class _LoginScreenshotState extends State<LoginScreenshot> {
  /// Set only once the user taps a tab in the interactive preview; keeps the
  /// manual selection while the configured order drives the default otherwise.
  LoginType? _userType;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final localStyle = themeData.extension<LoginSwitchScreenStyles>()?.primary;

    final featureAccess = context.watch<FeatureAccess?>();
    final embedded =
        featureAccess?.loginConfig.actions.firstWhereOrNull((element) => element.flavor == LoginFlavor.embedded)
            as LoginEmbeddedModeButton?;

    final signinOrder = featureAccess?.loginConfig.signinOrder ?? const <String>[];
    final orderedLoginTypes = sortLoginTypes(widget.supportedLoginTypes, orderConfig: signinOrder);
    final currentType = _resolveCurrentType(orderedLoginTypes);

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
        body: _bodyFor(context, currentType, embedded),
        currentLoginType: currentType,
        supportedLoginTypes: orderedLoginTypes,
        onLoginTypeChanged: (type) => setState(() => _userType = type),
      ),
    );
  }

  /// A manual tap wins (while still available); otherwise a pinned
  /// [LoginScreenshot.initialLoginType] wins; otherwise the configured first tab.
  LoginType _resolveCurrentType(List<LoginType> ordered) {
    if (_userType != null && ordered.contains(_userType)) return _userType!;
    if (widget.initialLoginType != null) return widget.initialLoginType!;
    return ordered.isNotEmpty ? ordered.first : LoginType.otpSignin;
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
    // No embedded resource configured → the app falls back to the native sign-up screen.
    if (embedded == null) {
      return const LoginSignupRequestScreen();
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
