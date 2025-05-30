import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../login.dart';

export 'login_mode_select_screen_style.dart';
export 'login_mode_select_screen_styles.dart';

class LoginModeSelectScreen extends StatelessWidget {
  const LoginModeSelectScreen({
    super.key,
    this.appGreetingL10n,
    this.style,
    required this.launchButtons,
  });

  final String? appGreetingL10n;

  final LoginModeSelectScreenStyle? style;
  final List<LoginModeAction> launchButtons;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final Gradients? gradients = themeData.extension<Gradients>();
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    final LoginModeSelectScreenStyles? loginPageStyles = themeData.extension<LoginModeSelectScreenStyles>();
    final LoginModeSelectScreenStyle? localStyle = style ?? loginPageStyles?.primary;

    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.processing != current.processing,
      builder: (context, state) {
        // TODO(Serdun): Looks like we can move logic with enabling demo mode to the app config
        final isDemoModeEnabled = context.read<LoginCubit>().isDemoModeEnabled;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: isDemoModeEnabled
                ? [
                    IconButton(
                      key: loginModeScreenUrlButtonKey,
                      icon: Icon(
                        Icons.link,
                        // color set here because of https://github.com/flutter/flutter/issues/110878
                        color: themeData.colorScheme.onPrimary,
                      ),
                      tooltip: context.l10n.login_ButtonTooltip_signInToYourInstance,
                      onPressed: state.processing ? null : () => _onCustomCoreLogin(context),
                    ),
                  ]
                : null,
          ),
          body: SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(kInset, 0, kInset, kInset),
              decoration: BoxDecoration(
                gradient: gradients?.tab,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  OnboardingPictureLogo(
                    text: appGreetingL10n != null ? context.parseL10n(appGreetingL10n!) : null,
                  ),
                  const Spacer(),
                  const Spacer(),
                  ...launchButtons.map<Widget>((button) {
                    final isEmbedded = button.isEmbeddedModeButton;
                    final shouldProcess = state.processing;

                    // Determine if the button should show a loading state:
                    // - If the app is processing:
                    //   - For non-embedded buttons: show loading only when no embedded switch is active
                    //   - For embedded buttons: show loading only if the active embedded config matches this button
                    final processing = shouldProcess &&
                        ((!isEmbedded && state.embedded == null) ||
                            (isEmbedded && state.embedded == button.toEmbedded?.customLoginFeature));

                    return SafeArea(
                      child: LoginModeActionButton(
                        processing: processing,
                        isDemoModeEnabled: isDemoModeEnabled,
                        onPressed: shouldProcess ? null : () => _onActionPressed(context, button),
                        style: elevatedButtonStyles?.getStyle(localStyle?.signUpTypeButton),
                        title: context.parseL10n(button.titleL10n),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onActionPressed(BuildContext context, LoginModeAction action) {
    final cubit = context.read<LoginCubit>();
    final mode = cubit.isDemoModeEnabled ? LoginMode.demoCore : LoginMode.core;

    if (action.flavor == LoginFlavor.embedded) {
      cubit.setEmbedded(action.toEmbedded!.customLoginFeature);
    }

    cubit.loginModeSelectSubmitted(mode);
  }

  void _onCustomCoreLogin(BuildContext context) {
    context.read<LoginCubit>().loginModeSelectSubmitted(LoginMode.customCore);
  }
}
