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
    this.onDismissed,
    this.iconConstraints,
  });

  /// Automation id of the search field itself, read from the accessibility
  /// tree by the on-device tests.
  ///
  /// Supplied by the screen rather than baked in here: the same field serves
  /// the contact list and the conversation list, and two controls answering to
  /// one id is a trap for whoever writes the test. Left out, the field simply
  /// carries no id - which is what the conversation list does until its own
  /// naming lands.
  final String? identifier;

  /// Widget key of the clear button, used by the tests that run inside the app
  /// (they address widgets by key, not by accessibility id).
  final Key? clearButtonKey;

  /// Automation id of the clear button, kept apart from [identifier] so a test
  /// can tell the box from the cross that empties it - merging the two into one
  /// control would leave no way to press just the cross.
  ///
  /// Its spoken name is not a parameter: "clear search" reads the same on every
  /// screen, so it lives in this widget.
  final String? clearButtonIdentifier;

  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  /// Called when the cross is pressed on a box that is already empty, for a
  /// screen where the box is something you leave rather than something that
  /// is always there.
  ///
  /// Supplying it also keeps the cross on screen while the box is empty -
  /// without that there would be nothing to press, and no way back.
  final VoidCallback? onDismissed;
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
          suffixIcon: _isEmpty && widget.onDismissed == null
              ? null
              : SemanticAction(
                  label: context.l10n.contacts_SemanticsLabel_clearSearch,
                  identifier: widget.clearButtonIdentifier,
                  child: IconButton(
                    key: widget.clearButtonKey,
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      // Empties the box on the first press and closes it on
                      // the next, so one control both undoes a search and
                      // leaves it - and neither is reached by guessing.
                      if (_isEmpty) return widget.onDismissed?.call();

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
