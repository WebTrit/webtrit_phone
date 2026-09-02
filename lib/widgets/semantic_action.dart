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
/// Pick the constructor by what [child] is built from: the default one for
/// controls that already announce their own role (`IconButton`, `TextButton`,
/// ...), [SemanticAction.button] for tap targets that carry no semantic role
/// of their own (`GestureDetector`, `InkWell`) so the role gets added.
class SemanticAction extends StatelessWidget {
  /// Names a control that already announces its own role.
  const SemanticAction({super.key, this.label, this.identifier, required this.child}) : _button = false;

  /// Names a bare tap target and adds the button role to the merged node.
  const SemanticAction.button({super.key, this.label, this.identifier, required this.child}) : _button = true;

  /// Spoken name of the control; omit when the control already exposes a
  /// proper visible or semantic label of its own.
  final String? label;

  /// Stable, non-localized automation id (exposed as the platform resource
  /// id); use the `...Id` constant paired with the control's widget key.
  final String? identifier;

  final bool _button;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Semantics(label: label, identifier: identifier, button: _button ? true : null, child: child),
    );
  }
}
