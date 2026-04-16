import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../extensions/extensions.dart';
import '../bloc/network_cubit.dart';
import '../models/incoming_call_type_model.dart';
import '../widgets/widgets.dart';

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({super.key});

  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  late final NetworkCubit _cubit = context.read<NetworkCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settings_ListViewTileTitle_network), leading: const ExtBackButton()),
      body: BlocConsumer<NetworkCubit, NetworkState>(
        listenWhen: (previous, current) {
          return previous.incomingCallType != current.incomingCallType;
        },
        listener: (context, state) async {
          if (state.isSelectedTypeInRemainder) await _showTypeReminder(state.incomingCallType);
          if (state.incomingCallType == IncomingCallType.socket) await _checkAndShowBatteryWarning();
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    context.l10n.settings_network_incomingCallType_title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                RadioGroup<IncomingCallTypeModel?>(
                  groupValue: state.incomingCallTypeModels.firstWhereOrNull((value) => value.selected),
                  onChanged: (value) {
                    if (value == null) return;

                    _cubit.selectIncomingCallType(value);
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.incomingCallTypeModels.length,
                    itemBuilder: (context, index) {
                      final item = state.incomingCallTypeModels[index];
                      return RadioListTile<IncomingCallTypeModel?>(
                        value: item,
                        title: Text(item.incomingCallType.titleL10n(context)),
                        secondary: InfoTooltip(message: item.incomingCallType.descriptionL10n(context)),
                      );
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    context.l10n.settings_network_fallbackCalls_title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: InfoTooltip(message: context.l10n.settings_network_fallbackCalls_description),
                ),
                CheckboxListTile(
                  value: state.smsFallbackEnabled,
                  enabled: _cubit.smsFallbackAvailable,
                  controlAffinity: ListTileControlAffinity.leading,
                  visualDensity: VisualDensity.compact,
                  onChanged: (value) {},
                  title: Text(
                    context.l10n.settings_network_smsFallback_toggle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _showTypeReminder(IncomingCallType type) async {
    final title = type.remainderTitleL10n(context);
    final description = type.remainderDescriptionL10n(context);

    if (context.mounted && title != null && description != null) {
      await AcknowledgeDialog.show(context, title: title, content: description);
    }
  }

  Future<void> _checkAndShowBatteryWarning() async {
    final needsWarning = await _cubit.isSocketMissingBatteryExemption();
    if (!needsWarning || !mounted) return;

    final openSettings = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(ctx.l10n.batteryOptimizationWarningTitle),
        content: Text(ctx.l10n.batteryOptimizationWarningContent),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text(ctx.l10n.alertDialogActions_no)),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(ctx.l10n.batteryOptimizationWarningOpenSettings),
          ),
        ],
      ),
    );
    if (openSettings == true && mounted) {
      await _cubit.openBatterySettings();
    }
  }
}
