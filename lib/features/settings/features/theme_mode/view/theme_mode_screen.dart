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
          return ListView.separated(
            itemBuilder: (context, index) {
              final themeMode = themeModes[index];
              return RadioListTile<ThemeMode>(
                value: themeMode,
                groupValue: state.effectiveThemeMode,
                onChanged: !state.isThemeModeSupported
                    ? null
                    : (value) => context.read<AppBloc>().add(AppThemeModeChanged(value!)),
                title: Text(themeMode.l10n(context)),
              );
            },
            separatorBuilder: (context, index) => const ListTileSeparator(),
            itemCount: themeModes.length,
          );
        },
      ),
    );
  }
}
