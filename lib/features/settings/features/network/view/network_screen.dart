import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../extensions/extensions.dart';
import '../bloc/network_cubit.dart';
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
        listener: (context, state) {
          if (state.isSelectedTypeInRemainder) _showTypeReminder(state.incomingCallType);
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.incomingCallTypeModels.length,
                  itemBuilder: (context, index) {
                    final item = state.incomingCallTypeModels[index];
                    return ListTile(
                      selected: item.selected,
                      title: Text(item.incomingCallType.titleL10n(context)),
                      trailing: InfoTooltip(message: item.incomingCallType.descriptionL10n(context)),
                      leading: Check(selected: item.selected),
                      onTap: () => _cubit.selectIncomingCallType(item),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    context.l10n.settings_network_fallbackCalls_title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: InfoTooltip(message: context.l10n.settings_network_fallbackCalls_description),
                ),
                ListTile(
                  leading: Check(selected: state.smsFallbackEnabled, enabled: _cubit.smsFallbackAvailable),
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

  void _showTypeReminder(IncomingCallType type) {
    final title = type.remainderTitleL10n(context);
    final description = type.remainderDescriptionL10n(context);

    if (context.mounted && title != null && description != null) {
      AcknowledgeDialog.show(context, title: title, content: description);
    }
  }
}
