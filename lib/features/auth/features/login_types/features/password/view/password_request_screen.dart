import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/auth/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../cubit/password_request_cubit.dart';

class PasswordRequestScreen extends StatefulWidget {
  const PasswordRequestScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PasswordRequestScreen> createState() => _LoginRequestTabState();
}

class _LoginRequestTabState extends State<PasswordRequestScreen> {
  bool _obscured = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    return BlocConsumer<PasswordRequestCubit, PasswordRequestState>(
      listener: (context, state) {
        if (state.status == PasswordRequestStatus.ok) {
          context.read<AppBloc>().add(AppLogined(
                coreUrl: state.coreUrl,
                tenantId: state.tenantId,
                token: state.token!,
              ));
        }

        if (state.status == PasswordRequestStatus.error) {
          if (state.error != null) {
            final errorL10n = state.error!.errorL10n(context);
            context.showErrorSnackBar(errorL10n);
          }
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
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: context.l10n.login_TextFieldLabelText_passwordSignInRequestLogin,
                          helperText: '', // reserve space for validator message
                          errorMaxLines: 3,
                        ),
                        onChanged: (value) =>
                            context.read<PasswordRequestCubit>().loginCredentialRequestLoginInputChanged(value),
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
                            context.read<PasswordRequestCubit>().loginCredentialRequestPasswordInputChanged(value),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(height: kInset),
                  ElevatedButton(
                    onPressed: state.isInputValid ? () => _onPasswordRequestSubmitted(context) : null,
                    style: elevatedButtonStyles?.primary,
                    child: !state.isProcessing
                        ? Text(context.l10n.login_Button_otpRequestProceed)
                        : SizedCircularProgressIndicator(
                            size: 16,
                            strokeWidth: 2,
                            color: elevatedButtonStyles?.primary?.foregroundColor?.resolve({}),
                          ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _onPasswordRequestSubmitted(BuildContext context) {
    primaryFocus?.unfocus();

    context.read<PasswordRequestCubit>().loginPasswordRequestSubmitted();
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }
}
