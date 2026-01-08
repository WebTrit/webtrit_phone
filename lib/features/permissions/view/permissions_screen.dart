import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

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

final _logger = Logger('PermissionsScreen');

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Necessary to re-check the permissions status after the user has potentially
    // modified them in the app settings. The transition to the `resumed` lifecycle state
    // indicates that the user is returning to the app.
    if (state == AppLifecycleState.resumed) {
      context.read<PermissionsCubit>().checkPermissions();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<PermissionsCubit, PermissionsState>(
            listenWhen: (previous, current) => !previous.shouldShowManufacturerTip && current.shouldShowManufacturerTip,
            listener: (context, state) => _showManufacturerTips(context, state.manufacturerTip!.manufacturer),
          ),
          BlocListener<PermissionsCubit, PermissionsState>(
            listenWhen: (previous, current) =>
                !previous.requiresSpecialPermissionsAction && current.requiresSpecialPermissionsAction,
            listener: (context, state) => _showSpecialPermissionTips(context, state.missingSpecialPermissions.first),
          ),
          BlocListener<PermissionsCubit, PermissionsState>(
            listenWhen: (previous, current) => !previous.hasFailure && current.hasFailure,
            listener: (context, state) => _showErrorNotification(context, state.failure!),
          ),
          BlocListener<PermissionsCubit, PermissionsState>(
            listenWhen: (_, current) => current.isFlowCompleted,
            listener: (context, state) => _navigateToMain(),
          ),
        ],
        child: BlocBuilder<PermissionsCubit, PermissionsState>(
          builder: (context, state) {
            final isRequesting = state.isRequesting;
            final isFlowCompleted = state.isFlowCompleted;

            final foregroundColor = elevatedButtonStyles?.primary?.foregroundColor?.resolve({});
            final button = isRequesting
                ? SizedCircularProgressIndicator(size: 16, strokeWidth: 2, color: foregroundColor)
                : Text(context.l10n.permission_Button_request);

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
                  if (!state.isPermanentlyDenied)
                    OutlinedButton(
                      key: permissionsInitButtonKey,
                      onPressed: _onRequestPermissions(context, isRequesting, isFlowCompleted),
                      style: elevatedButtonStyles?.primary,
                      child: button,
                    ),

                  if (state.isPermanentlyDenied)
                    OutlinedButton(
                      onPressed: context.read<PermissionsCubit>().openAppSettings,
                      style: elevatedButtonStyles?.neutral,
                      child: Text(context.l10n.permission_manufacturer_Button_toSettings),
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
      ),
    );
  }

  // Navigates to the main screen, replacing the current route.
  void _navigateToMain() => context.router.replaceAll([const MainShellRoute()]);

  /// Returns a callback to handle the request permissions button press.
  VoidCallback? _onRequestPermissions(BuildContext context, bool isRequesting, bool isFlowCompleted) {
    _logger.info(
      'On request permissions button pressed - isRequesting: $isRequesting, isFlowCompleted: $isFlowCompleted',
    );
    // Prevents PlatformException(error, A request for permissions is already running, null, null)
    // by disabling button interaction, as the permission_handler throws an exception on concurrent requests.
    if (isRequesting) return null;

    if (isFlowCompleted) return () => _navigateToMain();

    return () => context.read<PermissionsCubit>().initiatePermissionFlow();
  }

  /// Shows a screen with tips for a specific manufacturer.
  Future<void> _showManufacturerTips(BuildContext context, Manufacturer manufacturer) async {
    final permissionCubit = context.read<PermissionsCubit>();

    final view = BlocBuilder<PermissionsCubit, PermissionsState>(
      bloc: permissionCubit,
      builder: (context, state) {
        VoidCallback onPopCallback() {
          return () {
            permissionCubit.dismissManufacturerTip();
            Navigator.of(context).pop();
          };
        }

        return ManufacturerPermission(
          manufacturer: manufacturer,
          onGoToAppSettings: permissionCubit.openAppSettings,
          onPop: onPopCallback(),
        );
      },
    );

    await context.router.pushWidget(view, transitionBuilder: TransitionsBuilders.slideLeftWithFade);
  }

  /// Shows a screen with instructions for granting a special permission.
  Future<void> _showSpecialPermissionTips(BuildContext context, CallkeepSpecialPermissions permission) async {
    final permissionCubit = context.read<PermissionsCubit>();

    final view = BlocBuilder<PermissionsCubit, PermissionsState>(
      bloc: permissionCubit,
      builder: (context, state) {
        VoidCallback? onPopCallback() {
          if (state.requiresSpecialPermissionsAction) return null;
          if (state.isFlowCompleted) return () => _navigateToMain();
          return () => Navigator.of(context).pop();
        }

        return SpecialPermission(
          specialPermissions: permission,
          onGoToAppSettings: () => permissionCubit.openAppSpecialPermissionSettings(permission),
          onPop: onPopCallback(),
        );
      },
    );

    await context.router.pushWidget(view, transitionBuilder: TransitionsBuilders.slideLeftWithFade);
  }

  void _showErrorNotification(BuildContext context, Object error) {
    context.showErrorSnackBar(error.toString());
    context.read<PermissionsCubit>().dismissError();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
