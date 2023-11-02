import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/auth/cubit/auth_cubit.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';
import 'package:webtrit_phone/features/auth/extensions/extensions.dart';

import '../cubit/mode_select_cubit.dart';
import '../widgets/widgets.dart';

class ModeSelectScreen extends StatelessWidget {
  const ModeSelectScreen({
    Key? key,
    this.appGreeting,
  }) : super(key: key);

  final String? appGreeting;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final Gradients? gradients = themeData.extension<Gradients>();
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    return BlocConsumer<ModeSelectCubit, ModeSelectState>(
      listener: (context, state) {
        if (state.status == ModeSelectStatus.error) {
          if (state.error != null) {
            final errorL10n = state.error!.errorL10n(context);
            context.showErrorSnackBar(errorL10n);
          }
        }

        switch (state.direction) {
          case ModeSelectDirection.signUp:
            GoRouter.of(context).goNamed(AppRoute.loginTypes);
          case ModeSelectDirection.coreUrl:
            GoRouter.of(context).goNamed(AppRoute.loginCoreUrl);
          case null:
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: state.demo
                ? [
                    IconButton(
                      icon: Icon(
                        Icons.link,
                        // color set here because of https://github.com/flutter/flutter/issues/110878
                        color: themeData.colorScheme.onPrimary,
                      ),
                      tooltip: context.l10n.login_ButtonTooltip_signInToYourInstance,
                      onPressed: () => GoRouter.of(context).goNamed(AppRoute.loginCoreUrl),
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
                if (state.demo)
                  ElevatedButton(
                    onPressed: () => context.read<ModeSelectCubit>().signUp(),
                    style: elevatedButtonStyles?.primaryOnDark,
                    child: !state.isProcessing
                        ? Text(context.l10n.login_Button_signUpToDemoInstance)
                        : SizedCircularProgressIndicator(
                            size: 16,
                            strokeWidth: 2,
                            color: elevatedButtonStyles?.primaryOnDark?.foregroundColor?.resolve({}),
                          ),
                  )
                else
                  ElevatedButton(
                    onPressed: () => context.read<ModeSelectCubit>().signUp(),
                    style: elevatedButtonStyles?.primary,
                    child: !state.isProcessing
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
