import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/settings/features/diagnostic/bloc/network_tester_cubit.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/agreement_status.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../../../widgets/widgets.dart';
import '../bloc/diagnostic_cubit.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import '../extensions/extensions.dart';

class DiagnosticScreen extends StatefulWidget {
  const DiagnosticScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DiagnosticScreenState createState() => _DiagnosticScreenState();
}

class _DiagnosticScreenState extends State<DiagnosticScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<DiagnosticCubit>().fetchStatuses();
    }
  }

  @override
  Widget build(BuildContext context) {
    final androidTarget = PlatformInfo.isAndroid;
    final contactsAgreementStatus = context.watch<AppBloc>().state.contactsAgreementStatus;

    return BlocBuilder<DiagnosticCubit, DiagnosticState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(leading: const AutoLeadingButton(), title: Text(context.l10n.diagnostic_AppBar_title)),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text(context.l10n.diagnosticScreen_pushNotificationService_title),
                  trailing: Icon(
                    state.pushTokenStatus.type.isSuccess ? Icons.check_circle : Icons.error_outline,
                    color: state.pushTokenStatus.type.isSuccess ? Colors.green : Colors.red,
                  ),
                  subtitle: Text(state.pushTokenStatus.type.title(context)),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) => DiagnosticPushDetails(
                        status: state.pushTokenStatus,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    );
                  },
                ),
                if (androidTarget) GroupTitleListTile(titleData: context.l10n.diagnostic_battery_groupTitle),
                if (androidTarget)
                  DiagnosticBatteryModeItem(
                    batteryMode: state.batteryMode,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => DiagnosticBatteryModeDetails(
                          batteryMode: state.batteryMode,
                          onTap: () {
                            _openPermissions();
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                  ),
                if (androidTarget && state.callDeliveryMode == CallkeepAndroidCallDeliveryMode.standalone) ...[
                  GroupTitleListTile(titleData: context.l10n.diagnostic_callingMode_groupTitle),
                  DiagnosticCallingModeItem(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) => const DiagnosticCallingModeDetails(),
                    ),
                  ),
                ],
                GroupTitleListTile(titleData: context.l10n.diagnosticScreen_permissionsGroup_title),
                ...state
                    .filterPermissionsByAgreement(
                      exclude: [if (!contactsAgreementStatus.isAccepted) Permission.contacts],
                    )
                    .map(
                      (permission) => DiagnosticPermissionItem(
                        permissionWithStatus: permission,
                        onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return DiagnosticPermissionDetails(
                              permissionWithStatus: permission,
                              onTap: () {
                                _handleRequestPermission(permission);
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                if (androidTarget && state.isXiaomiDevice) ...[
                  GroupTitleListTile(titleData: context.l10n.diagnostic_xiaomi_groupTitle),
                  DiagnosticXiaomiPermissionItem(
                    title: context.l10n.diagnostic_xiaomi_backgroundActivityStart_tile_title,
                    status: state.backgroundActivityStartStatus,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => DiagnosticXiaomiPermissionDetails(
                          title: context.l10n.diagnostic_xiaomi_backgroundActivityStart_tile_title,
                          description: context.l10n.diagnostic_xiaomi_backgroundActivityStart_description,
                          status: state.backgroundActivityStartStatus,
                          onTap: () {
                            _openBackgroundActivityStartSettings();
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                  ),
                  DiagnosticXiaomiPermissionItem(
                    title: context.l10n.diagnostic_xiaomi_showWhenLocked_tile_title,
                    status: state.showWhenLockedStatus,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => DiagnosticXiaomiPermissionDetails(
                          title: context.l10n.diagnostic_xiaomi_showWhenLocked_tile_title,
                          description: context.l10n.diagnostic_xiaomi_showWhenLocked_description,
                          status: state.showWhenLockedStatus,
                          onTap: () {
                            _openShowWhenLockedSettings();
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                  ),
                ],
                Visibility(
                  visible: context.read<DiagnosticScreenContext>().isLocalContactsFeatureEnabled,
                  child: GroupTitleListTile(titleData: context.l10n.diagnosticScreen_contacts_agreement_group_title),
                ),
                Visibility(
                  visible: context.read<DiagnosticScreenContext>().isLocalContactsFeatureEnabled,
                  child: DiagnosticAgreementItem(
                    title: context.l10n.diagnosticScreen_contacts_agreement_title,
                    description: context.l10n.diagnosticScreen_contacts_agreement_description,
                    status: contactsAgreementStatus,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => DiagnosticAgreementDetails(
                          title: context.l10n.diagnosticScreen_contacts_agreement_title,
                          description: context.l10n.contacts_agreement_description,
                          status: contactsAgreementStatus,
                          onApply: (AgreementStatus value) {
                            context.read<AppBloc>().add(AppAgreementAccepted.updateContactsAgreement(value));
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                  ),
                ),
                GroupTitleListTile(titleData: context.l10n.diagnostic_network_groupTitle),
                DiagnosticNetworkTestItem(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => BlocProvider.value(
                        value: context.read<NetworkTesterCubit>(),
                        child: DiagnosticNetworkTestDetails(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleRequestPermission(PermissionWithStatus permission) {
    context.read<DiagnosticCubit>().handleRequestPermission(permission);
  }

  void _openPermissions() {
    context.read<DiagnosticCubit>().openAppSettings();
  }

  void _openShowWhenLockedSettings() {
    context.read<DiagnosticCubit>().openShowWhenLockedSettings();
  }

  void _openBackgroundActivityStartSettings() {
    context.read<DiagnosticCubit>().openBackgroundActivityStartSettings();
  }
}
