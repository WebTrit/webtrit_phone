import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../login.dart';

class LoginRequestTab extends StatefulWidget {
  const LoginRequestTab({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginRequestTab> createState() => _LoginRequestTabState();
}

class _LoginRequestTabState extends State<LoginRequestTab> {
  SupportedLogin _currentTypeLogin = SupportedLogin.otpSignIn;

  bool _obscured = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.ok) {
          // TODO: Duplicate logic and not a good place for navigation resolution logic
          if (_currentTypeLogin == SupportedLogin.otpSignIn) {
            context.hideCurrentSnackBar();
            context.read<LoginCubit>().next();
          } else {
            context.hideCurrentSnackBar();
            context.read<AppBloc>().add(AppLogined(
                  coreUrl: state.coreUrl!,
                  tenantId: state.tenantId!,
                  token: state.token!,
                ));
          }
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
        return WillPopScope(
          onWillPop: () async {
            _onOtpRequestBack(context);
            return false;
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
                        if (state.supportedLogin.length > 1)
                          SegmentedButton<SupportedLogin>(
                            segments: state.supportedLogin
                                .map((type) => ButtonSegment<SupportedLogin>(
                                      value: type,
                                      label: Text(type.l10n(context)),
                                    ))
                                .toList(),
                            showSelectedIcon: false,
                            selected: <SupportedLogin>{_currentTypeLogin},
                            onSelectionChanged: (Set<SupportedLogin> newSelection) {
                              setState(() {
                                _currentTypeLogin = newSelection.first;
                              });
                            },
                          ),
                        switch (_currentTypeLogin) {
                          SupportedLogin.otpSignIn => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: kInset),
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
                                    onChanged: (value) =>
                                        context.read<LoginCubit>().loginOptRequestEmailInputChanged(value),
                                    onFieldSubmitted:
                                        !state.emailInput.isValid ? null : (_) => _onOtpRequestSubmitted(context),
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
                                    onChanged: (value) =>
                                        context.read<LoginCubit>().loginOptRequestPhoneInputChanged(value),
                                    onFieldSubmitted:
                                        !state.phoneInput.isValid ? null : (_) => _onOtpRequestSubmitted(context),
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
                              ],
                            ),
                          SupportedLogin.passwordSignIn => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: kInset),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: context.l10n.login_TextFieldLabelText_passwordSignInRequestLogin,
                                    helperText: '', // reserve space for validator message
                                    errorMaxLines: 3,
                                  ),
                                  onChanged: (value) =>
                                      context.read<LoginCubit>().loginCredentialRequestLoginInputChanged(value),
                                ),
                                const SizedBox(height: kInset / 8),
                                TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: _obscured,
                                  decoration: InputDecoration(
                                    labelText: context.l10n.login_TextFieldLabelText_passwordSignInRequestPassword,
                                    // reserve space for validator message
                                    errorMaxLines: 3,
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                      child: GestureDetector(
                                        onTap: _toggleObscured,
                                        child: Icon(
                                          _obscured ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) =>
                                      context.read<LoginCubit>().loginCredentialRequestPasswordInputChanged(value),
                                ),
                              ],
                            ),
                        },
                        const Spacer(),
                        const SizedBox(height: kInset),
                        switch (_currentTypeLogin) {
                          SupportedLogin.otpSignIn => ElevatedButton(
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
                            ),
                          SupportedLogin.passwordSignIn => ElevatedButton(
                              onPressed:
                                  !state.status.isInput || !(state.loginInput.isValid && state.passwordInput.isValid)
                                      ? null
                                      : () => _onPasswordRequestSubmitted(context),
                              style: elevatedButtonStyles?.primary,
                              child: state.status.isInput
                                  ? Text(context.l10n.login_Button_otpRequestProceed)
                                  : SizedCircularProgressIndicator(
                                      size: 16,
                                      strokeWidth: 2,
                                      color: elevatedButtonStyles?.primary?.foregroundColor?.resolve({}),
                                    ),
                            ),
                        }
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

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  void _onOtpRequestSubmitted(BuildContext context) {
    // necessary for correctly calling dispose (https://github.com/flutter/flutter/issues/55571)
    primaryFocus?.unfocus();

    context.read<LoginCubit>().loginOptRequestSubmitted();
  }

  void _onPasswordRequestSubmitted(BuildContext context) {
    primaryFocus?.unfocus();

    context.read<LoginCubit>().loginPasswordRequestSubmitted();
  }

  void _onOtpRequestBack(BuildContext context) {
    primaryFocus?.unfocus();

    context.read<LoginCubit>().loginOptRequestBack();
  }
}
