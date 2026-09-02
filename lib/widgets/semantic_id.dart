import 'package:flutter/material.dart';

/// Attaches a stable [identifier] to [child] and changes nothing else about
/// how the subtree is announced.
///
/// Two cases need this instead of [SemanticAction]:
/// * a screen anchor - the whole body of a screen gets an id, so a flow can
///   tell which screen it is looking at before touching any control (the
///   visible captions are no help: "Proceed" names the button on four
///   different login screens);
/// * a text field - a field must keep its own node, because merging the
///   subtree would swallow the activation of whatever its decoration hosts,
///   such as the password visibility toggle.
///
/// Never wrap a plain tap target in it: an identifier forces its own semantics
/// boundary, so the id would end up on a node above the one that carries the
/// activation. [SemanticAction] merges the two together and exists for that.
class SemanticId extends StatelessWidget {
  const SemanticId({super.key, required this.identifier, required this.child});

  /// Stable, non-localized automation id (exposed as the platform resource id).
  final String identifier;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(identifier: identifier, container: true, child: child);
  }
}
