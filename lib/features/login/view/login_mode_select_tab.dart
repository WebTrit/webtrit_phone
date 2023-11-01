import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../login.dart';

class LoginModeSelectTab extends StatelessWidget {
  const LoginModeSelectTab({
    super.key,
    this.appGreeting,
  });

  final String? appGreeting;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final Gradients? gradients = themeData.extension<Gradients>();
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.ok) {
          context.hideCurrentSnackBar();
          context.read<LoginCubit>().next();
        } else {
          final errorL10n = state.errorL10n(context);
          if (errorL10n != null) {
            context.showErrorSnackBar(errorL10n);
            context.read<LoginCubit>().dismissError();
          }
        }
      },
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
                      onPressed: !state.status.isInput
                          ? null
                          : () => context.read<LoginCubit>().loginModeSelectSubmitter(false),
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
                        !state.status.isInput ? null : () => context.read<LoginCubit>().loginModeSelectSubmitter(true),
                    style: elevatedButtonStyles?.primaryOnDark,
                    child: state.status.isInput
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
                        !state.status.isInput ? null : () => context.read<LoginCubit>().loginModeSelectSubmitter(false),
                    style: elevatedButtonStyles?.primary,
                    child: state.status.isInput
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
