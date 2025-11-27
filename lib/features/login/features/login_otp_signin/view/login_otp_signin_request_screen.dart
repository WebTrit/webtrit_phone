import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class LoginOtpSigninRequestScreen extends StatefulWidget {
  const LoginOtpSigninRequestScreen({super.key});

  @override
  State<LoginOtpSigninRequestScreen> createState() => _LoginOtpSigninRequestScreenState();
}

class _LoginOtpSigninRequestScreenState extends State<LoginOtpSigninRequestScreen> {
  final _maskFormatter = MaskTextInputFormatter(type: MaskAutoCompletionType.lazy);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final themeData = Theme.of(context);
    final otpStyles = themeData.extension<LoginOtpSigninPageStyles>()?.primary;

    _maskFormatter.updateFromConfig(otpStyles?.refInput?.mask);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    final otpStyles = themeData.extension<LoginOtpSigninPageStyles>()?.primary;

    final refStyle = otpStyles?.refInput;
    final maskConfig = refStyle?.mask;

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final otpSigninRequestPreDescriptionText = context.l10n.login_Text_otpSigninRequestPreDescription;
        final otpSigninRequestPostDescriptionText = context.l10n.login_Text_otpSigninRequestPostDescription;

        final refDecoration = refStyle?.decoration ?? const InputDecoration();

        final decorationLabelText = context.parseL10n(
          refDecoration.labelText,
          fallback: context.l10n.login_TextFieldLabelText_otpSigninUserRef,
        );

        return Container(
          padding: const EdgeInsets.fromLTRB(kInset, kInset / 2, kInset, kInset),
          color: themeData.scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (otpSigninRequestPreDescriptionText.isNotEmpty) ...[
                Description(text: otpSigninRequestPreDescriptionText),
                const SizedBox(height: kInset / 2),
              ],
              ExtendedTextFormField(
                key: optInputKey,
                includePrefixInData: refStyle?.behavior?.includePrefixInData ?? false,
                enabled: !state.processing,
                initialValue: state.otpSigninUserRefInput.value,
                decoration: refDecoration.copyWith(
                  labelText: decorationLabelText,
                  helperText: '',
                  // reserve space for validator message
                  errorText: state.otpSigninUserRefInput.displayError?.l10n(context),
                  errorMaxLines: 3,
                  hintText: refDecoration.hintText ?? maskConfig?.pattern,
                ),
                inputFormatters: maskConfig != null ? [_maskFormatter] : [],
                style: refStyle?.textStyle,
                textAlign: refStyle?.textAlign ?? TextAlign.start,
                keyboardType: refStyle?.keyboardType ?? TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email, AutofillHints.telephoneNumber],
                onChanged: context.read<LoginCubit>().otpSigninUserRefInputChanged,
                onFieldSubmitted: !state.otpSigninUserRefInput.isValid ? null : (_) => _onSubmitted(context),
              ),
              if (otpSigninRequestPostDescriptionText.isNotEmpty) ...[
                const SizedBox(height: kInset / 2),
                Description(text: otpSigninRequestPostDescriptionText),
              ],
              const Spacer(),
              const SizedBox(height: kInset),
              ElevatedButton(
                key: otpButtonKey,
                onPressed: state.processing || !state.otpSigninUserRefInput.isValid
                    ? null
                    : () => _onSubmitted(context),
                style: elevatedButtonStyles?.primary,
                child: !state.processing
                    ? Text(context.l10n.login_Button_otpSigninRequestProceed)
                    : SizedCircularProgressIndicator(
                        size: 16,
                        strokeWidth: 2,
                        color: elevatedButtonStyles?.primary?.foregroundColor?.resolve({}),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onSubmitted(BuildContext context) {
    context.read<LoginCubit>().loginOptSigninRequestSubmitted();
  }
}
