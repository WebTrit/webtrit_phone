import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../favorites.dart';

/// Whether the favourites rows can be dragged, and the drag in flight.
///
/// Owned by a controller rather than by a screen because two screens draw the
/// same list and offer the same rearranging: the favourites section, and the
/// contacts section of a deployment that offers favourites in its chooser. A
/// copy per screen drifts - and the rule for leaving the mode is the subtle
/// part, not the flag.
class FavoritesReorderController extends ChangeNotifier {
  bool _active = false;
  int? _draggingIndex;

  /// Whether the rows are draggable now.
  bool get active => _active;

  void toggle() {
    _active = !_active;
    notifyListeners();
  }

  /// Ends the mode. Used where a screen moves on to something the mode cannot
  /// apply to - another list, say.
  void stop() {
    if (!_active && _draggingIndex == null) return;
    _active = false;
    _draggingIndex = null;
    notifyListeners();
  }

  void dragStarted(int index) => _draggingIndex = index;

  void dragEnded(int index) => _draggingIndex = null;

  /// Leaves the mode when the list changed underneath it: a move that landed
  /// while a row was being dragged, and a list that became too short to
  /// rearrange - the button is the only way out and is not offered below the
  /// minimum, so the rows would stay locked.
  void listChanged(int count) {
    if (_draggingIndex != null || (_active && count < FavoritesList.reorderMinimum)) stop();
  }
}

/// The button that turns rearranging on, in the state it is in.
///
/// A screen places it in its own scaffold - a floating button is a scaffold
/// slot, not something a list can hand over - but what it looks like, what it
/// says and when it is worth offering are decided here.
class FavoritesReorderButton extends StatelessWidget {
  const FavoritesReorderButton({
    super.key,
    required this.controller,
    required this.identifier,
    this.bottomPadding = 0,
    this.hidden = false,
  });

  final FavoritesReorderController controller;

  /// The anchor automation reaches this button by. Each screen names its own,
  /// so a flow cannot pass against whichever of them happens to be on screen.
  final String identifier;

  /// What the button leaves clear beneath it. The tab bar of the main screen
  /// floats over the page, and without this the button is drawn underneath -
  /// invisible, and every tap goes to the bar.
  final double bottomPadding;

  /// Set where a screen has something else to say with its bottom edge.
  final bool hidden;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listenWhen: (previous, current) => previous.favorites != current.favorites,
      listener: (context, state) => controller.listChanged(state.favorites?.length ?? 0),
      builder: (context, state) {
        final favorites = state.favorites;
        if (hidden || favorites == null || favorites.length < FavoritesList.reorderMinimum) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: ListenableBuilder(
            listenable: controller,
            builder: (context, _) {
              // Only the icon said what this does, and it says two different
              // things depending on whether rearranging is already under way.
              return SemanticAction(
                label: controller.active
                    ? context.l10n.favorites_SemanticsLabel_reorderDone
                    : context.l10n.favorites_SemanticsLabel_reorder,
                identifier: identifier,
                child: FloatingActionButton(
                  shape: const CircleBorder(),
                  onPressed: controller.toggle,
                  child: Icon(controller.active ? Icons.check : Icons.edit_note_outlined),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
