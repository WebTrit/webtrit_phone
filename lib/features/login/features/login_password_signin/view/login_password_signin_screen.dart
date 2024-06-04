import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class LoginPasswordSigninScreen extends StatelessWidget {
  const LoginPasswordSigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final passwordSigninPreDescriptionText = context.l10n.login_Text_passwordSigninPreDescription;
        final passwordSigninPostDescriptionText = context.l10n.login_Text_passwordSigninPostDescription;

        return Padding(
          padding: const EdgeInsets.fromLTRB(kInset, kInset / 2, kInset, kInset),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (passwordSigninPreDescriptionText.isNotEmpty) ...[
                Description(
                  text: passwordSigninPreDescriptionText,
                ),
                const SizedBox(height: kInset / 2),
              ],
              TextFormField(
                enabled: !state.processing,
                initialValue: state.passwordSigninUserRefInput.value,
                decoration: InputDecoration(
                  labelText: context.l10n.login_TextFieldLabelText_passwordSigninUserRef,
                  helperText: '', // reserve space for validator message
                  errorText: state.passwordSigninUserRefInput.displayError?.l10n(context),
                  errorMaxLines: 3,
                ),
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [
                  AutofillHints.email,
                  AutofillHints.telephoneNumber,
                ],
                onChanged: context.read<LoginCubit>().passwordSigninUserRefInputChanged,
                onFieldSubmitted: !state.passwordSigninUserRefInput.isValid ? null : (_) => _onSubmitted(context),
              ),
              TextFormField(
                enabled: !state.processing,
                initialValue: state.passwordSigninPasswordInput.value,
                decoration: InputDecoration(
                  labelText: context.l10n.login_TextFieldLabelText_passwordSigninPassword,
                  helperText: '', // reserve space for validator message
                  errorText: state.passwordSigninPasswordInput.displayError?.l10n(context),
                  errorMaxLines: 3,
                  suffixIcon: IconButton(
                    icon: Icon(
                      state.passwordSigninPasswordInputObscureText ? Icons.visibility : Icons.visibility_off,
                      size: 24,
                    ),
                    onPressed: state.processing
                        ? null
                        : context.read<LoginCubit>().passwordSigninPasswordInputObscureTextToggled,
                  ),
                ),
                obscureText: state.passwordSigninPasswordInputObscureText,
                onChanged: context.read<LoginCubit>().passwordSigninPasswordInputChanged,
                onFieldSubmitted: !state.passwordSigninPasswordInput.isValid ? null : (_) => _onSubmitted(context),
              ),
              if (passwordSigninPostDescriptionText.isNotEmpty) ...[
                const SizedBox(height: kInset / 8),
                Description(
                  text: passwordSigninPostDescriptionText,
                ),
              ],
              const Spacer(),
              const SizedBox(height: kInset),
              ElevatedButton(
                onPressed: state.processing ||
                        !state.passwordSigninUserRefInput.isValid ||
                        !state.passwordSigninPasswordInput.isValid
                    ? null
                    : () => _onSubmitted(context),
                style: elevatedButtonStyles?.primary,
                child: !state.processing
                    ? Text(context.l10n.login_Button_passwordSigninProceed)
                    : SizedCircularProgressIndicator(
                        size: 16,
                        strokeWidth: 2,
                        color: elevatedButtonStyles?.primary?.foregroundColor?.resolve({}),
                      ),
              )
            ],
          ),
        );
      },
    );
  }

  void _onSubmitted(BuildContext context) {
    context.read<LoginCubit>().loginPasswordSigninSubmitted();
  }
}
