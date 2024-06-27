import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class LoginOtpSigninVerifyScreen extends StatelessWidget {
  const LoginOtpSigninVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    final OutlinedButtonStyles? outlinedButtonStyles = themeData.extension<OutlinedButtonStyles>();

    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => whenLoginOtpSigninVerifyScreenPageActive(current),
      builder: (context, state) {
        final sessionOtpProvisional = state.otpSigninSessionOtpProvisionalWithDateTime!.$1;
        final isOtpNotificationEmail = sessionOtpProvisional.notificationType?.isEmail ?? false;
        final otpFromEmail = sessionOtpProvisional.fromEmail;

        final otpSigninVerifyPreDescriptionText =
            context.l10n.login_Text_otpSigninVerifyPreDescriptionUserRef(state.otpSigninUserRefInput.value);
        final otpSigninVerifyPostDescriptionText = isOtpNotificationEmail
            ? otpFromEmail == null
                ? context.l10n.login_Text_otpSigninVerifyPostDescriptionGeneral
                : context.l10n.login_Text_otpSigninVerifyPostDescriptionFromEmail(otpFromEmail)
            : '';

        return Container(
          padding: const EdgeInsets.fromLTRB(kInset, kInset / 2, kInset, kInset),
          color: themeData.scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (otpSigninVerifyPreDescriptionText.isNotEmpty) ...[
                Description(
                  text: otpSigninVerifyPreDescriptionText,
                ),
                const SizedBox(height: kInset / 2),
              ],
              TextFormField(
                key: const Key(otpVerifyInputKey),
                enabled: !state.processing,
                initialValue: state.otpSigninCodeInput.value,
                decoration: InputDecoration(
                  labelText: context.l10n.login_TextFieldLabelText_otpSigninCode,
                  helperText: '', // reserve space for validator message
                  errorText: state.otpSigninCodeInput.displayError?.l10n(context),
                  errorMaxLines: 3,
                ),
                keyboardType: TextInputType.number,
                autofillHints: const [
                  AutofillHints.oneTimeCode,
                  AutofillHints.password,
                ],
                onChanged: context.read<LoginCubit>().otpSigninCodeInputChanged,
                onFieldSubmitted: !state.otpSigninCodeInput.isValid ? null : (_) => _onSubmitted(context),
              ),
              if (otpSigninVerifyPostDescriptionText.isNotEmpty) ...[
                const SizedBox(height: kInset / 8),
                Description(
                  text: otpSigninVerifyPostDescriptionText,
                ),
              ],
              const Spacer(),
              const SizedBox(height: kInset),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CountDownBuilder(
                    start: state.otpSigninSessionOtpProvisionalWithDateTime!.$2,
                    interval: const Duration(seconds: 30),
                    builder: (context, seconds) {
                      if (seconds == 0) {
                        return OutlinedButton(
                          onPressed: state.processing ? null : () => _onRepeat(context),
                          style: outlinedButtonStyles?.neutral,
                          child: Text(context.l10n.login_Button_otpSigninVerifyRepeat),
                        );
                      } else {
                        return OutlinedButton(
                          onPressed: null,
                          style: outlinedButtonStyles?.neutral,
                          child: Text(context.l10n.login_Button_otpSigninVerifyRepeatInterval(seconds)),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: kInset / 4),
                  ElevatedButton(
                    key: const Key(otpVerifyButtonKey),
                    onPressed:
                        state.processing || !state.otpSigninCodeInput.isValid ? null : () => _onSubmitted(context),
                    style: elevatedButtonStyles?.primary,
                    child: !state.processing
                        ? Text(context.l10n.login_Button_otpSigninVerifyProceed)
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
    context.read<LoginCubit>().loginOptSigninVerifyRepeat();
  }

  void _onSubmitted(BuildContext context) {
    context.read<LoginCubit>().loginOptSigninVerifySubmitted();
  }
}
