import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../login.dart';

class LoginModeSelectScreen extends StatelessWidget {
  const LoginModeSelectScreen({
    super.key,
    this.appGreeting,
  });

  final String? appGreeting;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final Gradients? gradients = themeData.extension<Gradients>();
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
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
                      onPressed:
                          state.processing ? null : () => context.read<LoginCubit>().loginModeSelectSubmitter(false),
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
                  color: themeData.colorScheme.onPrimary,
                  text: appGreeting,
                ),
                const Spacer(),
                if (isDemoModeEnabled)
                  ElevatedButton(
                    onPressed:
                        state.processing ? null : () => context.read<LoginCubit>().loginModeSelectSubmitter(true),
                    style: elevatedButtonStyles?.primaryOnDark,
                    child: !state.processing
                        ? Text(context.l10n.login_Button_signUpToDemoInstance)
                        : SizedCircularProgressIndicator(
                            size: 16,
                            strokeWidth: 2,
                            color: elevatedButtonStyles?.primaryOnDark?.foregroundColor?.resolve({}),
                          ),
                  )
                else
                  ElevatedButton(
                    onPressed:
                        state.processing ? null : () => context.read<LoginCubit>().loginModeSelectSubmitter(false),
                    style: elevatedButtonStyles?.primary,
                    child: !state.processing
                        ? Text(context.l10n.login_Button_signIn)
                        : SizedCircularProgressIndicator(
                            size: 16,
                            strokeWidth: 2,
                            color: elevatedButtonStyles?.primary?.foregroundColor?.resolve({}),
                          ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
