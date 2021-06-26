import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../login.dart';

class LoginOtpRequestTab extends StatelessWidget {
  const LoginOtpRequestTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status || previous.error != current.error,
      listener: (context, state) {
        if (state.status == LoginStatus.ok) {
          context.hideCurrentSnackBar();
          context.read<LoginCubit>().next();
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
            WebTritPhonePictureLogo(),
            const SizedBox(height: kToolbarHeight),
            BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status || previous.phoneInput != current.phoneInput,
              builder: (context, state) {
                return TextFormField(
                  enabled: !state.status.isProcessing,
                  initialValue: state.phoneInput.value,
                  decoration: InputDecoration(
                    labelText: context.l10n.loginOtpRequestTabPhoneTextFieldLabel,
                    helperText: '', // reserve space for validator message
                    errorText: _phoneTextFieldErrorText(context, state.phoneInput),
                    errorMaxLines: 3,
                  ),
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => context.read<LoginCubit>().loginOptRequestPhoneInputChanged(value),
                  onFieldSubmitted: !state.phoneInput.valid ? null : (_) => _onOtpRequest(context),
                );
              },
            ),
            BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status || previous.phoneInput != current.phoneInput,
              builder: (context, state) {
                return OutlinedButton(
                  onPressed: !state.phoneInput.valid ? null : () => _onOtpRequest(context),
                  child: !state.status.isProcessing
                      ? Text(context.l10n.loginOtpRequestTabProceedButtonLabel)
                      : SizedCircularProgressIndicator(
                          size: 16,
                          strokeWidth: 2,
                        ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _onOtpRequest(BuildContext context) {
    // necessary for correctly calling dispose (https://github.com/flutter/flutter/issues/55571)
    primaryFocus?.unfocus();

    context.read<LoginCubit>().loginOptRequestSubmitted();
  }

  String? _phoneTextFieldErrorText(BuildContext context, PhoneInput phoneInput) {
    if (!phoneInput.invalid) {
      return null;
    } else {
      switch (phoneInput.error!) {
        case PhoneValidationError.blank:
          return context.l10n.validationBlankError;
      }
    }
  }
}
