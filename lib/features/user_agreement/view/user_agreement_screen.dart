import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/features/user_agreement/widgets/widgets.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class UserAgreementScreen extends StatefulWidget {
  const UserAgreementScreen({
    super.key,
    required this.appTermsAndConditionsUrl,
    required this.appName,
  });

  final String appTermsAndConditionsUrl;
  final String appName;

  @override
  State<UserAgreementScreen> createState() => _UserAgreementScreenState();
}

class _UserAgreementScreenState extends State<UserAgreementScreen> {
  late AgreementStatus agreementStatus = context.read<AppBloc>().state.userAgreementStatus;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();

    return Scaffold(
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, appState) {
          return LayoutBuilder(
            builder: (context, viewportConstraints) {
              final body = Padding(
                padding: const EdgeInsets.all(kInset),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: kInset * 2),
                    const AppIcon(
                      Icons.menu_book_rounded,
                      size: kInset * 6,
                    ),
                    const SizedBox(height: kInset * 2),
                    Text(
                      context.l10n.user_agreement_description(widget.appName),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    const SizedBox(height: kInset),
                    AgreementCheckbox(
                      agreementLink: widget.appTermsAndConditionsUrl,
                      userAgreementAccepted: agreementStatus.isAccepted,
                      onChanged: _handleAgreementStatusChange,
                      onAgreementLinkTap: () => context.router.navigate(
                          TermsConditionsScreenPageRoute(initialUriQueryParam: widget.appTermsAndConditionsUrl)),
                    ),
                    const SizedBox(height: kInset / 2),
                    OutlinedButton(
                      onPressed: agreementStatus.isAccepted ? _submitAgreement : null,
                      style: elevatedButtonStyles?.primary,
                      child: Text(context.l10n.user_agreement_button_text),
                    )
                  ],
                ),
              );

              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: body,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _handleAgreementStatusChange(bool value) {
    agreementStatus = value ? AgreementStatus.accepted : AgreementStatus.declined;
    setState(() {});
  }

  void _submitAgreement() {
    context.read<AppBloc>().add(AppAgreementAccepted.updateUserAgreement(agreementStatus));
  }
}
