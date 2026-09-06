import 'package:flutter/material.dart';

import 'package:country_code_picker/country_code_picker.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/settings/features/caller_id/caller_id.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/caller_id_settings.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class MatcherTile extends StatelessWidget {
  const MatcherTile({required this.matcher, required this.index, super.key});

  final PrefixMatcher matcher;

  /// Position of the row among the rules; the automation id is built from it,
  /// because a rule is identified by a dial code the test cannot know upfront.
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: colorScheme.shadow.withAlpha(25), blurRadius: 32, offset: const Offset(4, 4))],
      ),
      child: Row(
        children: [
          // The rule is drawn as three pieces - a flag with a dial code, an
          // arrow, a number - and each of them used to be announced on its own,
          // the arrow as the glyph it is. None of the three is interactive
          // here, so the whole thing is read as the one sentence it states.
          MergeSemantics(
            child: Semantics(
              label: context.l10n.callerId_SemanticsLabel_matchRule(matcher.prefix, matcher.number),
              child: ExcludeSemantics(
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
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          SemanticAction(
            label: context.l10n.callerId_SemanticsLabel_removeMatch(matcher.prefix),
            identifier: numberedId(callerIdRemoveMatchId, index),
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                context.read<CallerIdSettingsCubit>().removePrefixMatcher(matcher.prefix);
              },
            ),
          ),
        ],
      ),
    );
  }
}
