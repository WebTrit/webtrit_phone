import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class LoginSignupVerifyScreen extends StatelessWidget {
  const LoginSignupVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    final OutlinedButtonStyles? outlinedButtonStyles = themeData.extension<OutlinedButtonStyles>();

    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => whenLoginSignupVerifyScreenPageActive(current),
      builder: (context, state) {
        final sessionOtpProvisional = state.signupSessionOtpProvisionalWithDateTime!.$1;
        final isOtpNotificationEmail = sessionOtpProvisional.notificationType?.isEmail ?? false;
        final otpFromEmail = sessionOtpProvisional.fromEmail;

        final signupVerifyPreDescriptionText =
            context.l10n.login_Text_signupVerifyPreDescriptionEmail(state.signupEmailInput.value);
        final signupVerifyPostDescriptionText = isOtpNotificationEmail
            ? otpFromEmail == null
                ? context.l10n.login_Text_signupVerifyPostDescriptionGeneral
                : context.l10n.login_Text_signupVerifyPostDescriptionFromEmail(otpFromEmail)
            : '';

        return Container(
          padding: const EdgeInsets.fromLTRB(kInset, kInset / 2, kInset, kInset),
          color: themeData.scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (signupVerifyPreDescriptionText.isNotEmpty) ...[
                Description(
                  text: signupVerifyPreDescriptionText,
                ),
                const SizedBox(height: kInset / 2),
              ],
              TextFormField(
                enabled: !state.processing,
                initialValue: state.signupCodeInput.value,
                decoration: InputDecoration(
                  labelText: context.l10n.login_TextFieldLabelText_signupCode,
                  helperText: '', // reserve space for validator message
                  errorText: state.signupCodeInput.displayError?.l10n(context),
                  errorMaxLines: 3,
                ),
                keyboardType: TextInputType.number,
                autofillHints: const [
                  AutofillHints.oneTimeCode,
                  AutofillHints.password,
                ],
                onChanged: context.read<LoginCubit>().signupCodeInputChanged,
                onFieldSubmitted: !state.signupCodeInput.isValid ? null : (_) => _onSubmitted(context),
              ),
              if (signupVerifyPostDescriptionText.isNotEmpty) ...[
                const SizedBox(height: kInset / 8),
                Description(
                  text: signupVerifyPostDescriptionText,
                ),
              ],
              const Spacer(),
              const SizedBox(height: kInset),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CountDownBuilder(
                    start: state.signupSessionOtpProvisionalWithDateTime!.$2,
                    interval: const Duration(seconds: 30),
                    builder: (context, seconds) {
                      if (seconds == 0) {
                        return OutlinedButton(
                          onPressed: state.processing ? null : () => _onRepeat(context),
                          style: outlinedButtonStyles?.neutral,
                          child: Text(context.l10n.login_Button_signupVerifyRepeat),
                        );
                      } else {
                        return OutlinedButton(
                          onPressed: null,
                          style: outlinedButtonStyles?.neutral,
                          child: Text(context.l10n.login_Button_signupVerifyRepeatInterval(seconds)),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: kInset / 4),
                  ElevatedButton(
                    onPressed: state.processing || !state.signupCodeInput.isValid ? null : () => _onSubmitted(context),
                    style: elevatedButtonStyles?.primary,
                    child: !state.processing
                        ? Text(context.l10n.login_Button_signupVerifyProceed)
                        : SizedCircularProgressIndicator(
                            size: 16,
                            strokeWidth: 2,
                            color: elevatedButtonStyles?.primary?.foregroundColor?.resolve({}),
                          ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _onRepeat(BuildContext context) {
    context.read<LoginCubit>().loginSignupVerifyRepeat();
  }

  void _onSubmitted(BuildContext context) {
    context.read<LoginCubit>().loginSignupVerifySubmitted();
  }
}
