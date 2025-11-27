import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class LoginPasswordSigninScreen extends StatefulWidget {
  const LoginPasswordSigninScreen({super.key});

  @override
  State<LoginPasswordSigninScreen> createState() => _LoginPasswordSigninScreenState();
}

class _LoginPasswordSigninScreenState extends State<LoginPasswordSigninScreen> {
  final _maskFormatter = MaskTextInputFormatter(type: MaskAutoCompletionType.lazy);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final themeData = Theme.of(context);
    final loginStyles = themeData.extension<LoginPasswordSigninPageStyles>()?.primary;

    _maskFormatter.updateFromConfig(loginStyles?.refInput?.mask);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    final loginStyles = themeData.extension<LoginPasswordSigninPageStyles>()?.primary;

    final userRefStyle = loginStyles?.refInput;
    final passwordStyle = loginStyles?.passwordInput;

    final maskConfig = userRefStyle?.mask;

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final passwordSigninPreDescriptionText = context.l10n.login_Text_passwordSigninPreDescription;
        final passwordSigninPostDescriptionText = context.l10n.login_Text_passwordSigninPostDescription;

        final userRefDecoration = userRefStyle?.decoration ?? const InputDecoration();
        final passwordDecoration = passwordStyle?.decoration ?? const InputDecoration();

        final decorationLabelText = context.parseL10n(
          userRefDecoration.labelText,
          fallback: context.l10n.login_TextFieldLabelText_passwordSigninUserRef,
        );

        return Padding(
          padding: const EdgeInsets.fromLTRB(kInset, kInset / 2, kInset, kInset),
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (passwordSigninPreDescriptionText.isNotEmpty) ...[
                  Description(text: passwordSigninPreDescriptionText),
                  const SizedBox(height: kInset / 2),
                ],
                TextFormField(
                  key: passwordUserInputKey,
                  enabled: !state.processing,
                  initialValue: state.passwordSigninUserRefInput.value,
                  decoration: userRefDecoration.copyWith(
                    labelText: decorationLabelText,
                    helperText: '',
                    // reserve space for validator message
                    errorText: state.passwordSigninUserRefInput.displayError?.l10n(context),
                    errorMaxLines: 3,
                    hintText: userRefDecoration.hintText ?? maskConfig?.pattern,
                  ),
                  inputFormatters: maskConfig != null ? [_maskFormatter] : [],
                  style: userRefStyle?.textStyle,
                  textAlign: userRefStyle?.textAlign ?? TextAlign.start,
                  keyboardType: userRefStyle?.keyboardType ?? TextInputType.text,
                  autofillHints: const [AutofillHints.email, AutofillHints.telephoneNumber],
                  onChanged: context.read<LoginCubit>().passwordSigninUserRefInputChanged,
                  onFieldSubmitted: !state.passwordSigninUserRefInput.isValid ? null : (_) => _onSubmitted(context),
                ),
                TextFormField(
                  key: passwordPasswordInputKey,
                  enabled: !state.processing,
                  initialValue: state.passwordSigninPasswordInput.value,
                  decoration: passwordDecoration.copyWith(
                    labelText: context.l10n.login_TextFieldLabelText_passwordSigninPassword,
                    helperText: '',
                    // reserve space for validator message
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
                  style: passwordStyle?.textStyle,
                  textAlign: passwordStyle?.textAlign ?? TextAlign.start,
                  obscureText: state.passwordSigninPasswordInputObscureText,
                  keyboardType: passwordStyle?.keyboardType ?? TextInputType.visiblePassword,
                  autofillHints: const [AutofillHints.password],
                  onChanged: context.read<LoginCubit>().passwordSigninPasswordInputChanged,
                  onFieldSubmitted: !state.passwordSigninPasswordInput.isValid ? null : (_) => _onSubmitted(context),
                ),
                if (passwordSigninPostDescriptionText.isNotEmpty) ...[
                  const SizedBox(height: kInset / 8),
                  Description(text: passwordSigninPostDescriptionText),
                ],
                const Spacer(),
                const SizedBox(height: kInset),
                ElevatedButton(
                  key: passwordButtonKey,
                  onPressed:
                      state.processing ||
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSubmitted(BuildContext context) {
    context.read<LoginCubit>().loginPasswordSigninSubmitted();
  }
}
