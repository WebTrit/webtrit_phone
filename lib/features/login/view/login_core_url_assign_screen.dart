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

class LoginCoreUrlAssignScreen extends StatefulWidget {
  const LoginCoreUrlAssignScreen({super.key});

  @override
  State<LoginCoreUrlAssignScreen> createState() => _LoginCoreUrlAssignScreenState();
}

class _LoginCoreUrlAssignScreenState extends State<LoginCoreUrlAssignScreen> {
  final HistoryAutocompleteController _historyController = HistoryAutocompleteController();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();

    // TODO: Add separate style for this screen
    final LoginSwitchScreenStyles? loginPageStyles = themeData.extension<LoginSwitchScreenStyles>();
    final LoginSwitchScreenStyle? localStyle = loginPageStyles?.primary;

    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => whenLoginCoreUrlAssignScreenPageActive(current),
      builder: (context, state) => LoginScaffold(
        appBar: AppBar(
          leading: ExtBackButton(disabled: state.processing),
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              ConfigurableThemeImage(style: localStyle?.pictureLogoStyle),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(kInset, kInset / 2, kInset, kInset),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (context.l10n.login_Text_coreUrlAssignPreDescription.isNotEmpty) ...[
                        Description(text: context.l10n.login_Text_coreUrlAssignPreDescription),
                        const SizedBox(height: kInset / 2),
                      ],
                      HistoryAutocompleteField(
                        storageKey: 'recent_core_urls',
                        labelText: context.l10n.login_TextFieldLabelText_coreUrlAssign,
                        key: coreUrlInputKey,
                        controller: _historyController,
                        initialValue: state.coreUrlInput.value,
                        errorText: state.coreUrlInput.displayError?.l10n(context),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.url],
                        enabled: !state.processing,
                        onChanged: context.read<LoginCubit>().coreUrlInputChanged,
                        onSubmit: !state.coreUrlInput.isValid ? null : () => _onCoreUrlAssignSubmitted(context),
                      ),
                      if (context.l10n
                          .login_Text_coreUrlAssignPostDescription(EnvironmentConfig.SALES_EMAIL)
                          .isNotEmpty) ...[
                        const SizedBox(height: kInset / 8),
                        Description(
                          text: context.l10n.login_Text_coreUrlAssignPostDescription(EnvironmentConfig.SALES_EMAIL),
                          launchLinkableElement: true,
                        ),
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
      ),
    );
  }

  void _onCoreUrlAssignSubmitted(BuildContext context) {
    _historyController.saveToHistory();
    context.read<LoginCubit>().loginCoreUrlAssignSubmitted();
  }
}
