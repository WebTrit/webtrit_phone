import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/features/user_agreement/widgets/widgets.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';

class UserAgreementScreen extends StatefulWidget {
  const UserAgreementScreen({super.key, required this.appTermsAndConditionsUrl});

  final String appTermsAndConditionsUrl;

  @override
  State<UserAgreementScreen> createState() => _UserAgreementScreenState();
}

class _UserAgreementScreenState extends State<UserAgreementScreen> {
  bool userAgreementAccepted = false;

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
                    Icon(
                      Icons.menu_book_rounded,
                      color: Theme.of(context).colorScheme.primary,
                      size: kInset * 6,
                    ),
                    const SizedBox(height: kInset * 2),
                    Text(
                      context.l10n.permission_Text_description,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    const SizedBox(height: kInset),
                    AgreementCheckbox(
                      agreementLink: widget.appTermsAndConditionsUrl,
                      userAgreementAccepted: userAgreementAccepted,
                      onChanged: (value) => setState(() => userAgreementAccepted = value),
                      onAgreementLinkTap: () => context.router.navigate(
                          TermsConditionsScreenPageRoute(initialUriQueryParam: widget.appTermsAndConditionsUrl)),
                    ),
                    const SizedBox(height: kInset / 2),
                    if (userAgreementAccepted)
                      OutlinedButton(
                        onPressed: () => context.read<AppBloc>().add(const AppUserAgreementAccepted()),
                        style: elevatedButtonStyles?.primary,
                        child: Text(context.l10n.permission_Button_request),
                      )
                    else
                      OutlinedButton(
                        onPressed: null,
                        style: elevatedButtonStyles?.primary,
                        child: Text(context.l10n.permission_Button_request),
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


// TODO : New description and icon for user agreement