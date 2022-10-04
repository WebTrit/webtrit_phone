import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../login.dart';
import 'constants.dart';

class LoginCoreUrlAssignTab extends StatelessWidget {
  const LoginCoreUrlAssignTab({
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
          _onCoreUrlAssignBack(context);
          return false;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (previous, current) => previous.status != current.status,
              builder: (context, state) {
                return AppBar(
                  title: Text(context.l10n.login_AppBarTitle_coreUrlAssign),
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
                    previous.status != current.status || previous.coreUrlInput != current.coreUrlInput,
                builder: (context, state) {
                  return TextFormField(
                    enabled: !state.status.isProcessing,
                    initialValue: state.coreUrlInput.value,
                    decoration: InputDecoration(
                      labelText: context.l10n.login_TextFieldLabelText_coreUrlAssign,
                      helperText: '', // reserve space for validator message
                      errorText: state.coreUrlInput.errorL10n(context),
                      errorMaxLines: 3,
                    ),
                    keyboardType: TextInputType.url,
                    onChanged: (value) => context.read<LoginCubit>().loginCoreUrlAssignCoreUrlInputChanged(value),
                    onFieldSubmitted: !state.coreUrlInput.valid ? null : (_) => _onCoreUrlAssignSubmitted(context),
                  );
                },
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(kInset, 0, kInset, kInset),
              child: BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status || previous.coreUrlInput != current.coreUrlInput,
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: !state.coreUrlInput.valid ? null : () => _onCoreUrlAssignSubmitted(context),
                    style: elevatedButtonStyles?.primary,
                    child: !state.status.isProcessing
                        ? Text(context.l10n.login_Button_coreUrlAssignProceed)
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

  void _onCoreUrlAssignSubmitted(BuildContext context) {
    // necessary for correctly calling dispose (https://github.com/flutter/flutter/issues/55571)
    primaryFocus?.unfocus();

    context.read<LoginCubit>().loginCoreUrlAssignSubmitted();
  }

  void _onCoreUrlAssignBack(BuildContext context) {
    primaryFocus?.unfocus();

    context.read<LoginCubit>().loginCoreUrlAssignBack();
  }
}
