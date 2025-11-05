import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class LoginOtpSigninRequestScreen extends StatelessWidget {
  const LoginOtpSigninRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final otpSigninRequestPreDescriptionText = context.l10n.login_Text_otpSigninRequestPreDescription;
        final otpSigninRequestPostDescriptionText = context.l10n.login_Text_otpSigninRequestPostDescription;

        return Container(
          padding: const EdgeInsets.fromLTRB(kInset, kInset / 2, kInset, kInset),
          color: themeData.scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (otpSigninRequestPreDescriptionText.isNotEmpty) ...[
                Description(text: otpSigninRequestPreDescriptionText),
                const SizedBox(height: kInset / 2),
              ],
              TextFormField(
                key: optInputKey,
                enabled: !state.processing,
                initialValue: state.otpSigninUserRefInput.value,
                decoration: InputDecoration(
                  labelText: context.l10n.login_TextFieldLabelText_otpSigninUserRef,
                  helperText: '', // reserve space for validator message
                  errorText: state.otpSigninUserRefInput.displayError?.l10n(context),
                  errorMaxLines: 3,
                ),
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email, AutofillHints.telephoneNumber],
                onChanged: context.read<LoginCubit>().otpSigninUserRefInputChanged,
                onFieldSubmitted: !state.otpSigninUserRefInput.isValid ? null : (_) => _onSubmitted(context),
              ),
              if (otpSigninRequestPostDescriptionText.isNotEmpty) ...[
                const SizedBox(height: kInset / 2),
                Description(text: otpSigninRequestPostDescriptionText),
              ],
              const Spacer(),
              const SizedBox(height: kInset),
              ElevatedButton(
                key: otpButtonKey,
                onPressed: state.processing || !state.otpSigninUserRefInput.isValid
                    ? null
                    : () => _onSubmitted(context),
                style: elevatedButtonStyles?.primary,
                child: !state.processing
                    ? Text(context.l10n.login_Button_otpSigninRequestProceed)
                    : SizedCircularProgressIndicator(
                        size: 16,
                        strokeWidth: 2,
                        color: elevatedButtonStyles?.primary?.foregroundColor?.resolve({}),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onSubmitted(BuildContext context) {
    context.read<LoginCubit>().loginOptSigninRequestSubmitted();
  }
}
