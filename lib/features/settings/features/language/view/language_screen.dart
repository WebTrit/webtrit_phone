import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/localization.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../../widgets/widgets.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locales = [
      LocaleExtension.defaultNull,
      ...AppLocalizations.supportedLocales,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings_ListViewTileTitle_language),
        leading: const ExtBackButton(),
      ),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return ListView.separated(
            itemBuilder: (context, index) {
              final locale = locales[index];
              return RadioListTile<Locale>(
                value: locale,
                groupValue: state.locale,
                onChanged: (value) => context.read<AppBloc>().add(AppLocaleChanged(value!)),
                title: Text(locale.l10n(context)),
              );
            },
            separatorBuilder: (context, index) => const ListTileSeparator(),
            itemCount: locales.length,
          );
        },
      ),
    );
  }
}
