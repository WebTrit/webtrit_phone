import 'package:webtrit_phone/data/platform_info.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/incoming_call_type.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../extensions/extensions.dart';
import '../bloc/network_cubit.dart';
import '../widgets/widgets.dart';

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({
    super.key,
  });

  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  int? _cachedAndroidSdkVersion;

  @override
  Widget build(BuildContext context) {
    final block = context.read<NetworkCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings_ListViewTileTitle_network),
        leading: const ExtBackButton(),
      ),
      body: BlocBuilder<NetworkCubit, NetworkState>(
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.incomingCallTypeModels.length,
                  itemBuilder: (context, index) {
                    final item = state.incomingCallTypeModels[index];
                    return ListTile(
                      selected: item.selected,
                      title: Text(item.incomingCallType.titleL10n(context)),
                      trailing: InfoTooltip(
                        message: item.incomingCallType.descriptionL10n(context),
                      ),
                      leading: Check(selected: item.selected),
                      onTap: () async {
                        context.read<NetworkCubit>().selectIncomingCallType(item);
                        if (item.incomingCallType == IncomingCallType.socket) {
                          await _showPersistentConnectionReminderIfNeeded(context);
                        }
                      },
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    context.l10n.settings_network_fallbackCalls_title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: InfoTooltip(
                    message: context.l10n.settings_network_fallbackCalls_description,
                  ),
                ),
                ListTile(
                  leading: Check(
                    selected: state.smsFallbackEnabled,
                    enabled: block.smsFallbackAvailable,
                  ),
                  title: Text(
                    context.l10n.settings_network_smsFallback_toggle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future<bool> _isAndroidVersionAtLeast(int targetVersion) async {
    if (PlatformInfo().isWeb) return false;
    if (!PlatformInfo().isAndroid) return false;
    if (_cachedAndroidSdkVersion == null) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      _cachedAndroidSdkVersion = androidInfo.version.sdkInt;
    }
    return _cachedAndroidSdkVersion! >= targetVersion;
  }

  Future<void> _showPersistentConnectionReminderIfNeeded(BuildContext context) async {
    final title = context.l10n.persistentConnectionReminderTitle;
    final content = context.l10n.persistentConnectionReminderContent;

    final isAndroid14OrAbove = await _isAndroidVersionAtLeast(34);

    if (isAndroid14OrAbove) {
      if (context.mounted) {
        AcknowledgeDialog.show(
          context,
          title: title,
          content: content,
        );
      }
    }
  }
}
