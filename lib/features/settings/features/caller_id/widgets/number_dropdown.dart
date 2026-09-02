import 'package:flutter/material.dart';

/// The chooser of a phone number on the caller id screen.
///
/// Both forms on that screen offer the same control and used to spell its look
/// out again each time, thirteen lines apiece, which is how the two copies drift
/// apart. The look lives here instead; the entries, the current value and what
/// happens on a pick stay with the form that owns them.
///
/// It carries no name of its own: a chooser announces the value it happens to
/// show, so the form wraps it in a `SemanticAction` that says what the value is
/// for. See docs/accessibility.md.
///
/// The chosen number is spoken by this widget rather than left to the field
/// inside it. On the web the framework drops the field from the tree whenever
/// the chooser behaves as a button - which is what `selectOnly` makes it
/// everywhere - and the chosen value would go with it, leaving a control that
/// says what it is for but never what it holds.
class NumberDropdown<T> extends StatelessWidget {
  const NumberDropdown({
    super.key,
    required this.entries,
    required this.onSelected,
    this.initialSelection,
    this.value,
    this.hintText,
    this.width,
  });

  final List<DropdownMenuEntry<T>> entries;
  final ValueChanged<T?> onSelected;
  final T? initialSelection;

  /// What is chosen right now, as it should be spoken. The form owns it: in one
  /// of them the choice lives in the settings, in the other only in the form
  /// until it is submitted.
  final String? value;
  final String? hintText;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(16);

    return Semantics(
      value: value,
      child: DropdownMenu<T>(
        // The chooser offers a list and nothing else: it is not a field to type
        // into, and off mobile it would otherwise become one.
        selectOnly: true,
        width: width,
        hintText: hintText,
        initialSelection: initialSelection,
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(colorScheme.surfaceContainerLow),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: radius)),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
        ),
        textStyle: TextStyle(color: colorScheme.onSurface, fontSize: 14),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: radius, borderSide: BorderSide.none),
          filled: true,
          fillColor: colorScheme.surfaceContainerLow,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          isCollapsed: true,
        ),
        dropdownMenuEntries: entries,
        onSelected: onSelected,
      ),
    );
  }
}
