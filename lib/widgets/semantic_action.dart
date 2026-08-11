import 'package:flutter/material.dart';

/// Attaches an accessibility [label] and a stable [identifier] to the single
/// interactive control in [child].
///
/// The whole subtree is merged into one semantics node, so the label, the
/// identifier and the activation action are guaranteed to end up on the same
/// node. A plain `Semantics(identifier: ...)` wrapper must never be used for
/// this: an identifier forces its own semantics boundary, which produces a
/// node that carries the identifier but no action, while the action stays on
/// an inner nameless node (screen readers then announce a bare "button" and
/// UI automation cannot target the control by its id).
///
/// [child] must contain exactly one interactive control: merging a subtree
/// with several tappable descendants would collapse them into a single node.
///
/// Set [button] for tap targets that are not built from button widgets
/// (`GestureDetector`, `InkWell`), so assistive technology announces a role;
/// controls that already are buttons keep their role through the merge.
class SemanticAction extends StatelessWidget {
  const SemanticAction({super.key, this.label, this.identifier, this.button = false, required this.child});

  /// Spoken name of the control; omit when the control already exposes a
  /// proper visible or semantic label of its own.
  final String? label;

  /// Stable, non-localized automation id (exposed as the platform resource
  /// id); use the `...Id` constant paired with the control's widget key.
  final String? identifier;

  /// Whether to add the button role to the merged node.
  final bool button;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Semantics(label: label, identifier: identifier, button: button ? true : null, child: child),
    );
  }
}
