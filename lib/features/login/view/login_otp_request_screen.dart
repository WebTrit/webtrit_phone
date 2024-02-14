import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../login.dart';

class LoginOtpRequestScreen extends StatelessWidget {
  const LoginOtpRequestScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return LoginScaffold(
          appBar: AppBar(
            title: Text(context.l10n.login_AppBarTitle_otpRequest),
            leading: ExtBackButton(
              disabled: state.processing,
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
                      if (state.demo!)
                        TextFormField(
                          enabled: !state.processing,
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
                          enabled: !state.processing,
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
                        text: state.demo!
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
                        onPressed:
                            state.processing || !(state.demo! ? state.emailInput.isValid : state.phoneInput.isValid)
                                ? null
                                : () => _onOtpRequestSubmitted(context),
                        style: elevatedButtonStyles?.primary,
                        child: !state.processing
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
        );
      },
    );
  }

  void _onOtpRequestSubmitted(BuildContext context) {
    context.read<LoginCubit>().loginOptRequestSubmitted();
  }
}
