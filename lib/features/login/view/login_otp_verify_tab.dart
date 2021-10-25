import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../login.dart';

class LoginOtpVerifyTab extends StatelessWidget {
  const LoginOtpVerifyTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == LoginStatus.ok) {
          context.hideCurrentSnackBar();
          Navigator.pushReplacementNamed(context, '/main'); // TODO implement correct redirection way
        } else if (state.status == LoginStatus.back) {
          context.hideCurrentSnackBar();
          context.read<LoginCubit>().back();
        } else {
          if (state.error != LoginState.noError) {
            context.showErrorSnackBar(state.error.toString());
            context.read<LoginCubit>().dismisError();
          }
        }
      },
      child: Padding(
        padding: kTabLabelPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: kToolbarHeight),
            const WebTritPhonePictureLogo(),
            const SizedBox(height: kToolbarHeight),
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
                  onFieldSubmitted: !state.codeInput.valid ? null : (_) => _onOtpVerify(context),
                );
              },
            ),
            // const SizedBox(height: kToolbarHeight / 2),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<LoginCubit, LoginState>(
                    buildWhen: (previous, current) => previous.status != current.status,
                    builder: (context, state) {
                      return OutlinedButton(
                        onPressed:
                            state.status.isProcessing ? null : () => context.read<LoginCubit>().loginOptVerifyBack(),
                        child: Text(context.l10n.loginOtpRequestTabBackButtonLabel),
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
                      return OutlinedButton(
                        onPressed: !state.codeInput.valid ? null : () => _onOtpVerify(context),
                        child: !state.status.isProcessing
                            ? Text(context.l10n.loginOtpRequestTabVerifyButtonLabel)
                            : const SizedCircularProgressIndicator(
                                size: 16,
                                strokeWidth: 2,
                              ),
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onOtpVerify(BuildContext context) {
    // necessary for correctly calling dispose (https://github.com/flutter/flutter/issues/55571)
    primaryFocus?.unfocus();

    context.read<LoginCubit>().loginOptVerifySubmitted();
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
