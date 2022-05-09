import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/styles/styles.dart';

import '../../../widgets/login_carousel.dart';
import '../login.dart';

class LoginModeSelectionTab extends StatelessWidget {
  const LoginModeSelectionTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.gradientTop,
          AppColors.gradientBottom,
        ],
      )),
      child: Padding(
        padding: kTabLabelPadding * 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LoginCarouselPictureLogo(),
            const LoginCarouselPictureGirl(),
            const Expanded(child: SizedBox()),
            TextButton(
              onPressed: null,
              style: AppTextButtonStyle.primaryThick,
              child: Text(context.l10n.loginModeSelectionTabSignInButtonLabel),
            ),
            const SizedBox(height: kToolbarHeight / 4),
            TextButton(
              onPressed: () {
                context.read<LoginCubit>().next();
              },
              style: AppTextButtonStyle.primaryThick,
              child: Text(context.l10n.loginModeSelectionTabDemoButtonLabel),
            ),
            const SizedBox(height: kToolbarHeight / 2),
          ],
        ),
      ),
    );
  }
}
