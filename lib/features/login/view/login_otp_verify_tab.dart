import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == LoginStatus.ok) {
          context.hideCurrentSnackBar();
          context.read<AppBloc>().add(AppLogined(token: state.token!));
        } else if (state.status == LoginStatus.back) {
          context.hideCurrentSnackBar();
          context.read<LoginCubit>().back();
        } else {
          if (state.error != null) {
            context.showErrorSnackBar(state.error.toString());
            context.read<LoginCubit>().dismissError();
          }
        }
      },
      child: Padding(
        padding: kTabLabelPadding * 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const OnboardingLogo(),
            BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status || previous.codeInput != current.codeInput,
              builder: (context, state) {
                return TextFormField(
                  enabled: !state.status.isProcessing,
                  initialValue: state.codeInput.value,
                  decoration: InputDecoration(
                    labelText: context.l10n.loginOtpRequestTabCodeTextFieldLabel,
                    helperText: '', // reserve space for validator message
                    errorText: _codeTextFieldErrorText(context, state.codeInput),
                    errorMaxLines: 3,
                  ),
                  keyboardType: TextInputType.number,
                  autofillHints: state.status.isProcessing
                      ? null
                      : const [
                          AutofillHints.oneTimeCode,
                          AutofillHints.password,
                        ],
                  onChanged: (value) => context.read<LoginCubit>().loginOptVerifyCodeInputChanged(value),
                  onFieldSubmitted: !state.codeInput.valid ? null : (_) => _onOtpVerifySubmitted(context),
                );
              },
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<LoginCubit, LoginState>(
                    buildWhen: (previous, current) => previous.status != current.status,
                    builder: (context, state) {
                      return OutlinedButton(
                        onPressed:
                            state.status.isProcessing ? null : () => _onOtpVerifyBack(context),
                        style: outlinedButtonStyles?.neutral,
                        child: Text(context.l10n.login_Button_back),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: BlocBuilder<LoginCubit, LoginState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status || previous.codeInput != current.codeInput,
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: !state.codeInput.valid ? null : () => _onOtpVerifySubmitted(context),
                        style: elevatedButtonStyles?.primary,
                        child: !state.status.isProcessing
                            ? Text(context.l10n.loginOtpRequestTabVerifyButtonLabel)
                            : SizedCircularProgressIndicator(
                                size: 16,
                                strokeWidth: 2,
                                color: elevatedButtonStyles?.primary?.foregroundColor?.resolve({}),
                              ),
                      );
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: kToolbarHeight / 2),
          ],
        ),
      ),
    );
  }

  void _onOtpVerifySubmitted(BuildContext context) {
    // necessary for correctly calling dispose (https://github.com/flutter/flutter/issues/55571)
    primaryFocus?.unfocus();

    context.read<LoginCubit>().loginOptVerifySubmitted();
  }

  void _onOtpVerifyBack(BuildContext context) {
    primaryFocus?.unfocus();

    context.read<LoginCubit>().loginCoreUrlAssignBack();
  }

  String? _codeTextFieldErrorText(BuildContext context, CodeInput codeInput) {
    if (!codeInput.invalid) {
      return null;
    } else {
      switch (codeInput.error!) {
        case CodeValidationError.blank:
          return context.l10n.validationBlankError;
      }
    }
  }
}
