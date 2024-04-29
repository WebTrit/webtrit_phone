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
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    return Scaffold(
      body: BlocConsumer<PermissionsCubit, PermissionsState>(
        listener: (context, state) {
          switch (state) {
            // Shows additional screen for specific sub-platform if needed
            case PermissionsStateSubPlatformTipNeeded(:final subPlatform):
              _showPlatformTips(context, subPlatform);
            case PermissionsStateSuccess():
              context.router.replaceAll([const MainShellRoute()]);
            case PermissionsStateFailure(:final error):
              context.showErrorSnackBar(error.toString());
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
                switch (state) {
                  PermissionsStateInitial() => OutlinedButton(
                      onPressed: () => context.read<PermissionsCubit>().requestPermissions(),
                      style: elevatedButtonStyles?.primary,
                      child: Text(context.l10n.permission_Button_request),
                    ),
                  _ => OutlinedButton(
                      onPressed: null,
                      style: elevatedButtonStyles?.primary,
                      child: SizedCircularProgressIndicator(
                        size: 16,
                        strokeWidth: 2,
                        color: elevatedButtonStyles?.primary?.foregroundColor?.resolve({}),
                      ),
                    ),
                },
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

  Future _showPlatformTips(BuildContext context, Manufacturer subPlatform) async {
    final permissionCubit = context.read<PermissionsCubit>();

    await context.router.pushWidget(PermissionTips(
      onGoToAppSettings: permissionCubit.openAppSettings,
      platform: subPlatform,
    ));

    permissionCubit.dismissSubPlatformTip();
  }
}
