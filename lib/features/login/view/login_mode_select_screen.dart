import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../login.dart';

export 'login_mode_select_screen_style.dart';
export 'login_mode_select_screen_styles.dart';

class LoginModeSelectScreen extends StatelessWidget {
  const LoginModeSelectScreen({
    super.key,
    this.appGreeting,
    this.style,
  });

  final String? appGreeting;

  final LoginModeSelectScreenStyle? style;

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
        final isDemoModeEnabled = context.read<LoginCubit>().isDemoModeEnabled;
        final isCredentialsRequestUrlEnabled = context.read<LoginCubit>().isCredentialsRequestUrlEnabled;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: isDemoModeEnabled
                ? [
                    IconButton(
                      icon: Icon(
                        Icons.link,
                        // color set here because of https://github.com/flutter/flutter/issues/110878
                        color: themeData.colorScheme.onPrimary,
                      ),
                      tooltip: context.l10n.login_ButtonTooltip_signInToYourInstance,
                      onPressed: state.processing
                          ? null
                          : () => context.read<LoginCubit>().loginModeSelectSubmitted(LoginMode.customCore),
                    ),
                  ]
                : null,
          ),
          body: Container(
            padding: const EdgeInsets.fromLTRB(kInset, 0, kInset, kInset),
            decoration: BoxDecoration(
              gradient: gradients?.tab,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                OnboardingPictureLogo(
                  text: appGreeting,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: state.processing
                      ? null
                      : () => context
                          .read<LoginCubit>()
                          .loginModeSelectSubmitted(isDemoModeEnabled ? LoginMode.demoCore : LoginMode.core),
                  style: elevatedButtonStyles?.getStyle(localStyle?.signUpTypeButton),
                  child: !state.processing
                      ? Text(isDemoModeEnabled
                          ? context.l10n.login_Button_signUpToDemoInstance
                          : context.l10n.login_Button_signIn)
                      : SizedCircularProgressIndicator(
                          size: 16,
                          strokeWidth: 2,
                          color: elevatedButtonStyles?.primary?.foregroundColor?.resolve({}),
                        ),
                ),
                if (isCredentialsRequestUrlEnabled)
                  TextButton(
                    onPressed: () => context.read<LoginCubit>().loginModeSelectSubmitted(LoginMode.credentialsRequest),
                    child: Text(context.l10n.login_requestCredentials_button),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
