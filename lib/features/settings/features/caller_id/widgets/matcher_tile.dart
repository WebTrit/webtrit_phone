import 'package:flutter/material.dart';

import 'package:country_code_picker/country_code_picker.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/models/caller_id_settings.dart';
import 'package:webtrit_phone/features/settings/features/caller_id/caller_id.dart';

class MatcherTile extends StatelessWidget {
  const MatcherTile({required this.matcher, super.key});

  final PrefixMatcher matcher;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withAlpha(25),
            blurRadius: 32,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CountryCodePicker(
            initialSelection: matcher.prefix,
            showFlag: true,
            showFlagDialog: true,
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            onChanged: (code) {},
            enabled: false,
            padding: EdgeInsets.zero,
          ),
          Text('=>  ${matcher.number}'),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              context.read<CallerIdSettingsCubit>().removePrefixMatcher(matcher.prefix);
            },
          ),
        ],
      ),
    );
  }
}
