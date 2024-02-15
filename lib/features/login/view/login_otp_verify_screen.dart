import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../login.dart';

class LoginOtpVerifyScreen extends StatelessWidget {
  const LoginOtpVerifyScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    final OutlinedButtonStyles? outlinedButtonStyles = themeData.extension<OutlinedButtonStyles>();
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final isOtpNotificationEmail = state.sessionOtpProvisional?.notificationType?.isEmail ?? false;
        final otpFromEmail = state.sessionOtpProvisional?.fromEmail;
        return LoginScaffold(
          appBar: AppBar(
            leading: ExtBackButton(
              disabled: state.processing,
            ),
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          body: Column(
            children: [
              const OnboardingLogo(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(kInset, kInset / 2, kInset, kInset),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Linkify(
                        text: state.demo!
                            ? context.l10n.login_Text_otpVerifySentToEmail(state.emailInput.value)
                            : context.l10n.login_Text_otpVerifySentToEmailAssignedWithPhone(state.phoneInput.value),
                        style: themeData.textTheme.bodyMedium,
                        linkStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: kInset / 2),
                      TextFormField(
                        enabled: !state.processing,
                        initialValue: state.codeInput.value,
                        decoration: InputDecoration(
                          labelText: context.l10n.login_TextFieldLabelText_otpVerifyCode,
                          helperText: '', // reserve space for validator message
                          errorText: state.codeInput.displayError?.l10n(context),
                          errorMaxLines: 3,
                        ),
                        keyboardType: TextInputType.number,
                        autofillHints: const [
                          AutofillHints.oneTimeCode,
                          AutofillHints.password,
                        ],
                        onChanged: (value) => context.read<LoginCubit>().loginOptVerifyCodeInputChanged(value),
                        onFieldSubmitted: !state.codeInput.isValid ? null : (_) => _onOtpVerifySubmitted(context),
                      ),
                      const SizedBox(height: kInset / 8),
                      if (isOtpNotificationEmail)
                        Linkify(
                          text: otpFromEmail == null
                              ? context.l10n.login_Text_otpVerifyCheckSpamGeneral
                              : context.l10n.login_Text_otpVerifyCheckSpamFrom(otpFromEmail),
                          style: themeData.textTheme.bodyMedium,
                          linkStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const Spacer(),
                      const SizedBox(height: kInset),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CountDownBuilder(
                            key: ObjectKey(state.sessionOtpProvisional),
                            interval: const Duration(seconds: 30),
                            builder: (context, seconds) {
                              if (seconds == 0) {
                                return OutlinedButton(
                                  onPressed: state.processing ? null : () => _onOtpVerifyRepeat(context),
                                  style: outlinedButtonStyles?.neutral,
                                  child: Text(context.l10n.login_Button_otpVerifyRepeat),
                                );
                              } else {
                                return OutlinedButton(
                                  onPressed: null,
                                  style: outlinedButtonStyles?.neutral,
                                  child: Text(context.l10n.login_Button_otpVerifyRepeatInterval(seconds)),
                                );
                              }
                            },
                          ),
                          const SizedBox(height: kInset / 4),
                          ElevatedButton(
                            onPressed: state.processing || !state.codeInput.isValid
                                ? null
                                : () => _onOtpVerifySubmitted(context),
                            style: elevatedButtonStyles?.primary,
                            child: !state.processing
                                ? Text(context.l10n.login_Button_otpVerifyProceed)
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onOtpVerifyRepeat(BuildContext context) {
    context.read<LoginCubit>().loginOptVerifyRepeat();
  }

  void _onOtpVerifySubmitted(BuildContext context) {
    context.read<LoginCubit>().loginOptVerifySubmitted();
  }
}
