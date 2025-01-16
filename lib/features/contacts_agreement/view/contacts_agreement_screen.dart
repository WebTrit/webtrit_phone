import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
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
  bool contactAgreementAccepted = false;

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
                      Icons.contacts,
                      size: kInset * 6,
                    ),
                    const SizedBox(height: kInset * 2),
                    Text(
                      context.l10n.contacts_agreement_title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(height: kInset),
                    Text(
                      context.l10n.contacts_agreement_description,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    const SizedBox(height: kInset),
                    AgreementCheckbox(
                      agreementAccepted: contactAgreementAccepted,
                      onChanged: (value) => setState(() => contactAgreementAccepted = value),
                      text: context.l10n.contacts_agreement_checkbox_text,
                    ),
                    const SizedBox(height: kInset / 2),
                    if (contactAgreementAccepted)
                      OutlinedButton(
                        onPressed: () =>
                            context.read<AppBloc>().add(const AppAgreementAccepted.contactsAgreementAccepted()),
                        style: elevatedButtonStyles?.primary,
                        child: Text(context.l10n.contacts_agreement_button_text),
                      )
                    else
                      OutlinedButton(
                        onPressed: null,
                        style: elevatedButtonStyles?.primary,
                        child: Text(context.l10n.contacts_agreement_button_text),
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
}
