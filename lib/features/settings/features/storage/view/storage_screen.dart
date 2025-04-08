import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/back_button.dart';
import 'package:webtrit_phone/extensions/file_kind.dart';
import 'package:webtrit_phone/features/settings/features/storage/storage.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  late final StorageCubit _storageCubit = context.read<StorageCubit>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings_ListViewTileTitle_storage),
        leading: const ExtBackButton(),
      ),
      body: BlocBuilder<StorageCubit, StorageState>(
        builder: (context, state) {
          final storageInfo = state.storageInfo;
          final totalSize = storageInfo.values.fold<double>(0, (sum, item) => sum + item);

          return SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    '${context.l10n.settings_storage_total}: ${totalSize.toStringAsFixed(2)} MB',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  for (final entry in storageInfo.entries) ...[
                    Column(
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(entry.key.l10n(context)),
                            const Spacer(),
                            Text('${entry.value.toStringAsFixed(3)} MB'),
                          ],
                        ),
                        const SizedBox(height: 2),
                        LayoutBuilder(builder: (context, constraints) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Stack(
                              children: [
                                Container(
                                  height: 4,
                                  width: double.infinity,
                                  color: Theme.of(context).colorScheme.primary.withAlpha(50),
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height: 4,
                                  width: entry.value / totalSize * constraints.maxWidth,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(context.l10n.settings_storage_downloadOverWifi)),
                      Switch(
                        value: state.isAutoDownloadOnWifiEnabled,
                        onChanged: (value) {
                          _storageCubit.setAutoDownloadOnWifiEnabled(value);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(context.l10n.settings_storage_downloadOverCellular)),
                      Switch(
                        value: state.isAutoDownloadOnCellularEnabled,
                        onChanged: (value) {
                          _storageCubit.setAutoDownloadOnCellularEnabled(value);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Builder(builder: (context) {
                    final Map<int, String> divisionsToLabel = {
                      0: context.l10n.settings_storage_autoClear_week,
                      1: context.l10n.settings_storage_autoClear_month,
                      2: context.l10n.settings_storage_autoClear_3month,
                      3: context.l10n.settings_storage_autoClear_6month,
                      4: context.l10n.settings_storage_autoClear_year,
                    };

                    final Map<int, int> divisionsToDays = {
                      0: 7,
                      1: 30,
                      2: 90,
                      3: 180,
                      4: 365,
                    };

                    final currentValue = divisionsToDays.entries
                        .firstWhere((entry) => entry.value == state.autoClearDuration.inDays)
                        .key;
                    final currentLabel = divisionsToLabel[currentValue]!;

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(context.l10n.settings_storage_autoClear)),
                            const SizedBox(width: 8),
                            Text(currentLabel),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Slider(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          value: currentValue.toDouble(),
                          min: 0,
                          max: 4,
                          divisions: 4,
                          label: currentLabel,
                          onChanged: (value) {
                            final days = divisionsToDays[value.toInt()] ?? 7;
                            _storageCubit.setAutoClearDuration(Duration(days: days));
                          },
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await _storageCubit.clearCache();
                      if (!mounted) return;
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        SnackBar(
                          content: Text(this.context.l10n.settings_storage_clear_success),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Text(
                      context.l10n.settings_storage_clear,
                      style: TextStyle(fontSize: 16, color: colorScheme.secondary),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
