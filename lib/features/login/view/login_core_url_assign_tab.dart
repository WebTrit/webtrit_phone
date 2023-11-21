import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../login.dart';

class LoginCoreUrlAssignTab extends StatelessWidget {
  const LoginCoreUrlAssignTab({
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
            _onCoreUrlAssignBack(context);
          },
          child: LoginScaffold(
            appBar: AppBar(
              title: Text(context.l10n.login_AppBarTitle_coreUrlAssign),
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
                        Linkify(
                          text: context.l10n.login_Text_coreUrlAssignPreDescription,
                          onOpen: (link) => context.read<LoginCubit>().launchLinkableElement(link),
                          style: themeData.textTheme.bodyMedium,
                          linkStyle: TextStyle(
                            color: themeData.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: kInset / 2),
                        TextFormField(
                          enabled: state.status.isInput,
                          initialValue: state.coreUrlInput.value,
                          decoration: InputDecoration(
                            labelText: context.l10n.login_TextFieldLabelText_coreUrlAssign,
                            helperText: '', // reserve space for validator message
                            errorText: state.coreUrlInput.displayError?.l10n(context),
                            errorMaxLines: 3,
                          ),
                          keyboardType: TextInputType.url,
                          autocorrect: false,
                          onChanged: (value) => context.read<LoginCubit>().loginCoreUrlAssignCoreUrlInputChanged(value),
                          onFieldSubmitted:
                              !state.coreUrlInput.isValid ? null : (_) => _onCoreUrlAssignSubmitted(context),
                        ),
                        const SizedBox(height: kInset / 8),
                        Linkify(
                          text: context.l10n.login_Text_coreUrlAssignPostDescription(EnvironmentConfig.SALES_EMAIL),
                          onOpen: (link) => context.read<LoginCubit>().launchLinkableElement(link),
                          style: themeData.textTheme.bodyMedium,
                          linkStyle: TextStyle(
                            color: themeData.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(height: kInset),
                        ElevatedButton(
                          onPressed: !state.status.isInput || !state.coreUrlInput.isValid
                              ? null
                              : () => _onCoreUrlAssignSubmitted(context),
                          style: elevatedButtonStyles?.primary,
                          child: state.status.isInput
                              ? Text(context.l10n.login_Button_coreUrlAssignProceed)
                              : SizedCircularProgressIndicator(
                                  size: 16,
                                  strokeWidth: 2,
                                  color: elevatedButtonStyles?.primary?.foregroundColor?.resolve({}),
                                ),
                        ),
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
