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
  /// Formatter used to apply an optional mask to the reference input field.
  /// The lazy `MaskAutoCompletionType` delays auto-completion until the user
  /// has finished typing, avoiding premature insertion of mask characters.
  final _maskFormatter = MaskTextInputFormatter(type: MaskAutoCompletionType.lazy);

  /// Whether the initial value from the style's input config has been applied to
  /// the cubit. This ensures the initial value is only forwarded once during
  /// the widget lifecycle (see `didChangeDependencies`).
  bool _hasAppliedRefInitialValue = false;

  LoginOtpSigninPageStyle? get _styles => Theme.of(context).extension<LoginOtpSigninPageStyles>()?.primary;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update the mask (always runs on dependency change)
    _maskFormatter.updateFromConfig(_styles?.refInput?.mask);

    // Apply initial value (runs only once)
    if (!_hasAppliedRefInitialValue) {
      _applyInitialValue(_styles?.refInput?.inputValue);
      _hasAppliedRefInitialValue = true;
    }
  }

  /// Reads the initial reference value from the style configuration and
  /// synchronizes it with the `LoginCubit` state.
  void _applyInitialValue(InputValue? inputValue) {
    final initialValue = inputValue?.initialValue;
    if (initialValue == null) return;

    final cubit = context.read<LoginCubit>();
    final currentValue = cubit.state.otpSigninUserRefInput.value;

    if (currentValue.isEmpty) {
      cubit.otpSigninUserRefInputChanged(initialValue);
    }
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

        final identifiers = state.otpSigninIdentifiers;
        final hasPhone = identifiers.contains(OtpSigninIdentifier.phoneNumber);
        final hasEmail = identifiers.contains(OtpSigninIdentifier.email);

        final decorationLabelText = context.parseL10n(
          refDecoration.labelText,
          fallback: _userRefLabel(context, hasPhone: hasPhone, hasEmail: hasEmail),
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
                includePrefixInData: refStyle?.inputValue?.includePrefixInData ?? false,
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
                keyboardType: refStyle?.keyboardType ?? _userRefKeyboardType(hasPhone: hasPhone, hasEmail: hasEmail),
                autofillHints: _userRefAutofillHints(hasPhone: hasPhone, hasEmail: hasEmail),
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

  /// Picks the input label that matches the OTP login identifiers advertised by
  /// the backend, so the hint only mentions inputs the backend actually accepts.
  String _userRefLabel(BuildContext context, {required bool hasPhone, required bool hasEmail}) {
    final l10n = context.l10n;
    if (hasPhone && !hasEmail) return l10n.login_TextFieldLabelText_otpSigninUserRefPhone;
    if (hasEmail && !hasPhone) return l10n.login_TextFieldLabelText_otpSigninUserRefEmail;
    return l10n.login_TextFieldLabelText_otpSigninUserRef;
  }

  TextInputType _userRefKeyboardType({required bool hasPhone, required bool hasEmail}) {
    if (hasPhone && !hasEmail) return TextInputType.phone;
    return TextInputType.emailAddress;
  }

  List<String> _userRefAutofillHints({required bool hasPhone, required bool hasEmail}) {
    if (hasPhone && !hasEmail) return const [AutofillHints.telephoneNumber];
    if (hasEmail && !hasPhone) return const [AutofillHints.email];
    return const [AutofillHints.email, AutofillHints.telephoneNumber];
  }
}
