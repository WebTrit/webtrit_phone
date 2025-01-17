import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/agreement_status.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../widgets/widgets.dart';

class ContactsAgreementScreen extends StatefulWidget {
  const ContactsAgreementScreen({
    super.key,
  });

  @override
  State<ContactsAgreementScreen> createState() => _ContactsAgreementScreenState();
}

class _ContactsAgreementScreenState extends State<ContactsAgreementScreen> {
  late AgreementStatus agreementStatus = context.read<AppBloc>().state.contactsAgreementStatus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final elevatedButtonStyles = theme.extension<ElevatedButtonStyles>();

    return Scaffold(
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, appState) {
          return LayoutBuilder(
            builder: (context, viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(kInset),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: kInset * 2),
                          const AppIcon(Icons.contacts, size: kInset * 6),
                          const SizedBox(height: kInset * 2),
                          Text(
                            context.l10n.contacts_agreement_title,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary),
                          ),
                          const SizedBox(height: kInset),
                          Text(
                            context.l10n.contacts_agreement_description,
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                          const SizedBox(height: kInset),
                          AgreementCheckbox(
                            agreementAccepted: agreementStatus.isAccepted,
                            onChanged: _handleAgreementStatusChange,
                            text: context.l10n.contacts_agreement_checkbox_text,
                          ),
                          const SizedBox(height: kInset / 2),
                          OutlinedButton(
                            onPressed: _submitAgreement,
                            style: elevatedButtonStyles?.primary,
                            child: Text(context.l10n.contacts_agreement_button_text),
                          ),
                        ],
                      ),
                    ),
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
    final resultStatus = agreementStatus.isPending ? AgreementStatus.declined : agreementStatus;
    context.read<AppBloc>().add(AppAgreementAccepted.updateContactsAgreement(resultStatus));
  }
}
