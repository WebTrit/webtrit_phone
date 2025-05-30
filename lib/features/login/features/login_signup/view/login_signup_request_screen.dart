import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class LoginSignupRequestScreen extends StatelessWidget {
  const LoginSignupRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final signupRequestPreDescriptionText = state.mode != LoginMode.demoCore
            ? context.l10n.login_Text_signupRequestPreDescription
            : context.l10n.login_Text_signupRequestPreDescriptionDemo;
        final signupRequestPostDescriptionText = state.mode != LoginMode.demoCore
            ? context.l10n.login_Text_signupRequestPostDescription
            : context.l10n.login_Text_signupRequestPostDescriptionDemo;

        return Container(
          padding: const EdgeInsets.fromLTRB(kInset, kInset / 2, kInset, kInset),
          color: themeData.scaffoldBackgroundColor,
          child: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (signupRequestPreDescriptionText.isNotEmpty) ...[
                  Description(
                    text: signupRequestPreDescriptionText,
                  ),
                  const SizedBox(height: kInset / 2),
                ],
                TextFormField(
                  key: signupEmailInputKey,
                  enabled: !state.processing,
                  initialValue: state.signupEmailInput.value,
                  decoration: InputDecoration(
                    labelText: context.l10n.login_TextFieldLabelText_signupEmail,
                    helperText: '', // reserve space for validator message
                    errorText: state.signupEmailInput.displayError?.l10n(context),
                    errorMaxLines: 3,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [
                    AutofillHints.email,
                  ],
                  onChanged: context.read<LoginCubit>().signupEmailInputChanged,
                  onFieldSubmitted: !state.signupEmailInput.isValid ? null : (_) => _onSubmitted(context),
                ),
                if (signupRequestPostDescriptionText.isNotEmpty) ...[
                  const SizedBox(height: kInset / 2),
                  Description(
                    text: signupRequestPostDescriptionText,
                  ),
                ],
                const Spacer(),
                const SizedBox(height: kInset),
                ElevatedButton(
                  key: signupEmailButtonKey,
                  onPressed: state.processing || !state.signupEmailInput.isValid ? null : () => _onSubmitted(context),
                  style: elevatedButtonStyles?.primary,
                  child: !state.processing
                      ? Text(context.l10n.login_Button_signupRequestProceed)
                      : SizedCircularProgressIndicator(
                          size: 16,
                          strokeWidth: 2,
                          color: elevatedButtonStyles?.primary?.foregroundColor?.resolve({}),
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSubmitted(BuildContext context) {
    context.read<LoginCubit>().loginSignupRequestSubmitted();
  }
}
