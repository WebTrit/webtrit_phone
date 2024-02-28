import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../permissions.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    return Scaffold(
      body: BlocConsumer<PermissionsCubit, PermissionsState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            context.router.replaceAll([const MainShellRoute()]);
          }
          if (state.error != null) {
            context.showErrorSnackBar(state.error.toString());
            context.read<PermissionsCubit>().dismissError();
          }
        },
        builder: (context, state) {
          if (state.status.isSuccess) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
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
                  OutlinedButton(
                    onPressed: () => context.read<PermissionsCubit>().requestPermissions(),
                    style: elevatedButtonStyles?.primary,
                    child: Text(context.l10n.permission_Button_request),
                  ),
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
          }
        },
      ),
    );
  }
}
