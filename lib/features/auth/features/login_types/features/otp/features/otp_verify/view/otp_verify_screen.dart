import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/auth/auth.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../widgets/count_down_builder.dart';

class OtpVerifyScreen extends StatelessWidget {
  const OtpVerifyScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    final OutlinedButtonStyles? outlinedButtonStyles = themeData.extension<OutlinedButtonStyles>();
    return BlocConsumer<OtpVerifyCubit, OtpVerifyState>(
      listenWhen: (previous, current) => previous.status != current.status || previous.error != current.error,
      listener: (context, state) {
        if (state.status == OtpVerifyStatus.ok) {
          context.hideCurrentSnackBar();
          context.read<AppBloc>().add(AppLogined(
                coreUrl: state.coreUrl!,
                tenantId: state.tenantId!,
                token: state.token!,
              ));
        }

        if (state.status == OtpVerifyStatus.error) {
          if (state.error != null) {
            final errorL10n = state.error!.errorL10n(context);
            context.showErrorSnackBar(errorL10n);
          }
        }
      },
      builder: (context, state) {
        final isOtpNotificationEmail = state.sessionOtpProvisional?.notificationType?.isEmail ?? false;
        final otpFromEmail = state.sessionOtpProvisional?.fromEmail;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Linkify(
              text: state.email.isNotEmpty
                  ? context.l10n.login_Text_otpVerifySentToEmail(state.email)
                  : context.l10n.login_Text_otpVerifySentToEmailAssignedWithPhone(state.phone),
              style: themeData.textTheme.bodyMedium,
              linkStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: kInset / 2),
            TextFormField(
              initialValue: state.codeInput.value,
              decoration: InputDecoration(
                labelText: context.l10n.login_TextFieldLabelText_otpVerifyCode,
                helperText: '', // reserve space for validator message
                errorText: state.codeInput.displayError?.toString(),
                errorMaxLines: 3,
              ),
              keyboardType: TextInputType.number,
              autofillHints: const [
                AutofillHints.oneTimeCode,
                AutofillHints.password,
              ],
              onChanged: (value) => context.read<OtpVerifyCubit>().loginOptVerifyCodeInputChanged(value),
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
                        onPressed: () => _onOtpVerifyRepeat(context),
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
                  onPressed: !state.codeInput.isValid ? null : () => _onOtpVerifySubmitted(context),
                  style: elevatedButtonStyles?.primary,
                  child: !state.isProcessing
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
        );
      },
    );
  }

  void _onOtpVerifyRepeat(BuildContext context) {
    context.read<OtpVerifyCubit>().loginOptVerifyRepeat();
  }

  void _onOtpVerifySubmitted(BuildContext context) {
    // necessary for correctly calling dispose (https://github.com/flutter/flutter/issues/55571)
    primaryFocus?.unfocus();

    context.read<OtpVerifyCubit>().loginOptVerifySubmitted();
  }
}
