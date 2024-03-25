import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../permissions.dart';
import '../widgets/widgets.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({
    super.key,
    required this.appTermsAndConditionsUrl,
  });

  final String appTermsAndConditionsUrl;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    final isTermsAndConditionsProvided = appTermsAndConditionsUrl.isNotEmpty;

    return Scaffold(
      body: BlocConsumer<PermissionsCubit, PermissionsState>(
        listener: (context, state) {
          if (state.status case PermissionsStatus.success) {
            context.router.replaceAll([const MainShellRoute()]);
          } else if (state.status case PermissionsStatus.failure) {
            context.showErrorSnackBar(state.error.toString());
            context.read<PermissionsCubit>().dismissError();
          }
        },
        builder: (context, state) {
          final body = Padding(
            padding: const EdgeInsets.all(kInset),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: kInset * 2),
                Icon(
                  Icons.settings_suggest,
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
                if (isTermsAndConditionsProvided)
                  AgreementCheckbox(
                    userAgreementAccepted: state.userAgreementAccepted,
                    onChanged: context.read<PermissionsCubit>().changeUserAgreement,
                    onAgreementLinkTap: () => context.router
                        .navigate(TermsConditionsScreenPageRoute(initialUriQueryParam: appTermsAndConditionsUrl)),
                  ),
                const SizedBox(height: kInset / 2),
                if (state.status.isInitial && state.userAgreementAccepted ||
                    state.status.isInitial && !isTermsAndConditionsProvided)
                  OutlinedButton(
                    onPressed: () => context.read<PermissionsCubit>().requestPermissions(),
                    style: elevatedButtonStyles?.primary,
                    child: Text(context.l10n.permission_Button_request),
                  )
                else
                  OutlinedButton(
                    onPressed: null,
                    style: elevatedButtonStyles?.primary,
                    child: state.userAgreementAccepted || !isTermsAndConditionsProvided
                        ? SizedCircularProgressIndicator(
                            size: 16,
                            strokeWidth: 2,
                            color: elevatedButtonStyles?.primary?.foregroundColor?.resolve({}),
                          )
                        : Text(context.l10n.permission_Button_request),
                  )
              ],
            ),
          );
          return LayoutBuilder(
            builder: (context, viewportConstraints) {
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
