import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../extensions/extensions.dart';
import '../bloc/network_cubit.dart';
import '../widgets/widgets.dart';

class NetworkScreen extends StatelessWidget {
  const NetworkScreen({
    super.key,
  });

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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
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
                      trailing: IconButton(
                          icon: const Icon(Icons.info_outline),
                          onPressed: () => AcknowledgeDialog.show(
                                context,
                                title: item.incomingCallType.titleL10n(context),
                                content: item.incomingCallType.descriptionL10n(context),
                              )),
                      leading:
                          item.selected ? const Icon(Icons.check_circle_sharp) : const Icon(Icons.check_circle_outline),
                      onTap: () => context.read<NetworkCubit>().selectIncomingCallType(item),
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
}
