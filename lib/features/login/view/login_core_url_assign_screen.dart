import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../login.dart';

class LoginCoreUrlAssignScreen extends StatelessWidget {
  const LoginCoreUrlAssignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();

    // TODO: Add separate style for this screen
    final LoginSwitchScreenStyles? loginPageStyles = themeData.extension<LoginSwitchScreenStyles>();
    final LoginSwitchScreenStyle? localStyle = loginPageStyles?.primary;

    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => whenLoginCoreUrlAssignScreenPageActive(current),
      builder: (context, state) {
        final coreUrlAssignPreDescriptionText = context.l10n.login_Text_coreUrlAssignPreDescription;
        final coreUrlAssignPostDescriptionText = context.l10n.login_Text_coreUrlAssignPostDescription(
          EnvironmentConfig.SALES_EMAIL,
        );

        return LoginScaffold(
          appBar: AppBar(
            leading: ExtBackButton(disabled: state.processing),
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                OnboardingLogo(style: localStyle?.onboardingLogoStyle),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(kInset, kInset / 2, kInset, kInset),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (coreUrlAssignPreDescriptionText.isNotEmpty) ...[
                          Description(text: coreUrlAssignPreDescriptionText),
                          const SizedBox(height: kInset / 2),
                        ],
                        HistoryAutocompleteField(
                          key: coreUrlInputKey,
                          storageKey: 'recent_core_urls',
                          labelText: context.l10n.login_TextFieldLabelText_coreUrlAssign,
                          initialValue: state.coreUrlInput.value,
                          errorText: state.coreUrlInput.displayError?.l10n(context),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [AutofillHints.url],
                          enabled: !state.processing,
                          onChanged: context.read<LoginCubit>().coreUrlInputChanged,
                          onSubmit: !state.coreUrlInput.isValid ? null : () => _onCoreUrlAssignSubmitted(context),
                        ),
                        if (coreUrlAssignPostDescriptionText.isNotEmpty) ...[
                          const SizedBox(height: kInset / 8),
                          Description(text: coreUrlAssignPostDescriptionText, launchLinkableElement: true),
                        ],
                        const Spacer(),
                        const SizedBox(height: kInset),
                        ElevatedButton(
                          key: coreUrlButtonKey,
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
          ),
        );
      },
    );
  }

  void _onCoreUrlAssignSubmitted(BuildContext context) {
    context.read<LoginCubit>().loginCoreUrlAssignSubmitted();
  }
}
