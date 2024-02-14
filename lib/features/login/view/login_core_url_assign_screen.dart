import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../login.dart';

class LoginCoreUrlAssignScreen extends StatelessWidget {
  const LoginCoreUrlAssignScreen({
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
            title: Text(context.l10n.login_AppBarTitle_coreUrlAssign),
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
                        enabled: !state.processing,
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
                        onPressed: state.processing || !state.coreUrlInput.isValid
                            ? null
                            : () => _onCoreUrlAssignSubmitted(context),
                        style: elevatedButtonStyles?.primary,
                        child: !state.processing
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
        );
      },
    );
  }

  void _onCoreUrlAssignSubmitted(BuildContext context) {
    context.read<LoginCubit>().loginCoreUrlAssignSubmitted();
  }
}
