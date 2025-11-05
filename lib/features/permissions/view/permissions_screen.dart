import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../models/models.dart';
import '../permissions.dart';
import '../widgets/widgets.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    return Scaffold(
      body: BlocConsumer<PermissionsCubit, PermissionsState>(
        listener: (context, state) {
          if (state.isManufacturerTipNeeded) {
            _showManufacturerTips(context, state.manufacturerTip!.manufacturer);
          } else if (state.isSpecialPermissionNeeded) {
            _showSpecialPermissionTips(context, state.pendingSpecialPermissions.first);
          } else if (state.isFailure) {
            context.showErrorSnackBar(state.failure.toString());
            context.read<PermissionsCubit>().dismissError();
          } else if (state.isSuccess) {
            context.router.replaceAll([const MainShellRoute()]);
          }
        },
        builder: (context, state) {
          final body = Padding(
            padding: const EdgeInsets.all(kInset),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: kInset * 2),
                const AppIcon(Icons.settings_suggest, size: kInset * 6),
                const SizedBox(height: kInset * 2),
                Text(
                  context.l10n.permission_Text_description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Spacer(),
                const SizedBox(height: kInset),
                if (state.isInitial)
                  OutlinedButton(
                    key: permissionsInitButtonKey,
                    onPressed: () => context.read<PermissionsCubit>().requestPermissions(),
                    style: elevatedButtonStyles?.primary,
                    child: Text(context.l10n.permission_Button_request),
                  )
                else
                  OutlinedButton(
                    onPressed: null,
                    style: elevatedButtonStyles?.primary,
                    child: SizedCircularProgressIndicator(
                      size: 16,
                      strokeWidth: 2,
                      color: elevatedButtonStyles?.primary?.foregroundColor?.resolve({}),
                    ),
                  ),
              ],
            ),
          );
          return LayoutBuilder(
            builder: (context, viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: IntrinsicHeight(child: InertSafeArea(bottom: true, child: body)),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future _showManufacturerTips(BuildContext context, Manufacturer manufacturer) async {
    final permissionCubit = context.read<PermissionsCubit>();
    final view = ManufacturerPermission(
      manufacturer: manufacturer,
      onGoToAppSettings: permissionCubit.openAppSettings,
      onPop: () => context.maybePop(),
    );
    await context.router.pushWidget(view, transitionBuilder: TransitionsBuilders.slideLeftWithFade);

    permissionCubit.dismissTip();
    permissionCubit.requestPermissions();
  }

  Future _showSpecialPermissionTips(BuildContext context, CallkeepSpecialPermissions permission) async {
    final permissionCubit = context.read<PermissionsCubit>();
    final view = SpecialPermission(
      specialPermissions: permission,
      onGoToAppSettings: () => permissionCubit.openAppSpecialPermissionSettings(permission),
      onPop: () => context.maybePop(),
    );

    await context.router.pushWidget(view, transitionBuilder: TransitionsBuilders.slideLeftWithFade);

    permissionCubit.dismissTip();
    permissionCubit.requestPermissions();
  }
}
