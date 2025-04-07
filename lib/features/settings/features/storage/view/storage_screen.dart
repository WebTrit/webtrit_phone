import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/back_button.dart';
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
                    'Total: ${totalSize.toStringAsFixed(2)} MB',
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
                            Text(entry.key.name),
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
                      const Expanded(child: Text('Auto download media on Wi-Fi')),
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
                      const Expanded(child: Text('Auto download media on cellular')),
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
                      0: 'Week',
                      1: 'Month',
                      2: '3 months',
                      3: '6 months',
                      4: 'Year',
                    };
                    final Map<int, int> divisionsToDays = {
                      0: 7,
                      1: 30,
                      2: 90,
                      3: 180,
                      4: 365,
                    };

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(child: Text('Clear unused media after:')),
                            const SizedBox(width: 8),
                            Text(divisionsToLabel[divisionsToDays.entries
                                    .firstWhere((entry) => entry.value == state.autoClearDuration.inDays)
                                    .key] ??
                                'Week'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Slider(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          value: divisionsToDays.entries
                              .firstWhere((entry) => entry.value == state.autoClearDuration.inDays)
                              .key
                              .toDouble(),
                          min: 0,
                          max: 4,
                          divisions: 4,
                          label: divisionsToLabel[divisionsToDays.entries
                                  .firstWhere((entry) => entry.value == state.autoClearDuration.inDays)
                                  .key] ??
                              'Week',
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
                        const SnackBar(
                          content: Text('Cache cleared'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Text(
                      'Clear cache',
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
