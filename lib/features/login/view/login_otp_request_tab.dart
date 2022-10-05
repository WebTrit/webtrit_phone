import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../login.dart';
import 'constants.dart';

class LoginOtpRequestTab extends StatelessWidget {
  const LoginOtpRequestTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
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
          final errorL10n = state.errorL10n(context);
          if (errorL10n != null) {
            context.showErrorSnackBar(errorL10n);
            context.read<LoginCubit>().dismissError();
          }
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          _onOtpRequestBack(context);
          return false;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (previous, current) => previous.status != current.status,
              builder: (context, state) {
                return AppBar(
                  title: Text(context.l10n.login_AppBarTitle_otpRequest),
                  leading: ExtBackButton(
                    disabled: state.status.isProcessing,
                  ),
                  backgroundColor: Colors.transparent,
                );
              },
            ),
            const OnboardingLogo(),
            Padding(
              padding: const EdgeInsets.fromLTRB(kInset, kInset, kInset, 0),
              child: BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status ||
                    previous.demo != current.demo ||
                    previous.emailInput != current.emailInput ||
                    previous.phoneInput != current.phoneInput,
                builder: (context, state) {
                  if (state.demo) {
                    return TextFormField(
                      enabled: !state.status.isProcessing,
                      initialValue: state.emailInput.value,
                      decoration: InputDecoration(
                        labelText: context.l10n.login_TextFieldLabelText_otpRequestEmail,
                        helperText: '', // reserve space for validator message
                        errorText: state.emailInput.errorL10n(context),
                        errorMaxLines: 3,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => context.read<LoginCubit>().loginOptRequestEmailInputChanged(value),
                      onFieldSubmitted: !state.emailInput.valid ? null : (_) => _onOtpRequestSubmitted(context),
                    );
                  } else {
                    return TextFormField(
                      enabled: !state.status.isProcessing,
                      initialValue: state.phoneInput.value,
                      decoration: InputDecoration(
                        labelText: context.l10n.login_TextFieldLabelText_otpRequestPhone,
                        helperText: '', // reserve space for validator message
                        errorText: state.phoneInput.errorL10n(context),
                        errorMaxLines: 3,
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) => context.read<LoginCubit>().loginOptRequestPhoneInputChanged(value),
                      onFieldSubmitted: !state.phoneInput.valid ? null : (_) => _onOtpRequestSubmitted(context),
                    );
                  }
                },
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(kInset, 0, kInset, kInset),
              child: BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status ||
                    previous.demo != current.demo ||
                    previous.emailInput != current.emailInput ||
                    previous.phoneInput != current.phoneInput,
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: !(state.demo ? state.emailInput.valid : state.phoneInput.valid)
                        ? null
                        : () => _onOtpRequestSubmitted(context),
                    style: elevatedButtonStyles?.primary,
                    child: !state.status.isProcessing
                        ? Text(context.l10n.login_Button_otpRequestProceed)
                        : SizedCircularProgressIndicator(
                            size: 16,
                            strokeWidth: 2,
                            color: elevatedButtonStyles?.primary?.foregroundColor?.resolve({}),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
