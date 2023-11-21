import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../login.dart';

class LoginOtpRequestTab extends StatelessWidget {
  const LoginOtpRequestTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.ok) {
          context.hideCurrentSnackBar();
          context.read<LoginCubit>().next();
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
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            _onOtpRequestBack(context);
          },
          child: LoginScaffold(
            appBar: AppBar(
              title: Text(context.l10n.login_AppBarTitle_otpRequest),
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
                        if (state.demo)
                          TextFormField(
                            enabled: state.status.isInput,
                            initialValue: state.emailInput.value,
                            decoration: InputDecoration(
                              labelText: context.l10n.login_TextFieldLabelText_otpRequestEmail,
                              helperText: '', // reserve space for validator message
                              errorText: state.emailInput.displayError?.l10n(context),
                              errorMaxLines: 3,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [
                              AutofillHints.email,
                            ],
                            onChanged: (value) => context.read<LoginCubit>().loginOptRequestEmailInputChanged(value),
                            onFieldSubmitted: !state.emailInput.isValid ? null : (_) => _onOtpRequestSubmitted(context),
                          )
                        else
                          TextFormField(
                            enabled: state.status.isInput,
                            initialValue: state.phoneInput.value,
                            decoration: InputDecoration(
                              labelText: context.l10n.login_TextFieldLabelText_otpRequestPhone,
                              helperText: '', // reserve space for validator message
                              errorText: state.phoneInput.displayError?.l10n(context),
                              errorMaxLines: 3,
                            ),
                            keyboardType: PlatformInfo().isIOS
                                ? const TextInputType.numberWithOptions(
                                    signed: true,
                                  ) // show regular text keyboard (without emoji) but in number mode by default
                                : TextInputType.text,
                            autocorrect: false,
                            enableSuggestions: false,
                            onChanged: (value) => context.read<LoginCubit>().loginOptRequestPhoneInputChanged(value),
                            onFieldSubmitted: !state.phoneInput.isValid ? null : (_) => _onOtpRequestSubmitted(context),
                          ),
                        const SizedBox(height: kInset / 8),
                        Linkify(
                          text: state.demo
                              ? context.l10n.login_Text_otpRequestDemoDescription
                              : context.l10n.login_Text_otpRequestDescription,
                          style: themeData.textTheme.bodyMedium,
                          linkStyle: TextStyle(
                            color: themeData.colorScheme.primary,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(height: kInset),
                        ElevatedButton(
                          onPressed: !state.status.isInput ||
                                  !(state.demo ? state.emailInput.isValid : state.phoneInput.isValid)
                              ? null
                              : () => _onOtpRequestSubmitted(context),
                          style: elevatedButtonStyles?.primary,
                          child: state.status.isInput
                              ? Text(context.l10n.login_Button_otpRequestProceed)
                              : SizedCircularProgressIndicator(
                                  size: 16,
                                  strokeWidth: 2,
                                  color: elevatedButtonStyles?.primary?.foregroundColor?.resolve({}),
                                ),
                        )
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

  void _onOtpRequestSubmitted(BuildContext context) {
    // necessary for correctly calling dispose (https://github.com/flutter/flutter/issues/55571)
    primaryFocus?.unfocus();

    context.read<LoginCubit>().loginOptRequestSubmitted();
  }

  void _onOtpRequestBack(BuildContext context) {
    primaryFocus?.unfocus();

    context.read<LoginCubit>().loginOptRequestBack();
  }
}
