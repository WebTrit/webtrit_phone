import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/styles/styles.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../login.dart';

class LoginCoreUrlAssignTab extends StatelessWidget {
  const LoginCoreUrlAssignTab({
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
        } else if (state.status == LoginStatus.back) {
          context.hideCurrentSnackBar();
          context.read<LoginCubit>().back();
        } else {
          if (state.error != LoginState.noError) {
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
                  previous.status != current.status || previous.coreUrlInput != current.coreUrlInput,
              builder: (context, state) {
                return TextFormField(
                  enabled: !state.status.isProcessing,
                  initialValue: state.coreUrlInput.value,
                  decoration: InputDecoration(
                    labelText: context.l10n.login_TextFieldLabelText_coreUrl,
                    helperText: '', // reserve space for validator message
                    errorText: _coreUrlTextFieldErrorText(context, state.coreUrlInput),
                    errorMaxLines: 3,
                  ),
                  keyboardType: TextInputType.url,
                  onChanged: (value) => context.read<LoginCubit>().loginCoreUrlAssignCoreUrlInputChanged(value),
                  onFieldSubmitted: !state.coreUrlInput.valid ? null : (_) => _onCoreUrlAssignSubmitted(context),
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
                            state.status.isProcessing ? null : () => _onCoreUrlAssignBack(context),
                        style: AppOutlinedButtonStyle.mainThick,
                        child: Text(context.l10n.login_Button_back),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: BlocBuilder<LoginCubit, LoginState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status || previous.coreUrlInput != current.coreUrlInput,
                    builder: (context, state) {
                      return TextButton(
                        onPressed: !state.coreUrlInput.valid ? null : () => _onCoreUrlAssignSubmitted(context),
                        style: AppTextButtonStyle.primaryThick,
                        child: !state.status.isProcessing
                            ? Text(context.l10n.login_Button_coreUrlAssign)
                            : const SizedCircularProgressIndicator(
                                size: 16,
                                strokeWidth: 2,
                                color: AppColors.white,
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: kToolbarHeight / 2),
          ],
        ),
      ),
    );
  }

  void _onCoreUrlAssignSubmitted(BuildContext context) {
    // necessary for correctly calling dispose (https://github.com/flutter/flutter/issues/55571)
    primaryFocus?.unfocus();

    context.read<LoginCubit>().loginCoreUrlAssignSubmitted();
  }

  void _onCoreUrlAssignBack(BuildContext context) {
    primaryFocus?.unfocus();

    context.read<LoginCubit>().loginCoreUrlAssignBack();
  }

  String? _coreUrlTextFieldErrorText(BuildContext context, UrlInput coreUrlInput) {
    if (!coreUrlInput.invalid) {
      return null;
    } else {
      switch (coreUrlInput.error!) {
        case UrlValidationError.blank:
          return context.l10n.validationBlankError;
      }
    }
  }
}
