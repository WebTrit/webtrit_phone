import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../cubit/otp_request_cubit.dart';
import '../extensions/extensions.dart';

class OtpRequestScreen extends StatefulWidget {
  const OtpRequestScreen({
    super.key,
  });

  @override
  State<OtpRequestScreen> createState() => _LoginRequestTabState();
}

class _LoginRequestTabState extends State<OtpRequestScreen> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    return BlocConsumer<OtpRequestCubit, OtpRequestState>(
      listener: (context, state) {
        if (state.status == OtpRequestStatus.ok) {
          context.goNamed(
            AppRoute.loginTypesOtpVerify,
            queryParameters: {'phone': state.phoneInput.value, 'email': state.emailInput.value},
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: kInset),
                      if (state.demo)
                        TextFormField(
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
                          onChanged: (value) => context.read<OtpRequestCubit>().loginOptRequestEmailInputChanged(value),
                          onFieldSubmitted: !state.emailInput.isValid ? null : (_) => _onOtpRequestSubmitted(context),
                        )
                      else
                        TextFormField(
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
                          onChanged: (value) => context.read<OtpRequestCubit>().loginOptRequestPhoneInputChanged(value),
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
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(height: kInset),
                  ElevatedButton(
                    onPressed: !(state.demo ? state.emailInput.isValid : state.phoneInput.isValid)
                        ? null
                        : () => _onOtpRequestSubmitted(context),
                    style: elevatedButtonStyles?.primary,
                    child: Text(context.l10n.login_Button_otpRequestProceed)
                        ,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _onOtpRequestSubmitted(BuildContext context) {
    // necessary for correctly calling dispose (https://github.com/flutter/flutter/issues/55571)
    primaryFocus?.unfocus();

    context.read<OtpRequestCubit>().loginOptRequestSubmitted();
  }
}
