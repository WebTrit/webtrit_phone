import 'package:flutter/material.dart';

/// Builds its child with the answer to "is a screen reader in use", ignoring
/// the moments when the platform cannot be trusted with that question.
///
/// The platform reports the screen reader as off whenever another window takes
/// over - a permission dialog is enough - so the answer is refreshed only while
/// the app is in front, and taken again on the way back, since the reader may
/// well have been switched on or off while away. The very first reading is
/// taken whatever the state of the app is: it is still unknown on the frames
/// right after a cold start, and waiting for it would report no reader for as
/// long as the screen lives.
class ScreenReaderBuilder extends StatefulWidget {
  const ScreenReaderBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, bool screenReaderOn) builder;

  @override
  State<ScreenReaderBuilder> createState() => _ScreenReaderBuilderState();
}

class _ScreenReaderBuilderState extends State<ScreenReaderBuilder> with WidgetsBindingObserver {
  /// The last trustworthy answer; null until the first reading.
  bool? _screenReaderOn;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Runs on every change of the ambient data, which is how switching the
    // reader on and off mid-screen arrives (a rebuild follows this callback).
    _read();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) setState(_read);
  }

  void _read() {
    if (_screenReaderOn != null && WidgetsBinding.instance.lifecycleState != AppLifecycleState.resumed) return;
    _screenReaderOn = MediaQuery.accessibleNavigationOf(context);
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _screenReaderOn ?? false);
}
