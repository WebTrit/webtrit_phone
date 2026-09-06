import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Gives [identifier] to the semantics node of the closest ancestor that owns
/// one, instead of forming a node of its own.
///
/// This exists for controls whose node is built by a widget we do not own and
/// cannot wrap - the entries of a [BottomNavigationBar], for instance, where
/// the bar itself builds the node that carries the caption and the press. The
/// ordinary way to attach an id, `Semantics(identifier: ...)`, is no help
/// there: an identifier implicitly introduces a node of its own, so the id
/// would end up on an empty node inside the entry, where a screen reader has
/// nothing to announce and automation has nothing to press.
///
/// Use it only when the id cannot be declared on the control itself. Where the
/// subtree can be wrapped, [SemanticAction] is the right tool: it merges name,
/// id and action together instead of relying on an ancestor to pick the id up.
///
/// The ancestor keeps whatever id it already has - an id declared closer to the
/// node wins over this one.
class SemanticIdOfAncestor extends SingleChildRenderObjectWidget {
  const SemanticIdOfAncestor({super.key, required this.identifier, required Widget super.child});

  /// Stable, non-localized automation id (exposed as the platform resource id).
  final String identifier;

  @override
  RenderSemanticIdOfAncestor createRenderObject(BuildContext context) =>
      RenderSemanticIdOfAncestor(identifier: identifier);

  @override
  void updateRenderObject(BuildContext context, RenderSemanticIdOfAncestor renderObject) {
    renderObject.identifier = identifier;
  }
}

/// Render object of [SemanticIdOfAncestor].
class RenderSemanticIdOfAncestor extends RenderProxyBox {
  RenderSemanticIdOfAncestor({required String identifier}) : _identifier = identifier;

  String get identifier => _identifier;
  String _identifier;

  set identifier(String value) {
    if (_identifier == value) return;
    _identifier = value;
    markNeedsSemanticsUpdate();
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    // Deliberately no `isSemanticBoundary`: the description is absorbed by the
    // node above, which is the whole point of this widget.
    config.identifier = _identifier;
  }
}
