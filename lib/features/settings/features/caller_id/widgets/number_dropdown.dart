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
class NumberDropdown<T> extends StatelessWidget {
  const NumberDropdown({
    super.key,
    required this.entries,
    required this.onSelected,
    this.initialSelection,
    this.hintText,
    this.width,
  });

  final List<DropdownMenuEntry<T>> entries;
  final ValueChanged<T?> onSelected;
  final T? initialSelection;
  final String? hintText;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(16);

    return DropdownMenu<T>(
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
    );
  }
}
