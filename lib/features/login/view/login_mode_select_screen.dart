import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../login.dart';

export 'login_mode_select_screen_style.dart';
export 'login_mode_select_screen_styles.dart';

class LoginModeSelectScreen extends StatelessWidget {
  const LoginModeSelectScreen({
    super.key,
    this.appGreeting,
    required this.actions,
    this.style,
  });

  final String? appGreeting;

  final List<LoginModeAction> actions;
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
        // TODO(Serdun): Looks like we can move logic with enabling demo mode to the app config
        final isDemoModeEnabled = context.read<LoginCubit>().isDemoModeEnabled;

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
                      onPressed: state.processing ? null : () => _onCustomCoreLogin(context),
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
                ...actions.map((button) {
                  return ElevatedButton(
                    onPressed: state.processing ? null : () => _onActionItemTap(context, isDemoModeEnabled, button),
                    style: elevatedButtonStyles?.getStyle(localStyle?.signUpTypeButton),
                    child: !state.processing || button.flavor != LoginFlavor.login
                        ? Text(context.parseL10n(button.titleL10n))
                        : SizedCircularProgressIndicator(
                            size: 16,
                            strokeWidth: 2,
                            color: elevatedButtonStyles?.primary?.foregroundColor?.resolve({}),
                          ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onActionItemTap(BuildContext context, bool demo, LoginModeAction button) {
    switch (button.flavor) {
      case LoginFlavor.login:
        context.read<LoginCubit>().loginModeSelectSubmitted(demo ? LoginMode.demoCore : LoginMode.core);
        break;
      case LoginFlavor.embedded:
        context.read<LoginCubit>().setCustomLogin((button as LoginEmbeddedModeButton).customLoginFeature);
        break;
    }
  }

  void _onCustomCoreLogin(BuildContext context) {
    context.read<LoginCubit>().loginModeSelectSubmitted(LoginMode.customCore);
  }
}
