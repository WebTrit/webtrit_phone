import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../../widgets/widgets.dart';

class ThemeModeScreen extends StatelessWidget {
  const ThemeModeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const themeModes = ThemeMode.values;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings_ListViewTileTitle_themeMode),
        leading: const ExtBackButton(),
      ),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return RadioGroup<ThemeMode>(
            groupValue: state.effectiveThemeMode,
            onChanged: (ThemeMode? value) {
              if (!state.isThemeModeSupported || value == null) return;
              context.read<AppBloc>().add(AppThemeModeChanged(value));
            },
            child: ListView.separated(
              itemCount: themeModes.length,
              separatorBuilder: (context, index) => const ListTileSeparator(),
              itemBuilder: (context, index) {
                final themeMode = themeModes[index];
                return RadioListTile<ThemeMode>(
                  value: themeMode,
                  title: Text(themeMode.l10n(context)),
                  enabled: state.isThemeModeSupported,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
