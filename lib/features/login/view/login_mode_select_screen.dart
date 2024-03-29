import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/features.dart';
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
      buildWhen: (previous, current) => previous.processing != current.processing,
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
                  color: themeData.colorScheme.onPrimary,
                  text: appGreeting,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: state.processing
                      ? null
                      : () => context
                          .read<LoginCubit>()
                          .loginModeSelectSubmitted(isDemoModeEnabled ? LoginMode.demoCore : LoginMode.core),
                  style: elevatedButtonStyles?.primary,
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
                const SizedBox(
                  height: 8,
                ),
                TextButton(
                  onPressed: () => context.read<LoginCubit>().loginSignp(),
                  // onPressed: () => context.router.navigate(
                  //     LoginSignupFormRequestScreenPageRoute(initialUriQueryParam: "https://www.nashua.co.za/contact/")),
                  style: elevatedButtonStyles?.primary
                      ?.copyWith(backgroundColor: const MaterialStatePropertyAll(Colors.transparent)),
                  child: Text(context.l10n.login_Button_signUpToDemoInstance),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void openPage(String link) async {
    final url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
