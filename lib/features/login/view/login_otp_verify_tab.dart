import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../login.dart';

class LoginOtpVerifyTab extends StatelessWidget {
  const LoginOtpVerifyTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    final OutlinedButtonStyles? outlinedButtonStyles = themeData.extension<OutlinedButtonStyles>();
    return BlocConsumer<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status || previous.error != current.error,
      listener: (context, state) {
        if (state.status == LoginStatus.ok) {
          context.hideCurrentSnackBar();
          context.read<AppBloc>().add(AppLogined(
                coreUrl: state.coreUrl!,
                token: state.token!,
              ));
        } else if (state.status == LoginStatus.back) {
          context.hideCurrentSnackBar();
          context.read<LoginCubit>().back();
        } else {
          final errorL10n = state.errorL10n(context);
          if (errorL10n != null) {
            context.showErrorSnackBar(errorL10n);
            context.read<LoginCubit>().dismissError();
          }
        }
      },
      builder: (context, state) {
        final isOtpNotificationEmail = state.otpNotificationType?.isEmail ?? false;
        final otpFromEmail = state.otpFromEmail;
        return WillPopScope(
          onWillPop: () async {
            _onOtpVerifyBack(context);
            return false;
          },
          child: LoginScaffold(
            appBar: AppBar(
              title: Text(context.l10n.login_AppBarTitle_otpVerify),
              leading: ExtBackButton(
                disabled: !state.status.isInput,
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
                          text: state.demo
                              ? context.l10n.login_Text_otpVerifySentToEmail(state.emailInput.value)
                              : context.l10n.login_Text_otpVerifySentToEmailAssignedWithPhone(state.phoneInput.value),
                          style: themeData.textTheme.bodyMedium,
                          linkStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: kInset / 2),
                        TextFormField(
                          enabled: state.status.isInput,
                          initialValue: state.codeInput.value,
                          decoration: InputDecoration(
                            labelText: context.l10n.login_TextFieldLabelText_otpVerifyCode,
                            helperText: '', // reserve space for validator message
                            errorText: state.codeInput.errorL10n(context),
                            errorMaxLines: 3,
                          ),
                          keyboardType: TextInputType.number,
                          autofillHints: const [
                            AutofillHints.oneTimeCode,
                            AutofillHints.password,
                          ],
                          onChanged: (value) => context.read<LoginCubit>().loginOptVerifyCodeInputChanged(value),
                          onFieldSubmitted: !state.codeInput.valid ? null : (_) => _onOtpVerifySubmitted(context),
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
                              key: ObjectKey(state.otpId),
                              interval: const Duration(seconds: 30),
                              builder: (context, seconds) {
                                if (seconds == 0) {
                                  return OutlinedButton(
                                    onPressed: !state.status.isInput ? null : () => _onOtpVerifyRepeat(context),
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
                              onPressed: !state.status.isInput || !state.codeInput.valid
                                  ? null
                                  : () => _onOtpVerifySubmitted(context),
                              style: elevatedButtonStyles?.primary,
                              child: state.status.isInput
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
          ),
        );
      },
    );
  }

  void _onOtpVerifyRepeat(BuildContext context) {
    context.read<LoginCubit>().loginOptVerifyRepeat();
  }

  void _onOtpVerifySubmitted(BuildContext context) {
    // necessary for correctly calling dispose (https://github.com/flutter/flutter/issues/55571)
    primaryFocus?.unfocus();

    context.read<LoginCubit>().loginOptVerifySubmitted();
  }

  void _onOtpVerifyBack(BuildContext context) {
    primaryFocus?.unfocus();

    context.read<LoginCubit>().loginOptVerifyBack();
  }
}
