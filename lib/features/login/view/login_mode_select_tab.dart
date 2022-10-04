import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../login.dart';
import 'constants.dart';

class LoginModeSelectTab extends StatelessWidget {
  const LoginModeSelectTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final Gradients? gradients = themeData.extension<Gradients>();
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status || previous.error != current.error,
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
      child: Container(
        decoration: BoxDecoration(
          gradient: gradients?.tab,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
            ),
            OnboardingLogo(
              color: themeData.colorScheme.onPrimary,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(kInset, kInset, kInset, 0),
              child: OnboardingPicture(),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(kInset, 0, kInset, kInset),
              child: BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (previous, current) => previous.status != current.status || previous.error != current.error,
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: context.read<LoginCubit>().isDemoModeEnabled
                        ? [
                            ElevatedButton(
                              onPressed: state.status.isProcessing
                                  ? null
                                  : () => context.read<LoginCubit>().loginModeSelectSubmitter(true),
                              style: elevatedButtonStyles?.primary,
                              child: !state.status.isProcessing
                                  ? Text(context.l10n.login_Button_signUpToDemoInstance)
                                  : SizedCircularProgressIndicator(
                                      size: 16,
                                      strokeWidth: 2,
                                      color: elevatedButtonStyles?.primary?.foregroundColor?.resolve({}),
                                    ),
                            ),
                            const SizedBox(height: kInset / 4),
                            ElevatedButton(
                              onPressed: state.status.isProcessing
                                  ? null
                                  : () => context.read<LoginCubit>().loginModeSelectSubmitter(false),
                              style: elevatedButtonStyles?.neutral,
                              child: Text(context.l10n.login_Button_signInToYourInstance),
                            ),
                          ]
                        : [
                            ElevatedButton(
                              onPressed: state.status.isProcessing
                                  ? null
                                  : () => context.read<LoginCubit>().loginModeSelectSubmitter(false),
                              style: elevatedButtonStyles?.primary,
                              child: !state.status.isProcessing
                                  ? Text(context.l10n.login_Button_signIn)
                                  : SizedCircularProgressIndicator(
                                      size: 16,
                                      strokeWidth: 2,
                                      color: elevatedButtonStyles?.primary?.foregroundColor?.resolve({}),
                                    ),
                            ),
                          ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
