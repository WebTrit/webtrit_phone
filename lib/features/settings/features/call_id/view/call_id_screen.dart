import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../call_id.dart';

class CallIdScreen extends StatelessWidget {
  const CallIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings_ListViewTileTitle_call_id),
        leading: const ExtBackButton(),
      ),
      body: BlocBuilder<CallIdCubit, CallIdState>(
        builder: (context, state) {
          switch (state) {
            case CallIdStateInitializing _:
              if (state.error != null) {
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(state.error.toString()),
                      const SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: () => context.read<CallIdCubit>().refresh(),
                        child: Text(context.l10n.common_noInternetConnection_retryButton),
                      ),
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());

            case CallIdStateCommon _:
              return CallIdScreenBody(
                enabled: state.enabled,
                available: state.available,
                selected: state.selected,
                onEnabledChanged: context.read<CallIdCubit>().setEnabled,
                onSelectedChanged: context.read<CallIdCubit>().setSelected,
              );
          }
        },
      ),
    );
  }
}

class CallIdScreenBody extends StatelessWidget {
  const CallIdScreenBody({
    required this.enabled,
    required this.available,
    required this.selected,
    required this.onEnabledChanged,
    required this.onSelectedChanged,
    super.key,
  });

  final bool enabled;
  final List<String> available;
  final String? selected;

  final void Function(bool) onEnabledChanged;
  final void Function(String?) onSelectedChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    context.l10n.settings_caller_id_enabled,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Switch(
                    value: enabled,
                    onChanged: onEnabledChanged,
                  ),
                ],
              ),
            ),
            Divider(
              height: 16,
              thickness: 1,
              indent: 16,
              endIndent: 16,
              color: Theme.of(context).dividerColor,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    selected: null == selected,
                    title: Text(context.l10n.settings_caller_id_auto),
                    onTap: () => onSelectedChanged(null),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    leading: const Icon(Icons.manage_history_outlined),
                    // contentPadding: EdgeInsets.zero,
                  ),
                  for (final number in available)
                    ListTile(
                      selected: number == selected,
                      title: Text(number),
                      onTap: () => onSelectedChanged(number),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      leading: const Icon(Icons.medical_information_outlined),
                      // contentPadding: EdgeInsets.zero,
                    ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
