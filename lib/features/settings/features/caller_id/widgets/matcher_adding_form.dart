import 'package:flutter/material.dart';

import 'package:country_code_picker/country_code_picker.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

class MatcherAddingForm extends StatefulWidget {
  const MatcherAddingForm({
    required this.numbers,
    required this.addedPrefixes,
    required this.onSave,
    required this.onCancel,
    super.key,
  });

  final List<String> numbers;
  final List<String> addedPrefixes;
  final Function(String prefix, String number) onSave;
  final Function() onCancel;

  @override
  State<MatcherAddingForm> createState() => _MatcherAddingFormState();
}

class _MatcherAddingFormState extends State<MatcherAddingForm> {
  String prefix = '';
  String number = '';

  bool get prefixInUse => widget.addedPrefixes.contains(prefix);
  bool get isValid => prefix.isNotEmpty && number.isNotEmpty && !prefixInUse;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: colorScheme.shadow.withAlpha(25), blurRadius: 32, offset: const Offset(8, 8))],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CountryCodePicker(
                  padding: EdgeInsets.zero,
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  boxDecoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                  initialSelection: 'US',
                  onChanged: (country) => setState(() => prefix = country.dialCode ?? ''),
                  onInit: (value) => prefix = value?.dialCode ?? '',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownMenu<String>(
                  width: double.infinity,
                  hintText: l10n.settings_callerId_number_hint,
                  menuStyle: MenuStyle(
                    backgroundColor: WidgetStateProperty.all(colorScheme.surfaceContainerLow),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                  ),
                  textStyle: TextStyle(color: colorScheme.onSurface, fontSize: 14),
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                    filled: true,
                    fillColor: colorScheme.surfaceContainerLow,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    isCollapsed: true,
                  ),
                  dropdownMenuEntries: [for (final n in widget.numbers) DropdownMenuEntry<String>(value: n, label: n)],
                  onSelected: (value) => setState(() => number = value ?? ''),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (prefixInUse)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                l10n.settings_callerId_duplicate_dialcode_error,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: isValid
                    ? () {
                        if (prefix.isNotEmpty && number.isNotEmpty) {
                          widget.onSave(prefix, number);
                        }
                      }
                    : null,
                child: Text(l10n.settings_callerId_save_button),
              ),
              const SizedBox(width: 16),
              ElevatedButton(onPressed: widget.onCancel, child: Text(l10n.settings_callerId_cancel_button)),
            ],
          ),
        ],
      ),
    );
  }
}
