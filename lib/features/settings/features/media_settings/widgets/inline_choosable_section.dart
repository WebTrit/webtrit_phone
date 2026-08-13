import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/keys.dart';

class InlineChoosableSection<T> extends StatelessWidget {
  const InlineChoosableSection({
    required this.title,
    required this.sectionId,
    this.optionIdValue,
    required this.buildOptionTitle,
    required this.options,
    required this.selected,
    required this.onSelect,
    super.key,
  });

  final String? title;

  /// What this section configures, in camelCase. Used to build a stable
  /// automation id per option, because the visible titles are translated and
  /// the same choices repeat across every section on the screen.
  final String sectionId;

  /// What each option stands for, in camelCase, when the section is not a
  /// plain on/off switch (stereo/mono, for instance). Defaults to the on/off
  /// vocabulary, which is what most sections are.
  final String Function(T? option)? optionIdValue;

  final Widget Function(T?) buildOptionTitle;

  final List<T> options;
  final T? selected;
  final Function(T?) onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title != null) ...[
          Row(
            children: [
              const SizedBox(width: 4),
              Expanded(child: Text(title!)),
              const SizedBox(width: 4),
              ToggleButtons(
                borderRadius: BorderRadius.circular(12),
                isSelected: [selected == null, ...options.map((option) => selected == option)],
                children: [
                  _option(null, buildOptionTitle(null)),
                  for (final option in options) _option(option, buildOptionTitle(option)),
                ],
                onPressed: (index) {
                  if (index == 0) {
                    onSelect(null);
                  } else {
                    onSelect(options[index - 1]);
                  }
                },
              ),
            ],
          ),
          // const SizedBox(height: 8.0),
        ],
      ],
    );
  }

  /// Attaches the automation id of one choice.
  ///
  /// Plain Semantics rather than a merging wrapper: the toggle merges its
  /// children into the node that already carries the checked state and the
  /// tap, so the id travels up to it on its own. Nothing else is added here -
  /// the state is the toggle's own.
  Widget _option(T? option, Widget title) {
    final value = optionIdValue?.call(option) ?? _defaultOptionValue(option);

    return Semantics(
      identifier: settingsOptionId(mediaSettingsOptionIdPrefix, '$sectionId${_capitalize(value)}'),
      child: title,
    );
  }

  String _defaultOptionValue(T? option) => switch (option) {
    null => 'auto',
    true => 'on',
    false => 'off',
    final other => other.toString(),
  };

  String _capitalize(String value) => value.isEmpty ? value : value[0].toUpperCase() + value.substring(1);
}
