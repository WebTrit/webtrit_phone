import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../login.dart';

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
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == LoginStatus.ok) {
          context.read<LoginCubit>().next();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: gradients?.tab,
        ),
        child: Padding(
          padding: kTabLabelPadding * 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OnboardingLogo(
                color: themeData.colorScheme.onPrimary,
              ),
              const OnboardingPicture(),
              const Expanded(child: SizedBox()),
              ElevatedButton(
                onPressed: () => context.read<LoginCubit>().loginModeSelectSubmitter(false),
                style: elevatedButtonStyles?.primary,
                child: Text(context.l10n.loginModeSelectionTabSignInButtonLabel),
              ),
              const SizedBox(height: kToolbarHeight / 4),
              ElevatedButton(
                onPressed: () => context.read<LoginCubit>().loginModeSelectSubmitter(true),
                style: elevatedButtonStyles?.neutral,
                child: Text(context.l10n.loginModeSelectionTabDemoButtonLabel),
              ),
              const SizedBox(height: kToolbarHeight / 2),
            ],
          ),
        ),
      ),
    );
  }
}
