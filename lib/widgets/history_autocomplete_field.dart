import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

// TODO: Refactor: Remove the internal `_HistoryStore` to externalize history management.
// Instead, pass the historical options (e.g., `Iterable<String> options`) as a parameter,
// and handle history persistence (adding/loading) outside this widget.
// This change would enhance flexibility, allowing different storage mechanisms or
// business logic for history, and improve separation of concerns by removing direct
// `SharedPreferences` usage from the widget, which is generally considered bad practice.
class _HistoryStore {
  _HistoryStore(this.key, {this.maxItems = 8});

  final String key;
  final int maxItems;

  /// Loads the history list from [SharedPreferences].
  Future<List<String>> load() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  /// Adds a new value to the history.
  ///
  /// This method trims the value, ignores empty strings, removes
  /// case-insensitive duplicates, adds the new value to the top,
  /// and truncates the list to [maxItems].
  Future<void> add(String value) async {
    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    final List<String> history = await load();

    history.removeWhere((item) => item.toLowerCase() == trimmedValue.toLowerCase());
    history.insert(0, trimmedValue);

    final truncatedHistory = history.length > maxItems ? history.sublist(0, maxItems) : history;

    await prefs.setStringList(key, truncatedHistory);
  }
}

/// A [TextFormField] that provides autocomplete suggestions from a
/// persistent local history and integrates with system autofill.
class HistoryAutocompleteField extends StatefulWidget {
  const HistoryAutocompleteField({
    super.key,
    required this.storageKey,
    required this.labelText,
    this.maxItems = 8,
    this.initialValue,
    this.errorText,
    this.enabled = true,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.onChanged,
    this.onSubmit,
  });

  /// The key used to store the history in [SharedPreferences].
  final String storageKey;

  /// The label for the [InputDecoration].
  final String labelText;

  /// The maximum number of history items to keep.
  final int maxItems;

  /// Optional prefilled text.
  final String? initialValue;

  /// Optional error text to display below the field.
  final String? errorText;

  /// Whether the field is enabled.
  final bool enabled;

  /// Passed through to the internal [TextFormField].
  final TextInputType? keyboardType;

  /// Passed through to the internal [TextFormField].
  final TextInputAction? textInputAction;

  /// Passed through to the internal [TextFormField].
  final List<String>? autofillHints;

  /// Callback for when the value changes.
  final ValueChanged<String>? onChanged;

  /// Callback for when the field is submitted (e.g., "Done" on keyboard).
  final VoidCallback? onSubmit;

  @override
  State<HistoryAutocompleteField> createState() => _HistoryAutocompleteFieldState();
}

class _HistoryAutocompleteFieldState extends State<HistoryAutocompleteField> {
  late _HistoryStore _historyStore;
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _historyStore = _HistoryStore(widget.storageKey, maxItems: widget.maxItems);
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(HistoryAutocompleteField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.storageKey != oldWidget.storageKey || widget.maxItems != oldWidget.maxItems) {
      _historyStore = _HistoryStore(widget.storageKey, maxItems: widget.maxItems);
    }

    if (widget.initialValue != oldWidget.initialValue && widget.initialValue != _controller.text) {
      final newText = widget.initialValue ?? '';
      _controller.text = newText;
      _controller.selection = TextSelection.fromPosition(TextPosition(offset: newText.length));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<List<String>> _getSuggestions(TextEditingValue textEditingValue) async {
    final query = textEditingValue.text.trim();
    if (query.isEmpty) return [];

    final history = await _historyStore.load();
    return history.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
  }

  void _handleSubmit() {
    final currentValue = _controller.text;
    FocusScope.of(context).unfocus();
    TextInput.finishAutofillContext(shouldSave: true);
    _historyStore.add(currentValue);
    widget.onSubmit?.call();
  }

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      textEditingController: _controller,
      focusNode: _focusNode,
      optionsBuilder: _getSuggestions,
      onSelected: (String selection) {
        _controller.text = selection;
        widget.onChanged?.call(selection);
      },
      fieldViewBuilder:
          (
            BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return AutofillGroup(
              child: TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                enabled: widget.enabled,
                decoration: InputDecoration(
                  labelText: widget.labelText,
                  helperText: '',
                  errorText: widget.errorText,
                  errorMaxLines: 3,
                ),
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                autofillHints: widget.autofillHints,
                autocorrect: false,
                onChanged: widget.onChanged,
                onFieldSubmitted: (_) {
                  onFieldSubmitted();
                  _handleSubmit();
                },
              ),
            );
          },
      optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Card(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 240),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return ListTile(dense: true, title: Text(option), onTap: () => onSelected(option));
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
