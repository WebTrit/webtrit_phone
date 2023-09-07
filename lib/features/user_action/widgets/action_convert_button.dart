import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../../call/view/call_shell.dart';

class ActionConvertButton {
  ActionConvertButton({
    required this.stickyPadding,
    required this.size,
    this.onTap,
    Offset? offset,
  }) : _offset = offset;

  final EdgeInsets stickyPadding;
  final GestureTapCallback? onTap;
  final Size size;
  Offset? _offset;
  OverlayEntry? _entry;

  bool get inserted => _entry != null;

  void insert(BuildContext context) {
    assert(_entry == null);
    final theme = Theme.of(context);

    final entry = OverlayEntry(
      builder: (context) {
        return DraggableThumbnail(
          stickyPadding: stickyPadding,
          initialOffset: _offset,
          onOffsetUpdate: (offset) {
            _offset = offset;
          },
          onTap: onTap,
          child: Material(
            color: Colors.transparent,
            child: Card(
              margin: EdgeInsets.zero,
              color: theme.colorScheme.primary,
              child: Container(
                padding: const EdgeInsets.all(8),
                width: size.width,
                height: size.height,
                child: Center(
                  child: Text(
                    context.l10n.connectToYourOwnVoIPSystem_Button_Action,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    _entry = entry;
    Overlay.of(context).insert(entry);
  }

  void remove() {
    assert(_entry != null);

    _entry!.remove();
    _entry = null;
  }
}
