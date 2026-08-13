import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class ClearedTextField extends StatefulWidget {
  const ClearedTextField({
    super.key,
    this.identifier,
    this.clearButtonKey,
    this.clearButtonIdentifier,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.iconConstraints,
  });

  /// Anchors of the field and of its clear button, supplied by the screen:
  /// this field is used on more than one screen, so an anchor baked in here
  /// would appear twice.
  final String? identifier;
  final Key? clearButtonKey;
  final String? clearButtonIdentifier;

  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final BoxConstraints? iconConstraints;

  @override
  ClearedTextFieldState createState() => ClearedTextFieldState();
}

class ClearedTextFieldState extends State<ClearedTextField> {
  final _controller = TextEditingController();
  late bool _isEmpty;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue ?? '';
    _isEmpty = widget.initialValue?.isEmpty ?? true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final InputDecorations? inputDecorations = themeData.extension<InputDecorations>();
    final iconConstraints = widget.iconConstraints;
    final field = Ink(
      decoration: BoxDecoration(
        color: themeData.colorScheme.surfaceBright,
        borderRadius: iconConstraints == null ? null : BorderRadius.circular(iconConstraints.minHeight / 2),
      ),
      child: TextField(
        controller: _controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: inputDecorations?.search?.copyWith(
          prefixIcon: const Icon(Icons.search),
          prefixIconConstraints: iconConstraints,
          suffixIcon: _isEmpty
              ? null
              : SemanticAction(
                  label: context.l10n.contacts_SemanticsLabel_clearSearch,
                  identifier: widget.clearButtonIdentifier,
                  child: IconButton(
                    key: widget.clearButtonKey,
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _isEmpty = true;
                      });
                      _controller.clear();
                      widget.onChanged?.call('');
                    },
                    constraints: iconConstraints,
                  ),
                ),
          suffixIconConstraints: iconConstraints,
        ),
        textInputAction: TextInputAction.search,
        onChanged: (value) {
          setState(() {
            _isEmpty = value.isEmpty;
          });
          widget.onChanged?.call(value);
        },
        onSubmitted: (value) => widget.onSubmitted?.call(value),
      ),
    );

    final identifier = widget.identifier;
    if (identifier == null) return field;

    // Plain Semantics rather than a merging wrapper: merging would pull the
    // clear button into the field and leave the search box with no way to be
    // typed into by name.
    return SemanticId(identifier: identifier, child: field);
  }
}
